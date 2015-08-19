<?xml version="1.0" ?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:abbyy="http://fr7.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml">
    <xsl:output method="xml" />
    <xsl:template match="abbyy:document">
        <xsl:for-each select="abbyy:page">
            <xsl:result-document href="output-{position()}.html">
                <html>

                <head>
                    <meta name='ocr-id' value='abbyy' />
                    <meta name='ocr-recognized' value='lines text' />
                </head>

                <body>

                    <xsl:variable name="pagewidth">
                        <xsl:value-of select="@width" /></xsl:variable>
                    <xsl:variable name="pageheight">
                        <xsl:value-of select="@height" /></xsl:variable>
                    <xsl:variable name="pageId">
                        <xsl:number from="/" level="any" count="abbyy:page" /></xsl:variable>

                    <div class="ocr_page" id="page_{$pageId}" title="bbox 0 0 {$pagewidth} {$pageheight}">
                        <xsl:for-each select="abbyy:block[@blockType='Text']">
                            <xsl:variable name="x0">
                                <xsl:value-of select="@l" /></xsl:variable>
                            <xsl:variable name="y0">
                                <xsl:value-of select="@t" /></xsl:variable>
                            <xsl:variable name="x1">
                                <xsl:value-of select="@r" /></xsl:variable>
                            <xsl:variable name="y1">
                                <xsl:value-of select="@b" /></xsl:variable>

                            <div class="ocr_carea" title="bbox {$x0} {$y0} {$x1} {$y1}">
                                <xsl:for-each select="abbyy:text/abbyy:par">
                                    <p>
                                        <xsl:for-each select="abbyy:line">
                                            <xsl:variable name="lineId">
                                                <xsl:number from="/" level="any" count="abbyy:line" /></xsl:variable>
                                            <xsl:variable name="lx0">
                                                <xsl:value-of select="@l" /></xsl:variable>
                                            <xsl:variable name="ly0">
                                                <xsl:value-of select="@t" /></xsl:variable>
                                            <xsl:variable name="lx1">
                                                <xsl:value-of select="@r" /></xsl:variable>
                                            <xsl:variable name="ly1">
                                                <xsl:value-of select="@b" /></xsl:variable>
                                            <span class="ocr_line" id="line_{$lineId}" title="bbox {$lx0} {$ly0} {$lx1} {$ly1}">
                            <xsl:apply-templates select="abbyy:charParams[@wordStart='true']"/>
                            <!--<xsl:variable name="xBoxes">
                                <xsl:value-of separator=" " select="(*[@l]|*[@t]|*[@r]|*[@b])[text()]" />
                            </xsl:variable>
                           <span class="ocr_cinfo" title="x_boxes {$xBoxes}"></span>-->
                                            </span>
                                        </xsl:for-each>
                                    </p>
                                </xsl:for-each>
                            </div>
                        </xsl:for-each>
                    </div>
                </body>

                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="abbyy:charParams[@wordStart='true']">
        <xsl:param name="place" select="count(preceding-sibling::abbyy:charParams[@wordStart='true'])" />
        <xsl:param name="wordNodes" select=" current() |  following-sibling::abbyy:charParams[normalize-space(.) and @wordStart='false' and (count(preceding-sibling::abbyy:charParams[@wordStart='true']) = ($place+1))]" />
        <!--xsl:param name="wordId"><xsl:number from="/" level="any" count="abbyy:charParams[@wordStart='true']" /></xsl:param-->
        <xsl:param name="wordlx0">
            <xsl:for-each select="$wordNodes">
                <xsl:sort select="@l" data-type="number" order="ascending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="@l" />
                </xsl:if>
            </xsl:for-each>
        </xsl:param>

        <xsl:param name="wordlx1">
            <xsl:for-each select="$wordNodes">
                <xsl:sort select="@r" data-type="number" order="descending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="@r" />
                </xsl:if>
            </xsl:for-each>
        </xsl:param>

        <xsl:param name="wordly0">
            <xsl:for-each select="$wordNodes">
                <xsl:sort select="@t" data-type="number" order="ascending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="@t" />
                </xsl:if>
            </xsl:for-each>
        </xsl:param>

        <xsl:param name="wordly1">
            <xsl:for-each select="$wordNodes">
                <xsl:sort select="@b" data-type="number" order="descending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="@b" />
                </xsl:if>
            </xsl:for-each>
        </xsl:param>

        <span class="ocr_word" id="word_{position()}" title="bbox {$wordlx0} {$wordly0} {$wordlx1} {$wordly1}"><xsl:apply-templates mode="foo" select="$wordNodes"/></span>
        <!--xsl:value-of select="position()"/>:<xsl:value-of select="count(preceding-sibling::*)"/>: <xsl:apply-templates/-->
    </xsl:template>
    <xsl:template match="abbyy:charParams" mode="foo">
        <xsl:value-of select="." />
    </xsl:template>
</xsl:stylesheet>