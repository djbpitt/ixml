<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Global variables                                                 -->
    <!-- ================================================================ -->
    <xsl:variable name="blank-line-regex" as="xs:string">\n\n+</xsl:variable>
    <xsl:variable name="chapter-title-regex" as="xs:string">^([IVX]+)\. (.+)$</xsl:variable>
    <!-- ================================================================ -->
    <!-- Functions                                                        -->
    <!-- ================================================================ -->
    <xsl:function name="djb:title-case" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:value-of
            select="tokenize($in, '\s+') ! concat(substring(., 1, 1), lower-case(substring(., 2)))"
        />
    </xsl:function>
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="front">
        <!-- ============================================================ -->
        <!-- Tag title, author, toc                                       -->
        <!-- ============================================================ -->
        <xsl:copy>
            <xsl:variable name="parts" as="xs:string+" select="tokenize(., $blank-line-regex)"/>
            <xsl:message select="count($parts)"/>
            <xsl:apply-templates select="$parts" mode="atomic"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="chapter-label">
        <xsl:copy>
            <xsl:value-of select="djb:title-case(.)"/>
        </xsl:copy>
    </xsl:template>
    <!-- ================================================================ -->
    <!-- Process atomic values in front section                           -->
    <!-- ================================================================ -->
    <!-- Take out the trash                                               -->
    <!-- ================================================================ -->
    <xsl:template mode="atomic" match="
            .[
            starts-with(., 'Produced by') or
            starts-with(., 'Table of') or
            . eq 'by']"/>
    <!-- ================================================================ -->
    <!-- Tag author and title                                             -->
    <!-- ================================================================ -->
    <xsl:template match=".[starts-with(., 'The Blithedale')]" mode="atomic">
        <title>
            <xsl:value-of select="."/>
        </title>
    </xsl:template>
    <xsl:template match=".[starts-with(., 'Nathaniel')]" mode="atomic">
        <author>
            <xsl:value-of select="."/>
        </author>
    </xsl:template>
    <xsl:template match=".[string-length(normalize-space(.)) gt 0]" mode="atomic">
        <!-- ============================================================= -->
        <!-- What’s left is the toc                                        -->
        <!-- ============================================================= -->
        <contents>
            <xsl:for-each select="tokenize(., '\n') ! normalize-space(.)">
                <chapter>
                    <xsl:analyze-string select="." regex="{$chapter-title-regex}">
                        <xsl:matching-substring>
                            <number>
                                <xsl:value-of select="regex-group(1)"/>
                            </number>
                            <chapter-label>
                                <xsl:value-of select="regex-group(2) => djb:title-case()"/>
                            </chapter-label>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </chapter>
            </xsl:for-each>
        </contents>
    </xsl:template>
</xsl:stylesheet>