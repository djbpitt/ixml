<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Global variables                                                 -->
    <!-- ================================================================ -->
    <xsl:variable name="quotation-regex" as="xs:string">(")(.+?)(")</xsl:variable>
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->    
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- ================================================================ -->
    <!-- Delete empty paragraphs                                          -->
    <!-- ================================================================ -->
    <xsl:template match="p[empty(node())]"/>    
    <xsl:template match="p">
        <!-- ============================================================ -->
        <!-- Tag quotes                                                   -->
        <!-- ============================================================ -->
        <xsl:copy>
            <xsl:analyze-string select="." regex="{$quotation-regex}" flags="s">
                <xsl:matching-substring>
                    <q>
                        <xsl:value-of select="regex-group(2) => normalize-space()"/>
                    </q>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
