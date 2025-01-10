<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0" name="hanayama-pipeline">
  <p:input port="source" primary="true" content-types="text/plain" href="hanayama.txt"/>
  <p:output port="result"/>
  <p:invisible-xml name="hanayama-ixml">
    <p:with-input port="source" pipe="source@hanayama-pipeline"/>
    <p:with-input port="grammar">
      <p:document href="hanayama.ixml" content-type="text/plain"/>
    </p:with-input>
  </p:invisible-xml>
  <p:xslt>
    <p:with-input port="stylesheet" href="hanayama.xsl"/>
  </p:xslt>
</p:declare-step>
