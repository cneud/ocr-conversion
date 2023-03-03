OCR conversion
==============

Collection of scripts and stylesheets for conversion between various OCR formats. 

You may also want to check out the excellent [ocr-fileformat](https://github.com/UB-Mannheim/ocr-fileformat) by [@UB-Mannheim](https://github.com/UB-Mannheim).

#### ABBYY
 * [`abbyy2hocr.xsl`](https://gist.github.com/tfmorris/5977784) - ABBYY FineReader XML to hOCR converter [@Rod Page](http://iphylo.blogspot.com/2011/07/correcting-ocr-using-hocr-firefox.html#comment-400434491)
  * [`abbyy2hocr.xsl`](https://github.com/OCR-D/format-converters/blob/master/abbyy2hocr.xsl) - ABBYY FineReader XML to hOCR converter by [@Rod Page](http://iphylo.blogspot.com/2011/07/correcting-ocr-using-hocr-firefox.html#comment-400434491) - updated by [@OCR-D](https://github.com/OCR-D)
  * [`abbyy-to-hocr`](https://git.archive.org/merlijn/archive-hocr-tools/-/blob/master/bin/abbyy-to-hocr) - ABBYY FineReader XML to hOCR converter by [@merlijn](https://git.archive.org/merlijn)
 * [`teip5-v5.xsl`](http://discoveryspace.upei.ca/islandlives.ca/sites/discoveryspace.upei.ca.islandlives.ca/files/teip5-v5.xsl) - Transform ABBYY Finereader XML into TEI [@UPEI](http://discoveryspace.upei.ca/islandlives.ca/node/130)
 * [`ABBYY_to_TEI_by_XMLReader.php`](http://able.myspecies.info/abbyy-xml-tei-xml) - Convert ABBYY XML to TEI using PHP's XMLReader [@able-project](http://able.myspecies.info/abbyy-xml-tei-xml)
 * [`ocr_to_teifacsimile.xsl`](https://github.com/emory-libraries/readux/blob/master/readux/books/ocr_to_teifacsimile.xsl) - Generate page-level TEI facsimile from Abbyy OCR xml or METS/ALTO [@readux](https://github.com/emory-libraries/readux)
 * [`AbbyyToAlto.php`](https://github.com/ironymark/AbbyyToAlto/blob/master/AbbyyToAlto.php) - PHP5 to convert Abbyy FineReader XML into ALTO XML [@ironymark](https://github.com/ironymark/AbbyyToAlto)
 * [`AbbyyToAltoConverter.java`](https://github.com/Mewel/abbyy-to-alto) - Java library to convert abbyy.xml (v10) to alto.xml (v2) [@abbyy-to-alto](https://github.com/Mewel/abbyy-to-alto)
 
#### ALTO
 * [`alto2tei.xsl`](https://github.com/INL/OpenConvert/blob/master/resources/xsl/alto2tei.xsl) - Output TEI from ALTO input format [@OpenConvert](https://github.com/INL/OpenConvert) 
 * [`AltoToTeiA.xsl`](https://github.com/collex/typewright/blob/master/lib/saxon/AltoToTeiA.xsl) - For Gale OCR XML or 18thConnect Typewright XML files [@typewright](https://github.com/collex/typewright)
 * [`ocr_to_teifacsimile.xsl`](https://github.com/emory-libraries/readux/blob/master/readux/books/ocr_to_teifacsimile.xsl) - Generate page-level TEI facsimile from Abbyy OCR xml or METS/ALTO [@readux](https://github.com/emory-libraries/readux)
 * [`alto2hocr.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/alto2hocr.xsl) - Convert ALTO 2.0 / ALTO 2.1 to hOCR [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`alto2text.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/alto2text.xsl) - Convert ALTO 2.0 / ALTO 2.1 to plain text [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`alto_ocr_text.py`](https://github.com/cneud/alto-ocr-text/blob/master/alto_ocr_text.py) - Extracts the text from an ALTO file and writes it to stdout [@cneud](https://github.com/cneud/alto-ocr-text)
 * [`ALTO2HTML.bat`](https://github.com/altomator/ALTO-HTML) - Batch script to convert ALTO files to HTML [@altomator](https://github.com/altomator/ALTO-HTML)
 * [`dinglehopper-extract`](https://github.com/qurator-spk/dinglehopper) - Extracts the text from ALTO and PAGE XML files [@qurator-spk](https://github.com/qurator-spk/)
 
#### hOCR
 * [`hOCR2ALTO.xsl`](https://github.com/ONB-RD/hOCRTools/blob/master/xsl/hOCR2ALTO.xsl) - Utilities to process and handle hOCR [@ONB-RD](https://github.com/ONB-RD/hOCRTools)
 * [`hocr2alto2.0.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2alto2.0.xsl) - Convert hOCR to ALTO 2.0 [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`hocr2alto2.1.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2alto2.1.xsl) - Convert hOCR to ALTO 2.1 [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`hocr2tei.xsl`](https://github.com/TEIC/Hackathon/blob/master/DH2015/xsl/hocr2tei.xsl) - Convert hOCR from Tesseract to basic TEI output [@DH2015](https://github.com/TEIC/Hackathon/tree/master/DH2015)
  * [`hocr2tei.xsl`](https://github.com/OCR-D/format-converters/blob/master/hocr2tei.xsl) - Convert hOCR from Tesseract to basic TEI output from [@DH2015](https://github.com/TEIC/Hackathon/tree/master/DH2015) - updated by [@OCR-D](https://github.com/OCR-D)
 * [`hocr2text.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2text.xsl) Convert hOCR to plain text [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`HocrConverter.py`](https://github.com/jbrinley/HocrConverter/blob/master/HocrConverter.py) - Create a PDF from an hOCR file and an image [@jbrinley](https://github.com/jbrinley/HocrConverter)
 
#### PAGE
 * [`PageConverter.java`](https://github.com/PRImA-Research-Lab/prima-page-converter) - Convert ALTO XML, FineReader XML, and hOCR to the latest PAGE XML format [@prima](https://github.com/PRImA-Research-Lab/prima-page-converter)
 * [`xml_to_box.xsl`](https://github.com/idhmc-tamu/eMOP/blob/master/xml_to_box.xsl) - Convert PAGE XML to Tesseract box file [@eMOP](https://github.com/idhmc-tamu/eMOP)
 * [`page_to_text.py`](https://github.com/cneud/page-to-text/blob/master/page_to_text.py) - Extracts the text from a PAGE file and writes it to stdout [@cneud](https://github.com/cneud/page-to-text)
 * [`PageToPdfConverter.java`](https://github.com/PRImA-Research-Lab/prima-page-to-pdf) - Convert PAGE XML files with layout and text content to PDF [@prima](https://github.com/PRImA-Research-Lab/prima-page-to-pdf)
 * [`page2tei-0.xsl`](https://github.com/dariok/page2tei/blob/master/page2tei-0.xsl) - Convert PAGE XML to TEI [@dariok](https://github.com/dariok/page2tei)
 * [`PageToAlto.xsl`](https://github.com/Transkribus/TranskribusCore/blob/master/src/main/resources/xslt/PageToAlto.xsl) - Convert PAGE XML to ALTO [@Transkribus](https://github.com/Transkribus)
 * [`dinglehopper-extract`](https://github.com/qurator-spk/dinglehopper) - Extracts the text from ALTO and PAGE XML files [@qurator-spk](https://github.com/qurator-spk/)
 
#### TEI
 * [`tei2txt.xsl`](https://github.com/haoess/dta-tools/blob/master/tei2txt/share/xslt/tei2txt.xsl) - Convert DTA TEI-P5 to plain text [@haoess](https://github.com/haoess/dta-tools)
 * [`tei2hocr.xsl`](https://github.com/jbaiter/tei2hocr/blob/master/tei2hocr.xsl) - Convert DTA TEI-P5 to hOCR [@jbaiter](https://github.com/jbaiter/tei2hocr)

#### Other
* [`iw2alto.xsl`](https://github.com/karkraeg/im2alto/blob/main/iw2alto.xsl) - Convert [ImageWare MyBib eL OCR](https://www.imageware.de/produkte/mybib-el-allgemein/) to ALTO [@karkraeg](https://github.com/karkraeg/im2alto)
* [`transkribus-xslt`](https://gitlab.com/readcoop/transkribus/TranskribusCore/-/tree/master/src/main/resources/xslt) - Various stylesheets from Transkribus [@readcoop](https://gitlab.com/readcoop/)
