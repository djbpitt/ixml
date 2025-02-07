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
    <xsl:variable name="beiges" as="xs:string+" select="'#fff0db', '#faf0e6'"/>
    <xsl:template match="/">
        <!--<xsl:message select="serialize($chapter-word-counts, map {'method': 'json', 'indent': true()})"/>-->
        <svg viewBox="-10 -310 1020 320">
            <!-- x axis -->
            <line x1="0" y1="0" x2="1000" y2="0" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <!-- y axis and vertical lines at chapter boundaries as percentages -->
            <line x1="0" y1="0" x2="0" y2="-300" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <xsl:for-each select="map:keys($chapter-word-counts)">
                <xsl:variable name="current-x" as="xs:double"
                    select="((1 to current()) ! $chapter-word-counts(.) => sum()) * 1000 div $total-word-count"/>
                <xsl:variable name="previous-x" as="xs:double"
                    select="((1 to current() - 1) ! $chapter-word-counts(.) => sum()) * 1000 div $total-word-count"/>
                <xsl:variable name="chapter-word-count" as="xs:integer"
                    select="$chapter-word-counts(current())"/>
                <xsl:variable name="chapter-word-count-percentage" as="xs:string"
                    select="($chapter-word-count div $total-word-count * 100) => format-number('0.00')"/>
                <rect x="{$previous-x}" y="-300" width="{$current-x - $previous-x}" height="300"
                    fill="{$beiges[current() mod 2 + 1]}">
                    <title>
                        <xsl:value-of select="
                                concat('Chapter ', current(), '  ', $chapter-word-count, ' words (',
                                $chapter-word-count-percentage, '%)')"/>
                    </title>
                </rect>
                <xsl:variable name="x-pos" as="xs:double" select="$current-x"/>
                <line x1="{$x-pos}" y1="0" x2="{$x-pos}" y2="-300" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
            </xsl:for-each>
        </svg>
    </xsl:template>
    <xsl:template match="chapter-body">
        <xsl:map-entry key="position()" select="normalize-space(.) => tokenize() => count()"/>
    </xsl:template>
</xsl:stylesheet>
