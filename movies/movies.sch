<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
  <sch:pattern>
    <sch:rule context="countries">
      <sch:let name="count" value="count(*)"/>
      <sch:assert test="$count gt 0 and $count lt 8">Every film must list 1 or 7 countries. This one
        lists <sch:value-of select="$count"/>.</sch:assert>
    </sch:rule>
    <sch:rule context="runtime">
      <sch:assert test="(. = 'N/A') or (. castable as xs:positiveInteger)">The runtime must be
        either a positive integer or the string "N/A".</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
