<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all" version="3.0">
    <p:input port="source">
        <p:inline>
            <root>
                <p>Party like it’s <date>2025-01-11</date>!</p>
            </root>
        </p:inline>
    </p:input>
    <p:output port="result"/>
    <p:xslt>
        <p:with-input port="stylesheet">
            <p:document href="coffeesacks.xsl"/>
        </p:with-input>
    </p:xslt>
</p:declare-step>
