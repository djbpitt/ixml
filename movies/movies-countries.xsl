<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="country">
        <!-- ============================================================ -->
        <!-- Split up multiple countries, adding wrapper                  -->
        <!-- ============================================================ -->
        <countries>
            <xsl:for-each select="translate(., '&quot;', '') => tokenize(', ')">
                <country>
                    <xsl:value-of select="."/>
                </country>
            </xsl:for-each>
        </countries>
    </xsl:template>
    <xsl:template match="runtime">
        <!-- ============================================================ -->
        <!-- values are either "xxx min", where xxx is digits, or "N/A"   -->
        <!-- remove " min", leaving just digits; leave "N/A" as is        -->
        <!-- ============================================================ -->
        <xsl:copy>
            <xsl:value-of select="replace(., ' min', '')"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
