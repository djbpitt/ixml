<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:djb="http://www.obdurodon.org" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ================================================================== -->
  <!-- Housekeeping                                                       -->
  <!-- ================================================================== -->
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
    indent="yes"/>
  <!-- ================================================================== -->
  <!-- Functions                                                          -->
  <!-- ================================================================== -->
  <xsl:function name="djb:splitPuzzleData" as="element(fn:group)+">
    <!-- ================================================================ -->
    <!-- Extract parts of <puzzleData> element, e.g., designer, year      -->
    <!-- ================================================================ -->
    <xsl:param name="djb:data" as="xs:string"/>
    <xsl:param name="djb:regex" as="xs:string"/>
    <xsl:sequence select="fn:analyze-string($djb:data, $djb:regex)/fn:match/fn:group"/>
  </xsl:function>
  <xsl:function name="djb:initialCap" as="xs:string">
    <!-- ================================================================ -->
    <!-- Uppercase first letter of string                                 -->
    <!-- ================================================================ -->
    <xsl:param name="djb:data" as="xs:string"/>
    <xsl:value-of select="concat(upper-case(substring($djb:data, 1, 1)), substring($djb:data, 2))"/>
  </xsl:function>
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
          td.name,
          td.category {
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
  <!-- Insert level (originally section head) as cell                     -->
  <!-- puzzleData is always (designer year), with no note                 -->
  <!-- ================================================================== -->
  <xsl:template match="puzzle" mode="huzzle">
    <tr>
      <xsl:apply-templates select="name, ancestor::section/category" mode="cell"/>
      <xsl:variable name="huzzleRegex" as="xs:string" select="concat('^(.+) (', $yearRegex, ')$')"/>
      <xsl:apply-templates select="djb:splitPuzzleData(puzzleData, $huzzleRegex)" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Chess (section 7)                                                  -->
  <!-- puzzleData is always (level designer), with no year or note        -->
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
    <xsl:variable name="chessRegex" as="xs:string" select="'^(level \d) (.+)$'"/>
    <tr>
      <xsl:apply-templates select="name" mode="cell"/>
      <xsl:apply-templates select="djb:splitPuzzleData(puzzleData, $chessRegex)" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Ultraman, Zelda, Disney (sections 8–10)                            -->
  <!-- puzzleData is always (level "based on" name)                       -->
  <!-- ================================================================== -->
  <xsl:template match="section[position() = (8 to 10)]">
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
    <xsl:variable name="miscRegex" as="xs:string" select="'(.+) (based on .+)'"/>
    <tr>
      <xsl:apply-templates select="name" mode="cell"/>
      <xsl:apply-templates select="djb:splitPuzzleData(puzzleData, $miscRegex)" mode="cell"/>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Other (section 11)                                                 -->
  <!-- contains name puzzleData note?; merge the last two into one cell   -->
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
      <xsl:apply-templates select="name" mode="cell"/>
      <td>
        <xsl:value-of select="string-join((puzzleData, note), ' ')"/>
      </td>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Cell contents                                                      -->
  <!-- ================================================================== -->
  <xsl:template match="name | category" mode="cell">
    <td class="{name()}">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  <xsl:template match="fn:group[starts-with(., 'level ')]" mode="cell">
    <!-- ================================================================ -->
    <!-- Levels get @class value of category and title casing             -->
    <!-- ================================================================ -->
    <td class="category">
      <xsl:value-of select="djb:initialCap(.)"/>
    </td>
  </xsl:template>
  <xsl:template match="fn:group" mode="cell">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
</xsl:stylesheet>
