<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ==================================================================
       Templates
       ================================================================== -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="descendant::front/title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="blithedale.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  <!-- ==================================================================
       Front matter
       ================================================================== -->
  <xsl:template match="front">
    <header>
      <xsl:apply-templates/>
    </header>
  </xsl:template>
  <xsl:template match="title">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>
  <xsl:template match="author">
    <p id="author">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <!-- ==================================================================
       Table of contents
       ================================================================== -->
  <xsl:template match="contents">
    <nav>
      <xsl:apply-templates mode="contents"/>
    </nav>
  </xsl:template>
  <xsl:template match="header" mode="contents">
    <h2>
      <xsl:apply-templates mode="contents"/>
    </h2>
  </xsl:template>
  <xsl:template match="chapters" mode="contents">
    <ol>
      <xsl:apply-templates mode="contents"/>
    </ol>
  </xsl:template>
  <xsl:template match="chapter" mode="contents">
    <li>
      <a href="#body-{substring-after(@id, '-')}">
        <xsl:apply-templates/>
      </a>
    </li>
  </xsl:template>
  <!-- ==================================================================
       Body
       ================================================================== -->
  <xsl:template match="body">
    <main>
      <xsl:apply-templates/>
    </main>
  </xsl:template>
  <xsl:template match="chapter">
    <section id="{@id}">
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  <xsl:template match="chapter-header">
    <h2>
      <xsl:value-of select="count(../preceding-sibling::chapter) + 1"/>
      <xsl:text>. </xsl:text>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  <xsl:template match="paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="q">
    <q>
      <xsl:apply-templates/>
    </q>
  </xsl:template>
</xsl:stylesheet>
