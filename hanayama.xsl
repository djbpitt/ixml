<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ================================================================== -->
  <!-- Housekeeping                                                       -->
  <!-- ================================================================== -->
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
    indent="yes"/>
  <!-- ================================================================== -->
  <!-- Templates                                                          -->
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
            padding: 2px 3px;
          }
          .name {
            font-weight: bold;
          }</style>
      </head>
      <body>
        <h1>Hanayama puzzle inventory</h1>
        <hr/>
        <h2>Huzzles</h2>
        <!-- Merge sections 1–6 in single table -->
        <table>
          <tr>
            <th>Level</th>
            <th>Name</th>
            <th>Designer</th>
            <th>Year</th>
          </tr>
          <xsl:apply-templates select="hanayama/section[position() le 6]/descendant::puzzle"
            mode="huzzle"/>
        </table>
        <xsl:apply-templates select="hanayama/section[7]"/>
        <xsl:apply-templates select="hanayama/section[position() gt 7]"/>
      </body>
    </html>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Mode huzzle (sections 1–6)                                         -->
  <!-- ================================================================== -->
  <xsl:template match="puzzle" mode="huzzle">
    <tr>
      <td>
        <xsl:apply-templates select="ancestor::section/category"/>
      </td>
      <td>
        <xsl:apply-templates select="name"/>
      </td>
      <td>
        <xsl:apply-templates select="designer"/>
      </td>
      <td>
        <xsl:apply-templates select="year"/>
      </td>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Chess (section 7)                                                  -->
  <!-- ================================================================== -->
  <xsl:template match="section[7]">
    <hr/>
    <h2>
      <xsl:apply-templates select="category"/>
    </h2>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Ultraman, Zelda, Disney, Other (sections 8+)                       -->
  <!-- ================================================================== -->
  <xsl:template match="section[position() gt 7]">
    <hr/>
    <h2>
      <xsl:apply-templates select="category"/>
    </h2>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Cell contents                                                      -->
  <!-- ================================================================== -->
  <xsl:template match="name">
    <span class="name">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <!--  <xsl:template match="designer | year">
    <xsl:value-of select="(., 'NA')[1]"/>
  </xsl:template>-->
</xsl:stylesheet>
