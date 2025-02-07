<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="#all" version="3.0">
    <!-- ================================================================ -->
    <!-- Global variables                                                 -->
    <!--                                                                  -->
    <!-- $chapter-narrative-word-counts: map from chapter offset          -->
    <!--   (integer) to word-count (integer) of text-node children of     -->
    <!--   <paragraph>                                                    -->
    <!-- $chapter-speech-word-counts: map from chapter offset (integer)   -->
    <!--   to word-count (integer) of text-node children of <q>           -->
    <!-- $chapter-total-word-counts: map from chapter offset (integer) to -->
    <!--   word-count (integer) of text-node children of <paragraph> and  -->
    <!--   <q>                                                            -->
    <!-- $total-word-count: integer                                       -->
    <!-- $chapter-backgrounds: sequence of two color strings              -->
    <!-- $x-scale: horizontal scaling factor as double                    -->
    <!-- $y-scale: vertical scaling factor as double                      -->
    <!-- ================================================================ -->
    <xsl:param name="debug" static="true" as="xs:boolean" select="false()"/>
    <xsl:variable name="chapter-narrative-word-counts" as="map(*)">
        <xsl:map>
            <xsl:for-each select="descendant::chapter-body">
                <xsl:map-entry key="position()"
                    select="djb:count-words(current()/descendant::paragraph/text())"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="chapter-speech-word-counts" as="map(*)">
        <xsl:map>
            <xsl:for-each select="descendant::chapter-body">
                <xsl:map-entry key="position()"
                    select="djb:count-words(current()/descendant::q/text())"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="chapter-total-word-counts" as="map(*)">
        <xsl:map>
            <xsl:for-each select="descendant::chapter-body">
                <xsl:map-entry key="position()" select="djb:count-words(descendant::text())"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="total-word-count" as="xs:integer" select="
            map:for-each($chapter-total-word-counts, function ($k, $v) {
                $v
            }) => sum()"/>
    <xsl:variable name="color-backgrounds" as="xs:string+" select="'#fffff3', '#dbeded'"/>
    <xsl:variable name="x-scale" as="xs:double" select="10"/>
    <xsl:variable name="y-scale" as="xs:double" select="3"/>
    <!-- ================================================================ -->
    <!-- Functions                                                        -->
    <!--                                                                  -->
    <!-- count-words as integer                                           -->
    <!--   sum word counts in sequence of strings                         -->
    <!--   @param strings as sequence of strings                          -->
    <!--     (e.g., text-node children of <paragraph> or <q>              -->
    <!--   returns integer                                                -->
    <!-- chapter-offset-to-x-pos as double                                -->
    <!--   x position of right edge of chapter rectangle                  -->
    <!--   @param chapter-offset as integer                               -->
    <!--   returns double                                                 -->
    <!-- ================================================================ -->
    <xsl:function name="djb:count-words" as="xs:integer">
        <xsl:param name="strings" as="xs:string*"/>
        <xsl:sequence select="$strings ! normalize-space() ! tokenize(.) ! count(.) => sum()"/>
    </xsl:function>
    <xsl:function name="djb:chapter-offset-to-x-pos" as="xs:double">
        <xsl:param name="chapter-offset" as="xs:integer"/>
        <xsl:sequence
            select="((1 to $chapter-offset) ! $chapter-total-word-counts(.) => sum()) * 100 * $x-scale div $total-word-count"
        />
    </xsl:function>
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <xsl:message use-when="$debug" select="
                'Narrative word counts: ',
                serialize($chapter-narrative-word-counts, map {
                    'method': 'json',
                    'indent': true()
                })"/>
        <xsl:message use-when="$debug" select="
                'Quoted word counts: ',
                serialize($chapter-speech-word-counts, map {
                    'method': 'json',
                    'indent': true()
                })"/>
        <xsl:message use-when="$debug" select="
                'Total word counts: ',
                serialize($chapter-total-word-counts, map {
                    'method': 'json',
                    'indent': true()
                })"/>
        <svg viewBox="-10 -{100 * $y-scale + 10} {100 * $x-scale + 20} {100 * $y-scale + 20}">
            <!-- ======================================================== -->
            <!-- x axis, y axis, chapter rectangles and vertical lines    -->
            <!-- ======================================================== -->
            <line x1="0" y1="0" x2="{100 * $x-scale}" y2="0" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <!-- y axis and vertical lines at chapter boundaries as percentages -->
            <line x1="0" y1="0" x2="0" y2="{-100 * $y-scale}" stroke="black" stroke-width="1"
                stroke-linecap="square"/>
            <xsl:for-each select="map:keys($chapter-total-word-counts)">
                <xsl:variable name="current-x" as="xs:double"
                    select="djb:chapter-offset-to-x-pos(current())"/>
                <xsl:variable name="previous-x" as="xs:double"
                    select="djb:chapter-offset-to-x-pos(current() - 1)"/>
                <xsl:variable name="chapter-word-count" as="xs:integer"
                    select="$chapter-total-word-counts(current())"/>
                <xsl:variable name="chapter-word-count-percentage" as="xs:string"
                    select="($chapter-word-count div $total-word-count * 100) => format-number('0.00')"/>
                <rect x="{$previous-x}" y="{-100 * $y-scale}" width="{$current-x - $previous-x}"
                    height="{100 * $y-scale}" fill="{$color-backgrounds[current() mod 2 + 1]}">
                    <title>
                        <xsl:value-of select="
                                concat('Chapter ', current(), ':  ', $chapter-word-count, ' words (',
                                $chapter-word-count-percentage, '%)')"/>
                    </title>
                </rect>
                <xsl:variable name="x-pos" as="xs:double" select="$current-x"/>
                <line x1="{$x-pos}" y1="0" x2="{$x-pos}" y2="{-100 * $y-scale}" stroke="black"
                    stroke-width="1" stroke-linecap="square"/>
            </xsl:for-each>
            <!-- ======================================================== -->
            <!-- -->
            <!-- ======================================================== -->
        </svg>
    </xsl:template>
</xsl:stylesheet>
