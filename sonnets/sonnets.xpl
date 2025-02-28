<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
  xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Read plain text input from remote location                         -->
  <!-- ================================================================== -->
  <p:input port="source" primary="true" content-types="text/plain"
    href="https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/sonnets/sonnets.txt"
    sequence="false"/>
  <!-- ================================================================== -->
  <!-- Serialize output as HTML 5 with XML syntax                         -->
  <!-- ================================================================== -->
  <p:output port="result" serialization="map {
    'method' : 'xhtml',
    'html-version': 5,
    'omit-xml-declaration': false(),
    'include-content-type' : false(),
    'indent' : true()
    }"/>
  <!-- ================================================================== -->
  <!-- Add XML markup using ixml                                          -->
  <!-- ================================================================== -->
  <p:invisible-xml>
    <p:with-input port="grammar">
      <p:document href="sonnets.ixml" content-type="text/plain"/>
    </p:with-input>
  </p:invisible-xml>
  <!-- ================================================================== -->
  <!-- Transform to HTML 5 with XML syntax                                -->
  <!-- ================================================================== -->
  <p:xslt>
    <p:with-input port="stylesheet" href="sonnets-to-xhtml.xsl"/>
  </p:xslt>
</p:declare-step>
