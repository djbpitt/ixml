<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <xsl:variable name="bar-width" as="xs:integer" select="10"/>
  <xsl:variable name="y-scale" as="xs:integer" select="1"/>
  <xsl:variable name="max-width" as="xs:integer"
    select="$bar-width * count(distinct-values(descendant::year)) + 20"/>
  <xsl:template match="/">
    <svg viewBox="-10, -150 {$max-width} 160">
      <style type="text/css"><![CDATA[
        :root {
          background-color: #ffe4b4;
        }]]></style>
      <xsl:for-each-group select="descendant::film[runtime ne 'N/A']" group-by="year">
        <xsl:variable name="x-pos" as="xs:integer" select="(position() - 1) * $bar-width"/>
        <xsl:variable name="height" as="xs:double"
          select="(current-group()/runtime => avg()) * $y-scale"/>
        <rect x="{$x-pos}" y="-{$height}" width="{$bar-width}" height="{$height}" fill="lightblue"
          stroke="black" stroke-width="1">
          <title>
            <xsl:value-of select="
                concat(
                'Year: ', current-grouping-key(), '&#x0a;',
                'Avg runtime: ', round($height), ' min&#x0a;',
                'Number of films: ', count(current-group())
                )"/>
          </title>
        </rect>
        <text x="{$x-pos + $bar-width div 2}" y="-{$height + 5}" text-anchor="middle"
          font-size="40%">
          <xsl:value-of select="round($height)"/>
        </text>
        <xsl:if test="number(current-grouping-key()) mod 10 = 0 or position() = last()">
          <text x="{$x-pos + $bar-width div 2}" y="15" text-anchor="middle" font-size="60%">
            <xsl:value-of select="current-grouping-key()"/>
          </text>
        </xsl:if>
      </xsl:for-each-group>
      <text x="{$max-width div 2}" y="35" text-anchor="middle">Average runtime by year</text>
    </svg>
  </xsl:template>
</xsl:stylesheet>
