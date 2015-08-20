<!-- Source: https://github.com/idhmc-tamu/eMOP -->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:pr="http://schema.primaresearch.org/PAGE/gts/pagecontent/2010-03-19"
    version="1.0">
    <xsl:output method="text" omit-xml-declaration="yes" />
    
    <xsl:variable name="imageHeight" select="number(//pr:Page/@imageHeight)"/>
    <xsl:variable name="imageWidth" select="number(//pr:Page/@imageWidth)"/>
    
    <xsl:template match="pr:Glyph">
        <xsl:value-of select="pr:TextEquiv/pr:Unicode/."/>
        <xsl:text> </xsl:text>
        <!-- get left -->
        <xsl:for-each select="pr:Coords/pr:Point">
            <xsl:sort select="@x" data-type="number" order="ascending"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="@x"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <!-- get bottom -->
        <xsl:for-each select="pr:Coords/pr:Point">
            <xsl:sort select="@y" data-type="number" order="descending"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="$imageHeight - @y"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <!-- get right -->
        <xsl:for-each select="pr:Coords/pr:Point">
            <xsl:sort select="@x" data-type="number" order="descending"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="@x"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <!-- get top -->
        <xsl:for-each select="pr:Coords/pr:Point">
            <xsl:sort select="@y" data-type="number" order="ascending"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="$imageHeight - @y"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text> 0</xsl:text> <!-- not sure what this is -->
        <xsl:text>&#xa;</xsl:text>  <!-- line break -->
    </xsl:template>
    
    <xsl:template match="/">        
        <xsl:apply-templates select="//pr:Glyph"/>
    </xsl:template>
</xsl:stylesheet>
