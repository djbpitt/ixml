<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Static options                                                   -->
    <!-- Morgana: -static:debug=true                                      -->
    <!-- XML Calabash: debug="?true()"                                    -->
    <!-- ================================================================ -->
    <p:option name="debug" as="xs:boolean" static="true" select="false()"/>
    <!-- ================================================================ -->
    <!-- Fetch remote plain-text input                                    -->
    <!-- ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://newtfire.org/courses/tutorials/movieData.txt" sequence="false"/>
    <!-- ================================================================ -->
    <!-- No pipeline output; use <p:store> instead                        -->
    <!-- ================================================================ -->
    <p:output port="result" primary="true" sequence="true">
        <p:empty/>
    </p:output>
    <p:identity use-when="$debug" message="Fetched plain text input from Newtfire"/>
    <!-- ================================================================ -->
    <!-- Add structural markup with ixml                                  -->
    <!-- Calabash will use Markup Blitz instead of default CoffeePot      -->
    <!--   (input is too large for efficient processing with CoffeePot)   -->
    <!-- ================================================================ -->
    <p:invisible-xml cx:processor="markup-blitz">
        <p:with-input port="grammar">
            <p:document href="movies.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <p:identity use-when="$debug" message="Added markup with ixml"/>
    <!-- ================================================================ -->
    <!-- Remove first record (column titles, not data)                    -->
    <!-- ================================================================ -->
    <p:delete match="film[1]"/>
    <p:identity use-when="$debug" message="Removed fake first record (column labels)"/>
    <!-- ================================================================ -->
    <!-- Refactor country and runtime data                                -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="movies-countries.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Refactored country and runtime data"/>
    <!-- ================================================================ -->
    <!-- Validate generated XML with Relax NG                             -->
    <!-- ================================================================ -->
    <p:validate-with-relax-ng>
        <p:with-input port="schema">
            <p:document href="movies.rnc" content-type="application/relax-ng-compact-syntax"/>
        </p:with-input>
    </p:validate-with-relax-ng>
    <p:identity use-when="$debug" message="Validated with Relax NG"/>
    <!-- ================================================================ -->
    <!-- Validate generated XML with Schematron                           -->
    <!-- Every film has between one and seven (inclusive) countries       -->
    <!-- Runtime is either a positive integer or the string N/A           -->
    <!-- ================================================================ -->
    <p:validate-with-schematron name="finalize-xml">
        <p:with-input port="schema">
            <p:document href="movies.sch" content-type="application/schematron+xml"/>
        </p:with-input>
    </p:validate-with-schematron>
    <p:identity use-when="$debug" message="Validated with Schematron"/>
    <!-- ================================================================ -->
    <!-- Save xml only if debugging                                       -->
    <!-- ================================================================ -->
    <p:store use-when="$debug" href="movies.xml" message="Saved movies.xml"/>
    <!-- ================================================================ -->
    <!-- Create HTML reading view                                         -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="movies-to-html.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Created HTML reading view"/>
    <!-- ================================================================ -->
    <!-- Save HTML reading view                                           -->
    <!-- ================================================================ -->
    <p:store href="movies.xhtml" serialization="map {
        'method' : 'xhtml', 
        'html-version': 5, 
        'omit-xml-declaration': false(), 
        'include-content-type' : false(), 
        'indent' : true()
        }"/>
    <p:identity use-when="$debug" message="Saved movies.xhtml"/>
    <!-- ================================================================ -->
    <!-- Create SVG chart of runtime by year                              -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="source">
            <p:pipe step="finalize-xml" port="result"/>
        </p:with-input>
        <p:with-input port="stylesheet" href="movies-to-svg.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Created SVG bar graph of runtime by year"/>
    <!-- ================================================================ -->
    <!-- Save SVG chart of runtime by year                                -->
    <!-- ================================================================ -->
    <p:store href="movies.svg" serialization="map {
        'method' : 'xml',
        'indent' : true(),
        'omit-xml-declaration' : false()
        }"/>
    <p:identity use-when="$debug" message="Saved movies.svg"/>
</p:declare-step>
