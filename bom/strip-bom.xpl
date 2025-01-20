<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" name="strip-bom">
    <!-- ================================================================ -->
    <!-- Step to remove BOM and verify result                             -->
    <!--                                                                  -->
    <!-- Input starts with BOM (65279 = 0xfeff)                           -->
    <!-- Does not check for other possible BOM values                     -->
    <!-- ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain" href="bom.txt"/>
    <p:output port="result" primary="true" sequence="true"/>
    <!-- ================================================================ -->
    <!-- Show that BOM is present                                         -->
    <!-- ================================================================ -->
    <p:identity message="{concat('Before: ', string-to-codepoints(.) ! string(.) => string-join(', '))}"/>
    <!-- ================================================================ -->
    <!-- Remove BOM and show that it is now absent                        -->
    <!-- ================================================================ -->
    <p:text-replace pattern="&#xfeff;" replacement=""/>
    <p:identity message="{concat('After:         ', string-to-codepoints(.) ! string(.) => string-join(', '))}"/>
    <!-- ================================================================ -->
    <!-- Remove BOM vacuously and show no change                          -->
    <!-- ================================================================ -->
    <p:text-replace pattern="&#xfeff;" replacement=""/>
    <p:identity message="{concat('After:         ', string-to-codepoints(.) ! string(.) => string-join(', '))}"/>
</p:declare-step>
