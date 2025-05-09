<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixml="http://invisiblexml.org/NS" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:djb="http://www.obdurodon.org" xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="#all" version="3.0">
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- Must use old-style identity template to remove unusued ixml ns   -->
    <!-- ================================================================ -->
    <xsl:template match="/ | * | @*">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @* except @ixml:*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select='
                replace(., "(^| )&apos;", "$1‘") (: apostrophe initial or after space :) =>
                replace("--", "—") (: double hyphen with dasy  :) =>
                translate("&apos;", "’") (: remaining apostrophe with right typographic:)
                '/>
    </xsl:template>
</xsl:stylesheet>
