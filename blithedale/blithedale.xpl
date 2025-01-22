<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ex="extensions" version="3.0">
    <p:input port="source" primary="true" content-types="text/plain" href="blithedale-with-bom.txt"/>
    <p:output port="result" primary="true" sequence="true" serialization="map{'indent':'true'}"/>
    <p:declare-step type="ex:xpath">
        <p:input port="source" sequence="true"/>
        <p:output port="result"/>
        <p:option name="expr" required="true" as="xs:string"/>
        <p:xquery>
            <p:with-input port="query">
                <p:inline content-type="text/plain">{$expr}</p:inline>
            </p:with-input>
        </p:xquery>
        <p:identity>
            <p:with-input>
                <p:inline content-type="text/plain">{.}</p:inline>
            </p:with-input>
        </p:identity>
    </p:declare-step>
    <p:if test="starts-with(., '&#xfeff;')" name="bom-removal">
        <ex:xpath expr="substring(., 2)"/>
    </p:if>
    <p:invisible-xml>
        <p:with-input port="grammar">
            <p:document href="blithedale.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <p:delete match="//header|//footer"/>
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-paragraphs.xsl"/>
    </p:xslt>
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-quotes.xsl"/>
    </p:xslt>
    <p:xslt>
        <p:with-input port="stylesheet" href="blithedale-tag-front.xsl"/>
    </p:xslt>
    <p:identity/>
    <!--    <p:validate-with-relax-ng>
        <p:with-input port="schema">
            <p:document href="hanayama.rnc" content-type="text/plain"/>
        </p:with-input>
    </p:validate-with-relax-ng>-->
    <!--    <p:validate-with-schematron>
        <p:with-input port="schema" href="hanayama.sch"/>
    </p:validate-with-schematron>-->
    <!--    <p:store href="hanayama.xml" serialization="map{'indent': true()}"/>-->
    <!--    <p:xslt>
        <p:with-input port="stylesheet" href="hanayama.xsl"/>
    </p:xslt>-->
    <!--    <p:store href="hanayama.xhtml"/>-->
</p:declare-step>
