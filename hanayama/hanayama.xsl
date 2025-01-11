<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ================================================================== -->
  <!-- Housekeeping                                                       -->
  <!-- ================================================================== -->
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
    indent="yes"/>
  <!-- ================================================================== -->
  <!-- Global variables                                                   -->
  <!-- ================================================================== -->
  <xsl:variable name="yearRegex" as="xs:string" select="'\d{4}|NA'"/>
  <!-- ================================================================== -->
  <!-- Main template                                                      -->
  <!-- ================================================================== -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Hanayama puzzle inventory</title>
        <style>
          :root {
            background-color: ivory;
          }
          table,
          tr,
          td,
          th {
            border: 1px solid black;
          }
          table {
            border-collapse: collapse;
          }
          th,
          td {
            padding: 3px 4px;
          }
          .name,
          .level {
            font-weight: bold;
          }</style>
      </head>
      <body>
        <h1>Hanayama puzzle inventory</h1>
        <hr/>
        <h2>Huzzles</h2>
        <!-- ============================================================ -->
        <!-- Merge sections 1–6 in single table                           -->
        <!-- ============================================================ -->
        <table>
          <tr>
            <th>Name</th>
            <th>Level</th>
            <th>Designer</th>
            <th>Year</th>
          </tr>
          <xsl:apply-templates select="hanayama/section[position() le 6]/descendant::puzzle"
            mode="huzzle"/>
        </table>
        <!-- ============================================================ -->
        <!-- Each other section (7–11) is separate, so use template       -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="hanayama/section[7]"/>
        <xsl:apply-templates select="hanayama/section[position() gt 7]"/>
      </body>
    </html>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Mode huzzle (sections 1–6)                                         -->
  <!-- puzzleData is always (designer year), with no note                 -->
  <!-- ================================================================== -->
  <xsl:template match="puzzle" mode="huzzle">
    <tr>
      <xsl:apply-templates select="name, ancestor::section/category" mode="cell"/>
      <xsl:apply-templates select="puzzleData" mode="huzzle"/>
    </tr>
  </xsl:template>
  <xsl:template match="puzzleData" mode="huzzle">
    <xsl:variable name="huzzleRegex" as="xs:string" select="concat('^(.+) (', $yearRegex, ')$')"/>
    <xsl:variable name="parts" select="analyze-string(., $huzzleRegex)"/>
    <xsl:for-each select="$parts/fn:match/fn:group">
      <td>
        <xsl:value-of select="."/>
      </td>
    </xsl:for-each>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Chess (section 7)                                                  -->
  <!-- ================================================================== -->
  <xsl:template match="section[7]">
    <hr/>
    <h2>
      <xsl:apply-templates select="category"/>
    </h2>
    <table>
      <tr>
        <th>Name</th>
        <th>Level</th>
        <th>Designer</th>
      </tr>
      <xsl:apply-templates select="puzzles/puzzle" mode="chess"/>
    </table>
  </xsl:template>
  <xsl:template match="puzzle" mode="chess">
    <tr>
      <xsl:apply-templates select="name, level, designer" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Ultraman, Zelda, Disney (sections 8–10)                            -->
  <!-- basedOn, note, and noteOnly are mutually exclusive note fields     -->
  <!-- ================================================================== -->
  <xsl:template match="section[position() = (8, 9, 10)]">
    <hr/>
    <h2>
      <xsl:apply-templates select="category"/>
    </h2>
    <table>
      <tr>
        <th>Name</th>
        <th>Level</th>
        <th>Note</th>
      </tr>
      <xsl:apply-templates select="puzzles/puzzle" mode="misc"/>
    </table>
  </xsl:template>
  <xsl:template match="puzzle" mode="misc">
    <tr>
      <xsl:apply-templates select="name, level, basedOn, note, noteOnly" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Other (section 11)                                                 -->
  <!-- basedOn, note, and noteOnly are mutually exclusive note fields     -->
  <!-- ================================================================== -->
  <xsl:template match="section[11]">
    <hr/>
    <h2>
      <xsl:apply-templates select="category"/>
    </h2>
    <table>
      <tr>
        <th>Name</th>
        <th>Note</th>
      </tr>
      <xsl:apply-templates select="puzzles/puzzle" mode="other"/>
    </table>
  </xsl:template>
  <xsl:template match="puzzle" mode="other">
    <tr>
      <xsl:apply-templates select="name, basedOn, note, noteOnly" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Cell contents                                                      -->
  <!-- ================================================================== -->
  <xsl:template match="name" mode="cell">
    <td class="name">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  <xsl:template match="category | designer | year | level | basedOn | note | noteOnly" mode="cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  <xsl:template match="level/text()">
    <!-- ================================================================ -->
    <!-- Upper-case "level" in level-specific column entries              -->
    <!-- ================================================================ -->
    <xsl:value-of select="concat(upper-case(substring(., 1, 1)), substring(., 2))"/>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Inline                                                             -->
  <!-- ================================================================== -->
  <xsl:template match="name | level">
    <span class="{name()}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
</xsl:stylesheet>
