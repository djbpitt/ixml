<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
  <p:input port="source" primary="true">
    <p:document href="non-xml-characters.txt" content-type="text/plain"/>
  </p:input>
  <p:output port="result" primary="true"/>
  <p:text-replace pattern="\\x{{0032}}" replacement="X"/>
</p:declare-step>
