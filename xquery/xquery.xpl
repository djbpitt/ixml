<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:ex="extensions" version="3.0"
  name="bom">
  <p:input port="source" primary="true" content-types="text/plain" href="text-with-bom-crlf.txt"/>
  <p:output port="result" primary="true" sequence="true"/>
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
      <p:inline content-type="text/plain"> doc: line++newline, newline?. line: ~[#d;#a]+. -newline:
        -#d?, #a.</p:inline>
    </p:with-input>
  </p:invisible-xml>
</p:declare-step>
