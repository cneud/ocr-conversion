OCR conversion scripts
======================

Collected scripts and stylesheets for conversion between various OCR formats

#### ABBYY
 * [`abbyy2hocr.xsl`](https://gist.github.com/tfmorris/5977784) - ABBYY FineReader XML to hOCR converter [@Rod Page](http://iphylo.blogspot.com/2011/07/correcting-ocr-using-hocr-firefox.html#comment-400434491)
 * [`teip5-v5.xsl`](http://discoveryspace.upei.ca/islandlives.ca/sites/discoveryspace.upei.ca.islandlives.ca/files/teip5-v5.xsl) - Transform ABBYY Finereader XML into TEI [@UPEI](http://discoveryspace.upei.ca/islandlives.ca/node/130)
 * [`ocr_to_teifacsimile.xsl`](https://github.com/emory-libraries/readux/blob/master/readux/books/ocr_to_teifacsimile.xsl) - Generate page-level TEI facsimile from Abbyy OCR xml or METS/ALTO [@readux](https://github.com/emory-libraries/readux)
 
#### ALTO
 * [`alto2tei.xsl`](https://github.com/INL/OpenConvert/blob/master/resources/xsl/alto2tei.xsl) - Output TEI from ALTO input format [@OpenConvert](https://github.com/INL/OpenConvert) 
 * [`AltoToTeiA.xsl`](https://github.com/collex/typewright/blob/master/lib/saxon/AltoToTeiA.xsl) - For Gale OCR XML or 18thConnect Typewright XML files [@typewright](https://github.com/collex/typewright)
 * [`ocr_to_teifacsimile.xsl`](https://github.com/emory-libraries/readux/blob/master/readux/books/ocr_to_teifacsimile.xsl) - Generate page-level TEI facsimile from Abbyy OCR xml or METS/ALTO [@readux](https://github.com/emory-libraries/readux)
 * [`alto2hocr.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/alto2hocr.xsl) - Convert ALTO 2.0 / ALTO 2.1 to hOCR [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`alto2text.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/alto2text.xsl) - Convert ALTO 2.0 / ALTO 2.1 to plain text [@filak]
 
#### hOCR
 * [`hOCR2ALTO.xsl`](https://github.com/ONB-RD/hOCRTools/blob/master/xsl/hOCR2ALTO.xsl) - Utilities to process and handle hOCR [@ONB-RD](https://github.com/ONB-RD/hOCRTools)
 * [`hocr2alto2.0.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2alto2.0.xsl) - Convert hOCR to ALTO 2.0 [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`hocr2alto2.1.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2alto2.1.xsl) - Convert hOCR to ALTO 2.1 [@filak](https://github.com/filak/hOCR-to-ALTO)
 * [`hocr2tei.xsl`](https://github.com/TEIC/Hackathon/blob/master/DH2015/xsl/hocr2tei.xsl) - Stylesheet to take hOCR from Tesseract and produce basic TEI output [@DH2015](https://github.com/TEIC/Hackathon/tree/master/DH2015)
 * [`hocr2text.xsl`](https://github.com/filak/hOCR-to-ALTO/blob/master/hocr2text.xsl) Convert hOCR to plain text [@filak](https://github.com/filak/hOCR-to-ALTO)
 
#### PAGE
 * [`xml_to_box.xsl`](https://github.com/idhmc-tamu/eMOP/blob/master/xml_to_box.xsl) - Convert PAGE XML to Tesseract box file from [eMOP](https://github.com/idhmc-tamu/eMOP)
