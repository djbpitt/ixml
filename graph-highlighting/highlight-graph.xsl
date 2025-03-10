<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:g="http://xmlcalabash.com/ns/description"
                xmlns:dot="http://xmlcalabash.com/ns/dot"
                version="3.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:mode on-no-match="shallow-copy"/>

<xsl:template match="g:graph//g:input[@primary='true']">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="dot:bgcolor" select="'#aaffaa'"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="g:graph//g:edge">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:if test="@input='source' or @output='result'">
      <xsl:attribute name="dot:color" select="'#ff0000'"/>
      <xsl:attribute name="dot:penwidth" select="2"/>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
