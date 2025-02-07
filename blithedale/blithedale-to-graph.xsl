<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:variable name="chapter-word-counts" as="map(*)">
        <xsl:map>
            <xsl:apply-templates select="descendant::chapter-body"/>
        </xsl:map>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:message select="serialize($chapter-word-counts, map {'method': 'json', 'indent': true()})"/>
        <svg/>
    </xsl:template>
    <xsl:template match="chapter-body">
        <xsl:map-entry key="position()" select="normalize-space(.) => tokenize() => count()"/>
    </xsl:template>
</xsl:stylesheet>
