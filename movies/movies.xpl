<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
    <!-- ================================================================ -->
    <!-- Static options                                                   -->
    <!-- ================================================================ -->
    <p:option name="debug" as="xs:boolean" static="true" select="false()"/>
    <!-- ================================================================ -->
    <!--Fetch remote plain-text input                                     -->
    <!-- ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://newtfire.org/courses/tutorials/movieData.txt" sequence="false"/>
    <!-- ================================================================ -->
    <!--  No pipeline output; use <p:store> instead                       -->
    <!-- ================================================================ -->
    <p:output port="result" primary="true" sequence="true">
        <p:empty/>
    </p:output>
    <p:identity use-when="$debug" message="Fetched plain text input from Newtfire"/>
    <!-- ================================================================ -->
    <!--  Add structural markup with ixml                                 -->
    <!-- ================================================================ -->
    <p:invisible-xml>
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
    <!-- Save xml                                                         -->
    <!-- ================================================================ -->
    <p:store href="movies.xml"/>
    <p:identity use-when="$debug" message="Saved movies.xml"/>
</p:declare-step>
