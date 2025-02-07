<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ex="extensions" version="3.0">
    <!-- ================================================================ -->
    <!--Fetch remote plain-text input                                     -->
    <!-- ================================================================ -->
    <p:option name="debug" as="xs:boolean" static="true" select="false()"/>
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://www.gutenberg.org/files/2081/2081.txt" sequence="false"/>
    <!-- ================================================================ -->
    <!--  No pipeline output; use <p:store> instead                       -->
    <!-- ================================================================ -->
    <p:output port="result" primary="true" sequence="true">
        <p:empty/>
    </p:output>
    <!-- ================================================================ -->
    <!-- Remove BOM if present                                            -->
    <!-- ================================================================ -->
    <p:if test="starts-with(., '&#xfeff;') or starts-with(., '$#xfffe')" name="bom-removal">
        <p:xquery>
            <p:with-input port="query">
                <p:inline content-type="text/plain">text{{substring(.,2)}}</p:inline>
            </p:with-input>
        </p:xquery>
        <p:identity use-when="$debug" message="BOM found and removed"/>
    </p:if>
    <!-- ================================================================ -->
    <!--  Add structural markup with ixml                                 -->
    <!-- ================================================================ -->
    <p:invisible-xml>
        <p:with-input port="grammar">
            <p:document href="blithedale.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <p:identity use-when="$debug" message="Added markup with ixml"/>
    <!-- ================================================================ -->
    <!-- Remove header and footer, which are Gutenberg metadata           -->
    <!-- ================================================================ -->
    <p:delete match="header|footer"/>
    <p:identity use-when="$debug" message="Deleted Gutenburg boilerplate, front and back"/>
    <!-- ================================================================ -->
    <!--  Tag outer quotes                                                -->
    <!--  Cannot tag inner quotes because of apostraphes                  -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-quotes.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Tagged quotations"/>
    <!-- ================================================================ -->
    <!--  Verify that no double quotation marks remain inside paragraphs  -->
    <!-- ================================================================ -->
    <p:validate-with-schematron>
        <p:with-input port="schema" href="blithedale-check-quotes.sch"/>
    </p:validate-with-schematron>
    <p:identity use-when="$debug" message="Verified no stray quotation marks"/>
    <!-- ================================================================ -->
    <!--  Tag title, author, and table of contents                        -->
    <!--  Convert body chapter-titles to title case                       -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-front.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Tagged front matter and toc, fixed title case"/>
    <!-- ================================================================ -->
    <!--  Add @id values to chapter titles in body and remove roman       -->
    <!--  This is one way to add an attribute to a sequence of elements;  -->
    <!--  <p:label-elements> would also work (or with xslt)               -->
    <!-- ==============================================================   -->
    <p:viewport match="body/chapter">
        <p:add-attribute attribute-name="id"
            attribute-value="{concat('body-chapter-', format-integer(p:iteration-position(), 'I'))}"
        />
    </p:viewport>
    <p:delete match="roman"/>
    <p:identity use-when="$debug" message="Added @id to body chapters, removed Roman numerals"/>
    <!-- ================================================================ -->
    <!-- Remove @ixml:status,                                             -->
    <!--   create typographic dashes and single quotes                    -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-cleanup-xml.xsl"/>
    </p:xslt>
    <p:identity use-when="$debug" message="Removed @ixml:status, fix dashes and single quotes"/>
    <!-- ================================================================ -->
    <!-- Verify that xml matches intended schema                          -->
    <!-- ================================================================ -->
    <p:validate-with-relax-ng>
        <p:with-input port="schema">
            <p:document href="blithedale.rnc" content-type="text/plain"/>
        </p:with-input>
    </p:validate-with-relax-ng>
    <p:identity use-when="$debug" message="Verified final xml against schema"/>
    <!-- ================================================================ -->
    <!-- Save XML (only during debug)                                     -->
    <!-- ================================================================ -->
    <p:store use-when="$debug" href="blithedale.xml" message="Saved final XML (debug only)"/>
    <!-- ================================================================ -->
    <!-- Create reading view                                              -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-to-reading-view.xsl"/>
    </p:xslt>
    <p:identity message="Created xhtml reading view"/>
    <!-- ================================================================ -->
    <!-- Save reading view                                                -->
    <!-- ================================================================ -->
    <p:store href="blithedale.xhtml" serialization="map {
        'method':'xhtml', 
        'html-version':5, 
        'omit-xml-declaration':false(), 
        'include-content-type':false(), 
        'indent':true()}"/>
    <p:identity use-when="$debug" message="Saved xhtml reading view to blithedale.xhtml"/>
    <!-- ================================================================ -->
    <!-- Create and graph of speech ~ narration                           -->
    <!-- ================================================================ -->
    <!-- TODO
         Create and store SVG output                                      -->
</p:declare-step>
