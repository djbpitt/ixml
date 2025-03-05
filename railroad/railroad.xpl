<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
  xmlns:svg="http://www.w3.org/2000/svg" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ex="extensions" xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
  <!-- ================================================================== -->
  <!-- Synopsis: Reads two ixml grammars and outputs railroad diagrams    -->
  <!-- XML Calabash (alpha21 or later) only                               -->
  <!-- ================================================================== -->
  <!-- Import library for extension step                                  -->
  <!-- Imports must come first                                            -->
  <!-- @use-when suppresses import with Morgana, which doesn’t support    -->
  <!--   <cx:railroad> and would throw an error on import                 -->
  <!-- p:product-name is either "XML Calabash" or "MorganaXProc-IIIse"    -->
  <!-- TODO: Should verify XML Calabash version >= 21                     -->
  <!-- ================================================================== -->
  <p:import use-when="p:system-property('p:product-name') eq 'XML Calabash'"
    href="https://xmlcalabash.com/ext/library/railroad.xpl"/>
  <!-- ================================================================== -->
  <!-- Process two ixml grammars, so input is a sequence                  -->
  <!-- Ignore output; we save graphs with <p:store>                       -->
  <!-- Primary input and output must come first after imports             -->
  <!-- ================================================================== -->
  <p:input port="source" primary="true" sequence="true">
    <p:document href="roman-ambiguous.ixml" content-type="text/plain"/>
    <p:document href="roman-unambiguous.ixml" content-type="text/plain"/>
  </p:input>
  <p:output sequence="true">
    <p:empty/>
  </p:output>
  <!-- ================================================================ -->
  <!-- First and only working step, runs only in XML Calabash           -->
  <!-- Filename based on input, with extension .html instead of .ixml   -->
  <!-- <p:identity> because Morgana must have at least one step         -->
  <!-- ================================================================ -->
  <p:identity message="Processing with {p:system-property('p:product-name')}"/>
  <p:for-each use-when="p:system-property('p:product-name') eq 'XML Calabash'">
    <p:variable name="base-filename" select="
      (p:document-property(.,'base-uri') => tokenize('/'))[last()] => 
      substring-before('.ixml')"/>
    <p:identity message="Processing {$base-filename}"/>
    <cx:railroad name="rr"/>
    <p:store href="{$base-filename}-railroad.html">
      <p:with-input pipe="html@rr"/>
    </p:store>
  </p:for-each>
</p:declare-step>
