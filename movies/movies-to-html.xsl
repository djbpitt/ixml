<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  xmlns="http://www.w3.org/1999/xhtml" version="3.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Movie data</title>
        <link rel="stylesheet" type="text/css" href="movies.css"/>
      </head>
      <body>
        <h1>Movie data</h1>
        <table>
          <thead>
            <tr>
              <th>Title</th>
              <th>Year</th>
              <th>Countries</th>
              <th>Runtime</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="film">
    <tr>
      <xsl:attribute name="class" select="
          if (number(year) mod 2 = 0) then
            'even'
          else
            'odd'"/>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>
  <xsl:template match="title | year">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  <xsl:template match="countries">
    <td>
      <ul>
        <xsl:apply-templates/>
      </ul>
    </td>
  </xsl:template>
  <xsl:template match="country">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="runtime">
    <td>
      <xsl:apply-templates/>
      <xsl:if test="matches(., '\d+')">
        <xsl:text> min</xsl:text>
      </xsl:if>
    </td>
  </xsl:template>
</xsl:stylesheet>
