<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ex="extensions" version="3.0">
    <!-- ================================================================
         Fetch remote plain-text input
         ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://www.gutenberg.org/files/2081/2081.txt" sequence="false"/>
    <!-- ================================================================
         Don’t pretty-print; xmllint implementation is better
         ================================================================ -->
    <p:output port="result" primary="true" sequence="true"/>
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
         ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-front.xsl"/>
    </p:xslt>
    <!-- ================================================================
         Add @id values to chapter titles in body and remove roman
         ================================================================ -->
    <p:viewport match="body/chapter">
        <p:add-attribute attribute-name="id"
            attribute-value="{concat('body-chapter-', format-integer(p:iteration-position(), 'I'))}"
        />
    </p:viewport>
    <p:delete match="roman"/>
    <!-- ================================================================
         Remove @ixml:status
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
    <!-- TODO
         Create and store HTML output with TOC linking and CSS
         Create CSS
         Create and store SVG output                                      -->
</p:declare-step>
