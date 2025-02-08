<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="text"/>
    <xsl:use-package name="http://www.obdurodon.org/smoothing" version="1.0"/>
    <xsl:use-package name="http://www.obdurodon.org/plot-lib" version="1.0"/>
    <!-- ================================================================ -->
    <!-- Return 1 for paragraph word and 0 for quote word                 -->
    <!-- Input is all text node children of paragraphs and quotes         -->
    <!-- ================================================================ -->
    <xsl:function name="djb:word-parent-codes" as="xs:integer+">
        <xsl:param name="input" as="text()+"/>
        <xsl:variable name="parent-types" select="
                $input !
                (let $parent-code := if (name(..) eq 'paragraph') then
                    1
                else
                    0
                return
                    (tokenize(normalize-space(.), '\s|—') ! $parent-code))
                "/>
        <xsl:sequence select="$parent-types"/>
    </xsl:function>
    <xsl:template match="/">
        <xsl:variable name="text-nodes" select="//text()[parent::paragraph or parent::q]"/>
        <xsl:sequence select="djb:word-parent-codes($text-nodes)"/>
    </xsl:template>
</xsl:stylesheet>
