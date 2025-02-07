<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Functions                                                          -->
  <!-- ================================================================== -->
  <!-- ================================================================== -->
  <!-- djb:title-case : convert uppercase title to titlecase              -->
  <!-- ================================================================== -->
  <xsl:function name="djb:title-case" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:variable name="parts" as="xs:string+">
      <xsl:analyze-string select="$input" regex="[- ]">
        <xsl:matching-substring>
          <xsl:value-of select="."/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:value-of select="djb:title-case-token(.)"/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:value-of select="string-join($parts) => djb:upper-case-first()"/>
  </xsl:function>
  <!-- ================================================================== -->
  <!-- djb:title-case-token : lower-case single word token if function    -->
  <!-- word, otherwise title-case; see https://titlecaseconverter.com     -->
  <!-- ================================================================== -->
  <xsl:function name="djb:title-case-token" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:variable name="function-words" as="xs:string+" select="
        'A',
        'AND',
        'AS',
        'AT',
        'BUT',
        'BY',
        'FOR',
        'FROM',
        'IN',
        'INTO',
        'NOT',
        'OF',
        'OFF',
        'ON',
        'OR',
        'OUT',
        'SO',
        'THE',
        'TO',
        'UNTO',
        'UP',
        'VIA',
        'WITH',
        'YET'"/>
    <xsl:value-of select="
        if ($input = $function-words) then
          lower-case($input)
        else
          concat(substring($input, 1, 1), lower-case(substring($input, 2)))
        "/>
  </xsl:function>
  <!-- ================================================================== -->
  <!-- djb:upper-case-first : upper-case first character in string        -->
  <!-- ================================================================== -->
  <xsl:function name="djb:upper-case-first" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:value-of select="concat(upper-case(substring($input, 1, 1)), substring($input, 2))"/>
  </xsl:function>
  <!-- ================================================================== -->
  <!-- djb:explode-string : map string to sequence of single characters   -->
  <!-- ================================================================== -->
  <xsl:function name="djb:explode-string" as="xs:string+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:sequence select="string-to-codepoints($input) ! codepoints-to-string(.)"/>
  </xsl:function>
</xsl:stylesheet>
