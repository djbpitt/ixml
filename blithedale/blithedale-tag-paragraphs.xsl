<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->    
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="chapter-body">
        <!-- ============================================================ -->
        <!-- Tag paragraphs                                               -->
        <!-- ============================================================ -->
        <xsl:copy>
            <xsl:for-each select="tokenize(., '\n\n+')">
                <p>
                    <xsl:apply-templates select="."/>
                </p>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="(chapter-label | p)/text()">
        <!-- ============================================================ -->
        <!-- Nnormalize chapter-labels along with paragraphs              -->
        <!-- ============================================================ -->
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
</xsl:stylesheet>
