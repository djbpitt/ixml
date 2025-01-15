<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
  <p:input port="source" primary="true" content-types="text/plain" href="hanayama.txt"/>
  <p:output port="result" primary="true" sequence="true">
    <p:empty/>
  </p:output>
  <p:invisible-xml>
    <p:with-input port="grammar">
      <p:document href="hanayama.ixml" content-type="text/plain"/>
    </p:with-input>
  </p:invisible-xml>
  <p:validate-with-relax-ng>
    <p:with-input port="schema">
      <p:document href="hanayama.rnc" content-type="text/plain"/>
    </p:with-input>
  </p:validate-with-relax-ng>
  <p:store href="hanayama.xml" serialization="map{'indent': true()}"/>
  <p:xslt>
    <p:with-input port="stylesheet" href="hanayama.xsl"/>
  </p:xslt>
  <p:store href="hanayama.xhtml"/>
</p:declare-step>
