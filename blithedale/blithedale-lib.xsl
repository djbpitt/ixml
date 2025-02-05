<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
  version="3.0">
  <!-- ==================================================================
       Functions
       ================================================================== -->
  <!-- ==================================================================
       djb:title-case : convert uppercase title to titlecase
       ================================================================== -->
  <xsl:function name="djb:title-case" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:value-of select="
        tokenize($input)
        ! concat(substring(., 1, 1), lower-case(substring(., 2)))"/>
  </xsl:function>
</xsl:stylesheet>
