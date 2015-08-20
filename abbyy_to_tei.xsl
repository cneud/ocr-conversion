<!-- Source: http://discoveryspace.upei.ca/islandlives.ca/node/130 -->
<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://fr7.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml" xpath-default-namespace="http://fr7.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" />

    <!-- Require the MARC id as a parameter marcid=XXXXXX -->
    <xsl:param name="marcid" required="yes" />

    <!-- =================================================================== -->
    <!-- 	Document root                                                    -->
    <!-- =================================================================== -->

    <xsl:template match="/">
        <xsl:text>&#10;</xsl:text>
        <xsl:processing-instruction name="oxygen">
            <xsl:text>RNGSchema="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/teilite.rng" type="xml"</xsl:text>
        </xsl:processing-instruction>
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:text>&#10;</xsl:text>
            <!-- We're include the TEI header that was transformed from the MARC record into a -->
            <!-- temporary file at /tmp/tei_header.xml -->
            <xsl:copy-of select="document('/tmp/tei_header.xml')" />
            <xsl:text>&#10;</xsl:text>
            <text>
                <xsl:text>&#10;</xsl:text>

                <body>
                    <xsl:text>&#10;</xsl:text>
                    <xsl:apply-templates select="document/page" />
                </body>
            </text>
            <xsl:text>&#10;</xsl:text>
        </TEI>
    </xsl:template>

    <xsl:template match="page">
        <div type="page" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="position()-1" /></xsl:attribute>
            <xsl:text>&#10;</xsl:text>
            <xsl:comment>This is scanned page number
                <xsl:value-of select="position()-1" /> of the work
                <xsl:value-of select="$marcid" />.</xsl:comment>
            <xsl:text>&#10;</xsl:text>
            <pb xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="position()-1" /></xsl:attribute>
                <!--	<xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute>
				<xsl:attribute name="facs">/fedora/repository/ilives:<xsl:value-of select="$marcid"/>-<xsl:number value="position()-1" format="000"/>/JP2/JP2.jp2</xsl:attribute> -->
            </pb>
            <xsl:apply-templates/>
        </div>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="block[@blockType='Text']">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="generate-id()" /></xsl:attribute>
            <!-- <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> -->
            <xsl:attribute name="rend">
                <xsl:value-of select="@l" />,
                <xsl:value-of select="@t" />,
                <xsl:value-of select="@r" />,
                <xsl:value-of select="@b" /></xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="block[@blockType='Text']/text/par">
        <p xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="generate-id()" /></xsl:attribute>
            <!-- <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!--
	<xsl:template match="block[@blockType='Text']/text/par/line">
		<seg xmlns="http://www.tei-c.org/ns/1.0">
			<xsl:attribute name="n"><xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:attribute name="rend"><xsl:value-of select="@l"/>,<xsl:value-of select="@t"/>,<xsl:value-of select="@r"/>,<xsl:value-of select="@b"/></xsl:attribute>
			<xsl:apply-templates/><lb xmlns="http://www.tei-c.org/ns/1.0"/>		
		</seg>
	</xsl:template>
	-->
    <xsl:template match="block[@blockType='Table']">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <table xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="generate-id()" /></xsl:attribute>
                <!--	<xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> -->
                <xsl:attribute name="rend">
                    <xsl:value-of select="@l" />,
                    <xsl:value-of select="@t" />,
                    <xsl:value-of select="@r" />,
                    <xsl:value-of select="@b" /></xsl:attribute>
                <xsl:apply-templates/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="row">
        <row xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="generate-id()" /></xsl:attribute>
            <!--		<xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> -->
            <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="cell">
        <cell xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>

    <xsl:template match="block[@blockType='Picture']">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:text>&#10;</xsl:text>
            <figure xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="generate-id()" /></xsl:attribute>
                <!--	<xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> -->
                <xsl:attribute name="rend">
                    <xsl:value-of select="@l" />,
                    <xsl:value-of select="@t" />,
                    <xsl:value-of select="@r" />,
                    <xsl:value-of select="@b" /></xsl:attribute>
                <xsl:text>&#10;</xsl:text>
                <xsl:apply-templates/>
            </figure>
            <xsl:text>&#10;</xsl:text>
        </div>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="block[@blockType='Picture']/region/rect">
        <graphic xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="generate-id()" /></xsl:attribute>
            <xsl:attribute name="rend">
                <xsl:value-of select="@l" />,
                <xsl:value-of select="@t" />,
                <xsl:value-of select="@r" />,
                <xsl:value-of select="@b" /></xsl:attribute>
            <xsl:text>&#10;</xsl:text>
            <!-- <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute> 
			<xsl:attribute name="width"><xsl:value-of select="@r - @l"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="@b - @t"/></xsl:attribute>
			<xsl:attribute name="url">/fedora/repository/ilives:<xsl:value-of select="$marcid"/>-<xsl:number value="count(ancestor::page/preceding-sibling::*)+1" format="000" />-<xsl:number level="any" count="block[@blockType='Picture']/region/rect" from="page" format="000" />/JPG/JPG.jpg</xsl:attribute> -->
            <xsl:apply-templates/>
        </graphic>
    </xsl:template>

</xsl:stylesheet>