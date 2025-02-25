<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Note default namespace setting above                               -->
  <!-- ================================================================== -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Sonnets</title>
      </head>
      <body>
        <h1>Sonnets</h1>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="sonnet">
    <section>
      <xsl:apply-templates select="number"/>
      <p>
        <xsl:apply-templates select="lines"/>
      </p>
    </section>
  </xsl:template>
  <xsl:template match="number">
    <h2>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  <xsl:template match="line">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::line">
      <br/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
