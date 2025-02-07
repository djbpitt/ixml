<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:variable name="chapter-word-counts" as="map(*)">
        <xsl:map>
            <xsl:apply-templates select="descendant::chapter-body"/>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="total-word-count" as="xs:integer" select="
            map:for-each($chapter-word-counts, function ($k, $v) {
                $v
            }) => sum()"/>
    <xsl:template match="/">
        <!--<xsl:message select="serialize($chapter-word-counts, map {'method': 'json', 'indent': true()})"/>-->
        <svg viewBox="10 -1000 {$total-word-count - 10} 1000">
            <!-- x axis -->
            <line x1="0" y1="0" x2="{$total-word-count}" y2="0" stroke="black" stroke-width="2"
                stroke-linecap="butt"/>
            <!-- y axis and vertical lines at chapter boundaries -->
            <xsl:for-each select="map:keys($chapter-word-counts)">
                <xsl:variable name="x-pos" as="xs:integer" select="(1 to .) ! $chapter-word-counts(.) => sum()"/>
                <line x1="{$x-pos}" y1="0" x2="{$x-pos}" y2="1000" stroke="black" stroke-width="10"/>
            </xsl:for-each>
        </svg>
    </xsl:template>
    <xsl:template match="chapter-body">
        <xsl:map-entry key="position()" select="normalize-space(.) => tokenize() => count()"/>
    </xsl:template>
</xsl:stylesheet>
