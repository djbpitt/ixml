<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cx="http://xmlcalabash.com/ns/extensions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions" version="3.0">
    <p:output port="result" sequence="true" primary="true"/>
    <p:directory-list path="source" detailed="true"/>
    <p:for-each>
        <p:with-input select="//c:file"/>
        <p:variable name="filename" as="xs:string"
            select="//c:file/@name ! substring-before(., '.txt')"/>
        <p:load href="source/{//c:file/@name}" message="Loaded file {$filename}"/>
        <p:identity message="Identity on file {$filename}"/>
    </p:for-each>
    <p:wrap-sequence wrapper="root"/>
</p:declare-step>
