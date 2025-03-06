<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="country">
        <countries>
            <xsl:for-each select="translate(., '&quot;', '') => tokenize(', ')">
                <country>
                    <xsl:value-of select="."/>
                </country>
            </xsl:for-each>
        </countries>
    </xsl:template>
    <xsl:template match="runtime">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test=". eq 'N/A'">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-before(., ' min')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
