<!-- Source: https://github.com/INL/OpenConvert -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:alto="http://www.loc.gov/standards/alto/ns-v3#" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="tei" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:param name="generateIds">true</xsl:param>
    <xsl:param name="scale">1</xsl:param>
    <xsl:template name="setIdNoFacs">
        <xsl:if test="@ID or $generateIds='true'">
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="@ID">
                        <xsl:value-of select="@ID" />
                    </xsl:when>
                    <xsl:otherwise>e<xsl:number level="any" count="*" /></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="setId">
        <xsl:if test="@ID or $generateIds='true'">
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="@ID">
                        <xsl:value-of select="@ID" />
                    </xsl:when>
                    <xsl:otherwise>e<xsl:number level="any" count="*" /></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="facs">
                <xsl:choose>
                    <xsl:when test="@ID">#f<xsl:value-of select="@ID" /></xsl:when>
                    <xsl:otherwise>#f<xsl:number level="any" count="*" /></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@STYLEREFS">
            <xsl:attribute name="rendition">#<xsl:value-of select="@STYLEREFS" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@STYLE">
            <xsl:attribute name="rend">
                <xsl:value-of select="@STYLE" />
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="setId_facs">
        <xsl:if test="@ID or $generateIds='true'">
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="@ID">f<xsl:value-of select="@ID" /></xsl:when>
                    <xsl:otherwise>f<xsl:number level="any" count="*" /></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>TEI file</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>(Information about distribution of the resource)</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>(Information about source from which the resource derives)</p>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <tagsDecl>
                        <xsl:for-each select=".//*[local-name()='TextStyle']">
                            <rendition scheme="other">
                                <xsl:call-template name="setIdNoFacs" />
                                <xsl:for-each select="@*">
                                    <xsl:value-of select="name(.)" /> : <xsl:value-of select="." />;
                                </xsl:for-each>
                            </rendition>
                            <xsl:text></xsl:text>
                        </xsl:for-each>
                    </tagsDecl>
                </encodingDesc>
            </teiHeader>
            <facsimile>
                <surface>
                    <xsl:apply-templates select=".//*[local-name()='Layout']" mode="facsimile" />
                </surface>
            </facsimile>
            <text>
                <body>
                    <div>
                        <xsl:apply-templates select=".//*[local-name()='Layout']" />
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
    <xsl:template match="*[local-name()='Layout']">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="*[local-name()='TextBlock']">
        <ab>
            <xsl:attribute name="type">
                <xsl:value-of select="name(.)" />
            </xsl:attribute>
            <xsl:call-template name="setId" />
            <xsl:apply-templates />
        </ab>
    </xsl:template>
    <xsl:template match="*[local-name()='TextLine']">
        <xsl:apply-templates />
        <lb>
            <xsl:call-template name="setId" />
        </lb>
    </xsl:template>
    <xsl:template match="*[local-name()='SP']">
        <xsl:text></xsl:text>
    </xsl:template>
    <xsl:template match="*[local-name()='String'][@SUBS_TYPE='HypPart1']">
        <reg>
            <xsl:attribute name="orig">
                <xsl:value-of select="@CONTENT" />|<xsl:variable name="s1"><xsl:value-of select="@CONTENT" /></xsl:variable><xsl:variable name="s2"><xsl:value-of select="@SUBS_CONTENT" /></xsl:variable><xsl:value-of select="substring-after($s2,$s1)" /></xsl:attribute>
            <w>
                <xsl:call-template name="setId" />
                <xsl:value-of select="@SUBS_CONTENT" />
            </w>
        </reg>
    </xsl:template>
    <xsl:template match="*[local-name()='String'][@SUBS_TYPE='HypPart2']" />
    <xsl:template match="*[local-name()='String']">
        <w>
            <xsl:call-template name="setId" />
            <xsl:value-of select="@CONTENT" />
        </w>
    </xsl:template>
    <xsl:function name="ns:scaleCoordinates">
        <xsl:param name="value" as="xs:integer" />
        <xsl:value-of select="$value * $scale" />
    </xsl:function>
    <xsl:template match="*[local-name()='Layout' or local-name()='PrintSpace' or local-name()='Page' or local-name()='TextLine' or local-name()='Page' or local-name()='TextBlock' or local-name()='String']" mode="facsimile">
        <tei:zone>
            <xsl:attribute name="type">
                <xsl:value-of select="name(.)" />
            </xsl:attribute>
            <xsl:call-template name="setId_facs" />
            <xsl:if test="@HPOS and @WIDTH">
                <xsl:attribute name="ulx" select="ns:scaleCoordinates(xs:integer(@HPOS))" />
                <xsl:attribute name="uly" select="ns:scaleCoordinates(xs:integer(@VPOS))" />
                <xsl:attribute name="lrx" select="ns:scaleCoordinates(xs:integer(@HPOS)) + ns:scaleCoordinates(xs:integer(@WIDTH))" />
                <xsl:attribute name="lry" select="ns:scaleCoordinates(xs:integer(@VPOS)) + ns:scaleCoordinates(xs:integer(@HEIGHT))" />
            </xsl:if>
            <xsl:apply-templates mode="#current" />
        </tei:zone>
    </xsl:template>
</xsl:stylesheet>