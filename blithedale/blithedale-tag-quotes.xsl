<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================
         Global variables for regex matching
         Cannot autotag inner quotes because of apostrophes
         ================================================================ -->
    <xsl:variable name="quotation-regex" as="xs:string">"(.+?)"</xsl:variable>
    <!-- ================================================================
         Templates
         ================================================================ -->
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="paragraph">
        <!-- ============================================================
             Tag quotes
             ============================================================ -->
        <xsl:copy>
            <xsl:analyze-string select="." regex="{$quotation-regex}" flags="s">
                <xsl:matching-substring>
                    <q>
                        <xsl:value-of select="regex-group(1)"/>
                    </q>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
