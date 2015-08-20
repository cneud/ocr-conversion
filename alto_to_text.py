#!/usr/bin/env python
# Open an ALTO (xml) file and print the text to stdout.
# Source: https://github.com/KBNLresearch/europeananp-ner

import os
import sys
import glob
import codecs
import locale
import urllib
import tempfile

import xml.etree.ElementTree as ET

sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)
TMPDIR = tempfile.gettempdir()


def xml_to_xmltree(alto_filename):
    ''' Convert xml file to element tree '''
    alto_file = open(alto_filename, "rb")
    sys.stdout.write("Converting %s to text\n" % alto_filename)
    alto_data = alto_file.read()

    try:
        ET.fromstring(alto_data)
    except ET.ParseError as e:
        sys.stdout.write("Failed parsing %s, aborting\n" % alto_filename)
        sys.stdout.write(e.message)
        sys.exit(-1)

    alto_file.close()
    return ET.fromstring(alto_data)


def get_textblock_range(xmltree_alto_data, start, end):
    ''' Get all the block-id's within the range '''
    blocks = []

    is_in_range = False

    for item in xmltree_alto_data.iter():
        if item.tag.endswith("TextBlock"):
            if is_in_range:
                blocks.append(item.attrib.get("ID"))
            if item.attrib.get("ID") == start:
                blocks.append(start)
                is_in_range = True
            if item.attrib.get("ID") == end:
                is_in_range = False
                blocks.append(end)

    if not (end or start) in blocks:
        return []

    return blocks


def alto_to_disk(alto_filename, blocks=[],
                 blocks_range=False, output_filename=""):

    ''' Grab the selected text blocks and write them to disk '''
    xmltree_alto_data = xml_to_xmltree(alto_filename)

    # Check if the given blocks are actually in the ALTO file.
    if blocks_range:
        # Reassign blocks with all the text-blocks in the specified range.
        blocks = get_textblock_range(xmltree_alto_data, blocks[0], blocks[1])
        if len(blocks) == 0:
            sys.stdout.write(
                    "Error: Could not find a range spanning from %s to %s, aborting\n" % (blocks[0], blocks[1]))
            usage()
    elif len(blocks) > 0:
        for item in blocks:
            if len(get_textblock_range(xmltree_alto_data, item, item)) == 0:
                sys.stdout.write("Error: Could not find block %s, aborting\n" % item)
                usage()

    alto_text = u""
    prev_was_hyp = False

    total_words = 0
    block_words = 0

    if len(blocks) == 0:
        print_all_blocks = True
    else:
        print_all_blocks = False

    print_current_block = None

    for item in xmltree_alto_data.iter():
        if item.tag.endswith("TextBlock"):
            if item.attrib.get("ID") in blocks:
                print_current_block = item

        if item.tag.endswith("String"):
            if prev_was_hyp:
                if print_current_block is not None or print_all_blocks:
                    alto_text += item.get("CONTENT")
                    block_words += 1
                prev_was_hyp = False
            else:
                if print_current_block is not None or print_all_blocks:
                    alto_text += " " + item.get("CONTENT")
                    block_words += 1
                total_words += 1

        if item.tag.endswith("HYP"):
            prev_was_hyp = True

        if item.tag.endswith("TextBlock"):
            if print_current_block is not None and print_current_block != item:
                print_current_block = None
            if print_current_block is not None or print_all_blocks:
                if len(alto_text) > 0:
                    alto_text += "\n"

    sys.stdout.write("Total number of words: %s\n" % str(total_words))
    sys.stdout.write("Block words: %s\n" % str(block_words))

    text_outputfilename = alto_filename.split(os.sep)[-1].split('.')[0] + ".txt"
    sys.stdout.write("Writing to %s\n" % (text_outputfilename))

    if os.path.isfile(text_outputfilename):
        sys.stdout.write("Warning: %s already exists, overwriting file\n" % text_outputfilename)
    text_outputfile = codecs.open(text_outputfilename, "wb", "utf-8")
    text_outputfile.write(alto_text)
    text_outputfile.close()
    sys.stdout.write("Wrote %s bytes to %s\n" % (
                     str(len(alto_text)), text_outputfilename))


def parse_arguments():
    blocks = False
    alto_files = []
    fetch_via_http = False
    output_filename = ""

    arguments = sys.argv[1:]

    for item in arguments:
        if item.startswith('--'):
            if not item.find('=') > -1:
                sys.stdout.write("Could not parse argument %s, missing '=' sign.\n" % item)
                usage()
            param_name = item[2:].lower().split('=')[0]
            param_value = item.split('=')[1]

            if param_name == 'blocks':
                blocks = param_value

            if param_name == 'output':
                output_filename = param_value
        else:
            if item.lower().startswith('http'):
                alto_files.append(item)
                fetch_via_http = True
            else:
                fetch_via_http = False
                for item in glob.glob(item):
                    alto_files.append(item)

    return blocks, alto_files, fetch_via_http, output_filename


def alto_to_text():
    blocks, alto_files, fetch_via_http, output_filename = parse_arguments()

    if blocks:
        if blocks.find('-') > -1 and blocks.find(',') <= -1:
            blocks = [blocks.split('-')[0], blocks.split('-')[1]]
            block_range = True
        else:
            blocks = blocks.split(',')
            block_range = False
    else:
        blocks = []
        block_range = False

    if len(alto_files) <= 0 and not fetch_via_http:
        sys.stdout.write("No ALTO files found in path %s\n" % sys.argv[1])
        usage()

    if fetch_via_http:
        for url in sys.argv[1:]:
            data = urllib.urlopen(url).read()
            filename = url.split('/')[-1].split('.')[0]
            fh = open(TMPDIR + os.sep + filename, 'wb')
            fh.write(data)
            fh.close()
            alto_to_disk(TMPDIR + os.sep + filename, blocks, block_range, output_filename)
    else:
        for alto_filename in alto_files:
            alto_to_disk(alto_filename, blocks, block_range, output_filename)


def usage():
    sys.stdout.write("Usage: %s [--blocks=a,b,c --blocks=a-c] [--output=/path_to_output_file] path_to_alto_files\n\n" % sys.argv[0])
    sys.stdout.write("The (optional) blocks parameter is used to extract only certain parts of the ALTO document.\n")
    sys.exit(-1)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        alto_to_text()
    else:
        usage()