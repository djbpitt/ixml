<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Fetch remote plain-text input                                    -->
    <!-- ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://newtfire.org/courses/tutorials/movieData.txt" sequence="false"/>
    <!-- ================================================================ -->
    <!-- Output                                                           -->
    <!-- ================================================================ -->
    <p:output port="result" primary="true" sequence="true"/>
    <!-- ================================================================ -->
    <!-- If primary ports are correct, will output plain text input       -->
    <!-- ================================================================ -->
    <p:identity/>
</p:declare-step>
