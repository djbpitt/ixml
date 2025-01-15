<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
    <p:input port="source" primary="true" content-types="text/plain" href="date.txt"/>
    <p:output port="result" primary="true"/>
    <p:invisible-xml>
        <p:with-input port="grammar">
            <p:document href="date.ixml" content-type="text/plain"/>
        </p:with-input>
        <!--<p:with-input port="grammar" href="date.ixml"/>-->
    </p:invisible-xml>
    <p:validate-with-schematron>
        <p:with-input port="schema" href="date.sch"/>
    </p:validate-with-schematron>
</p:declare-step>
