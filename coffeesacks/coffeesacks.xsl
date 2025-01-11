<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:cs="http://nineml.com/ns/coffeesacks"
    exclude-result-prefixes="#all"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Housekeeping                                                     -->
    <!-- ================================================================ -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="parser" select="cs:load-grammar('coffeesacks.ixml')"/>
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->
    <xsl:template match="date">
        <xsl:sequence select="$parser(.)"/>
    </xsl:template>
</xsl:stylesheet>