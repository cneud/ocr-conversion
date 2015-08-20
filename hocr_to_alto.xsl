<!-- source: https://github.com/ONB-RD/hOCRTools -->
<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:h="http://www.w3.org/1999/xhtml" xmlns:o="http://www.onb.ac.at/lib/xslt" xmlns:a="http://www.loc.gov/standards/alto/ns-v2#" xmlns="http://www.loc.gov/standards/alto/ns-v2#" exclude-result-prefixes="xs o a" version="2.0">

    <xsl:import href="hOCRUtil.xsl" />
    <!-- https://github.com/ONB-RD/hOCRTools/blob/master/xsl/hOCRUtil.xsl -->
    <!--
        the following parameters are effective in hOCRUtil.xsl
    -->
    <!--
        $OCRHOffset: offset by how much the OCR is off on the horizontal axis.
                     This will be subtracted from the respective values of the
                     of the OCR bounding box.             
     -->
    <xsl:param name="OCRHOffset" as="xs:integer">0</xsl:param>
    <!--
        $OCRVOffset: offset by how much the OCR is off on the vertical axis.
                     This will be subtracted from the respective values of the
                     OCR bounding box.             
     -->
    <xsl:param name="OCRVOffset" as="xs:integer">0</xsl:param>

    <!--
        $aspectThresholdIllustration: float defining the factor of how much
        bigger the taller edge of the illustration might be such that it is an
        Illustration and not a GraphicalElement as delimiters typically are.
        default: 5, cannot be 0
    -->
    <xsl:param name="aspectThresholdIllustration" as="xs:float">5</xsl:param>
    <xsl:variable name="aspectThresholdIllustrationDivisor" as="xs:float">
        <xsl:choose>
            <xsl:when test="$aspectThresholdIllustration &lt; 0">
                <xsl:value-of select="xs:float(1) div $aspectThresholdIllustration" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$aspectThresholdIllustration" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:output indent="yes" />

    <!-- match html document and start alto output -->
    <xsl:template match="h:html">
        <alto xsi:schemaLocation="http://www.loc.gov/standards/alto/ns-v2# http://www.loc.gov/standards/alto/v2/alto-2-0.xsd">
            <Description>
                <MeasurementUnit>pixel</MeasurementUnit>
            </Description>
            <Layout>
                <xsl:apply-templates select="h:body/*" />
            </Layout>
        </alto>
    </xsl:template>

    <!-- process ocr_page hOCR annotation bearing elements -->
    <xsl:template match="h:*[@class='ocr_page']">
        <xsl:variable name="bbox">
            <xsl:call-template name="getBbox" />
        </xsl:variable>
        <xsl:variable name="pageNo">
            <xsl:call-template name="getPpageno" />
        </xsl:variable>
        <!-- the aggregation of all OCR Dimensions to define the printed area bounding box -->
        <xsl:variable name="printSpaceDim">
            <xsl:call-template name="getAggregateDimensions" />
        </xsl:variable>
        <Page>
            <xsl:attribute name="HEIGHT">
                <xsl:value-of select="o:bboxGetHeight($bbox)" /></xsl:attribute>
            <xsl:attribute name="WIDTH">
                <xsl:value-of select="o:bboxGetWidth($bbox)" /></xsl:attribute>
            <xsl:attribute name="PHYSICAL_IMG_NR">
                <xsl:call-template name="getPpageno" />
            </xsl:attribute>
            <xsl:attribute name="ID">PageImg_
                <xsl:value-of select="$pageNo" /></xsl:attribute>
            <PrintSpace>
                <xsl:attribute name="WIDTH" select="o:bboxGetWidth($printSpaceDim)" />
                <xsl:attribute name="HEIGHT" select="o:bboxGetHeight($printSpaceDim)" />
                <xsl:attribute name="HPOS" select="o:bboxGetX($printSpaceDim)" />
                <xsl:attribute name="VPOS" select="o:bboxGetY($printSpaceDim)" />
                <xsl:apply-templates/>
            </PrintSpace>
        </Page>
    </xsl:template>

    <!-- process ocrx_block ocr_carea or the deprecated ocr_block and output a ComposedBlock -->
    <xsl:template match="h:*[@class eq 'ocrx_block' or @class eq 'ocr_carea' or @class eq 'ocr_block']">
        <ComposedBlock>
            <xsl:call-template name="makePositionAttributes" />
            <xsl:attribute name="ID" select="concat('block_',generate-id(.))" />
            <xsl:apply-templates/>
        </ComposedBlock>
    </xsl:template>

    <!-- process ocr_par, for GBS purposes empty (printing characters present //text()) blocks are output as either GraphicalElement or Illustration
    all other ocr_par are output as TextBlock
    -->
    <xsl:template match="h:*[@class='ocr_par']">
        <xsl:variable name="blocktype">
            <xsl:choose>
                <xsl:when test="matches(.,'\p{L}|\p{N}|\p{S}|\p{P}')">TextBlock</xsl:when>
                <!-- nested, as we don't need the variables at top level -->
                <xsl:otherwise>
                    <xsl:variable name="bbox">
                        <xsl:call-template name="getBbox" />
                    </xsl:variable>
                    <xsl:variable name="aspectRatio" select="xs:float(o:bboxGetWidth($bbox)) div o:bboxGetHeight($bbox)" />
                    <xsl:choose>
                        <xsl:when test="$aspectRatio &gt; xs:float(1) div $aspectThresholdIllustrationDivisor and $aspectRatio &lt; $aspectThresholdIllustration">Illustration</xsl:when>
                        <xsl:otherwise>GraphicalElement</xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$blocktype}">
            <xsl:call-template name="makePositionAttributes" />
            <xsl:attribute name="ID" select="concat('block_',generate-id(.))" />
            <xsl:if test="$blocktype eq 'TextBlock'">
                <xsl:apply-templates/>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <!-- process ocr_line bearing elements output TextLine -->
    <xsl:template match="h:*[@class='ocr_line']">
        <TextLine>
            <xsl:call-template name="makePositionAttributes" />
            <xsl:apply-templates/>
        </TextLine>
    </xsl:template>

    <!-- process ocrx_word -->
    <!-- TODO missing distinction between String and SP -->
    <xsl:template match="h:*[@class='ocrx_word' and .//text()]">
        <String>
            <xsl:call-template name="makePositionAttributes" />
            <xsl:attribute name="CONTENT" select="." />
            <xsl:if test="o:hasTitleParam(./@title, 'x_wconf')">
                <xsl:variable name="wordConf">
                    <xsl:call-template name="getWconf" />
                </xsl:variable>
                <xsl:attribute name="WC" select="$wordConf/o:val div 100" />
            </xsl:if>
        </String>
    </xsl:template>

    <!-- process &#xad; aka &shy; or SOFT HYPHEN -->
    <xsl:template match="text()[parent::h:*[@class eq 'ocr_line'] and . eq '&#xad;']">
        <HYP CONTENT="{.}" />
    </xsl:template>

    <!--
        make attributes WIDTH HEIGHT VPOS HPOS from hOCR bbox parameters 
        $titleElem: element with hOCR @title, defaults to.
        return: attribute()+
    -->
    <xsl:template name="makePositionAttributes">
        <xsl:param name="titleElem" select="." />
        <xsl:variable name="bbox">
            <xsl:call-template name="getBbox" />
        </xsl:variable>
        <xsl:attribute name="WIDTH" select="o:bboxGetWidth($bbox)" />
        <xsl:attribute name="HEIGHT" select="o:bboxGetHeight($bbox)" />
        <xsl:attribute name="VPOS" select="o:bboxGetY($bbox)" />
        <xsl:attribute name="HPOS" select="o:bboxGetX($bbox)" />
    </xsl:template>
</xsl:stylesheet>