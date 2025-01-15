<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
    <p:input port="source" primary="true" href="bad-date.xml"/>
    <p:output port="result" primary="true"/>
    <p:validate-with-schematron>
        <p:with-input port="schema" href="bad-date.sch"/>
    </p:validate-with-schematron>
</p:declare-step>
