<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <xsl:output method="text"/>
  <xsl:template name="xsl:initial-template">
    <xsl:param name="input" as="xs:string" select="unparsed-text('non-xml-characters.txt')"/>
    <xsl:value-of select="$input"/>
  </xsl:template>
</xsl:stylesheet>
