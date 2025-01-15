<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="*[not(*)]">
            <sch:assert test=". eq normalize-space(.)">Text-only elements should be
                whitespace-normalized</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
