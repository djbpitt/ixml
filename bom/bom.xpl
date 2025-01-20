<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
    <p:input port="source" primary="true" content-types="text/plain" href="bom.txt"/>
    <p:output port="result" primary="true" sequence="true"/>
    <p:invisible-xml>
        <p:with-input port="grammar">
            <p:document href="bom.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <p:identity/>
</p:declare-step>