<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================
         Include functions
         ================================================================ -->
    <xsl:include href="blithedale-lib.xsl"/>
    <!-- ================================================================
         Templates
         ================================================================ -->
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- ================================================================
         Title, author
         ================================================================ -->
    <xsl:template match="front">
        <xsl:copy>
            <xsl:apply-templates select="paragraph[position() = (2, 4)]"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="front/paragraph[2]">
        <title>
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="front/paragraph[4]">
        <author>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
    <!-- ================================================================
         Table of contents
         ================================================================ -->
    <xsl:template match="toc">
        <contents>
            <header>
                <xsl:value-of select="toc-header"/>
            </header>
            <chapters>
                <xsl:apply-templates select="toc-line"/>
            </chapters>
        </contents>
    </xsl:template>
    <xsl:template match="toc-line">
        <chapter id="toc-chapter-{roman}">
            <xsl:value-of select="djb:title-case(title-text)"/>
        </chapter>
    </xsl:template>
    <!-- ================================================================
         Title-case chapter titles in body
         ================================================================ -->
    <xsl:template match="title-text">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="djb:title-case(.)"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
