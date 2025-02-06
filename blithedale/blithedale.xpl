<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ex="extensions" version="3.0">
    <!-- ================================================================
         Fetch remote plain-text input
         ================================================================ -->
    <p:option name="debug" as="xs:boolean" static="true" select="false()"/>
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://www.gutenberg.org/files/2081/2081.txt" sequence="false"/>
    <!-- ================================================================
         No pipeline output; use <p:store> instead
         ================================================================ -->
    <p:output port="result" primary="true" sequence="true">
        <p:empty/>
    </p:output>
    <!-- ================================================================
         Remove Unicode BOM if present
         ================================================================ -->
    <p:if test="starts-with(., '&#xfeff;')" name="bom-removal">
        <p:xquery>
            <p:with-input port="query">
                <p:inline content-type="text/plain">text{{substring(.,2)}}</p:inline>
            </p:with-input>
        </p:xquery>
    </p:if>
    <!-- ================================================================
         Add high-level structural markup
         ================================================================ -->
    <p:invisible-xml>
        <p:with-input port="grammar">
            <p:document href="blithedale.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <!-- ================================================================
         Remove header and footer, which are Gutenberg metadata
         ================================================================ -->
    <p:delete match="header|footer"/>
    <!-- ================================================================
         Tag outer quotes
         Cannot tag inner quotes because of apostraphes
         ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-quotes.xsl"/>
    </p:xslt>
    <!-- ================================================================
         Verify that no double quotation marks remain inside paragraphs
         ================================================================ -->
    <p:validate-with-schematron>
        <p:with-input port="schema" href="blithedale-check-quotes.sch"/>
    </p:validate-with-schematron>
    <!-- ================================================================
         Tag title, author, and table of contents
         Also convert body chapter-titles to title case
         ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-front.xsl"/>
    </p:xslt>
    <!-- ================================================================
         Add @id values to chapter titles in body and remove roman
         This is one way to add an attribute to a sequence of elements;
           <p:label-elements> would also work (or with xslt)
         ============================================================== -->
    <p:viewport match="body/chapter">
        <p:add-attribute attribute-name="id"
            attribute-value="{concat('body-chapter-', format-integer(p:iteration-position(), 'I'))}"
        />
    </p:viewport>
    <p:delete match="roman"/>
    <!-- ================================================================
         Remove @ixml:status, create typographic dashes and quotation marks
         ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-cleanup-xml.xsl"/>
    </p:xslt>
    <!-- ================================================================
         Verify that xml matches intended schema
         ================================================================ -->
    <p:validate-with-relax-ng>
        <p:with-input port="schema">
            <p:document href="blithedale.rnc" content-type="text/plain"/>
        </p:with-input>
    </p:validate-with-relax-ng>
    <!-- ================================================================
         Save XML (only during debug)
         ================================================================ -->
    <p:store use-when="$debug" href="blithedale.xml"/>
    <!-- ================================================================
         Create and save reading view
         ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-to-reading-view.xsl"/>
    </p:xslt>
    <p:store href="blithedale.xhtml" serialization="map {
        'method':'xhtml', 
        'html-version':5, 
        'omit-xml-declaration':false(), 
        'include-content-type':false(), 
        'indent':true()}"/>
    <!-- ================================================================
         Create and graph of speech ~ narration
         ================================================================ -->
    <!-- TODO
         Subsection!
         Create and store SVG output                                      -->
</p:declare-step>
