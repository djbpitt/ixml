<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Templates                                                          -->
  <!-- ================================================================== -->
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:template match="chapter">
    <!-- ================================================================ -->
    <!-- Works for both table of contents and body                        -->
    <!-- ================================================================ -->
    <xsl:variable name="prefix" as="xs:string" select="
        if (name(..) eq 'contents') then
          'toc'
        else
          'body'"/>
    <xsl:copy>
      <xsl:attribute name="id" select="concat($prefix, '-', count(preceding-sibling::chapter) + 1)"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
