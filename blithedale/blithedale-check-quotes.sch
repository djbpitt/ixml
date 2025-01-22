<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:pattern>
    <sch:rule context="p">
      <sch:assert test="count(string-to-codepoints(.)[. eq string-to-codepoints('&quot;')]) eq 0"
        >There should be no quotation mark characters.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
