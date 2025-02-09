<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xsl"/>
   <!-- user-provided library module(s) -->
   <xsl:import href="file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph-helper.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/Users/djb/repos/xspec/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-aware"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name') eq 'SAXON') and starts-with(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version'), 'EE ')"
                 static="yes"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}logical-processor-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware"
                 select="Q{java:java.lang.Runtime}getRuntime() =&gt; Q{java:java.lang.Runtime}availableProcessors()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 select="1"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware =&gt; not()"/>
   <xsl:param xmlns:djb="http://www.obdurodon.org"
              xmlns:x="http://www.jenitennison.com/xslt/xspec"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              name="Q{}chapter-total-word-counts"
              as="map(*)"
              select="map {1: 10, 2:12, 3:15}"/>
   <xsl:param xmlns:djb="http://www.obdurodon.org"
              xmlns:x="http://www.jenitennison.com/xslt/xspec"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              name="Q{}total-word-count"
              as="xs:integer"
              select="37"/>
   <xsl:param xmlns:djb="http://www.obdurodon.org"
              xmlns:x="http://www.jenitennison.com/xslt/xspec"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              name="Q{}x-scale"
              select="2"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 2">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenarios for testing function count-words</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenarios for testing function count-words</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
               <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
               <xsl:attribute name="function" namespace="">djb:count-words</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario1"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario2"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..with whitespace-normalized input</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>with whitespace-normalized input</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
               <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
                  <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
                  <xsl:attribute name="name" namespace="">strings</xsl:attribute>
                  <xsl:attribute name="select" namespace="">tokenize('This is a sample text'), tokenize('And this is another')</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          name="Q{urn:x-xspec:compile:impl}param-d64e1"
                          select="tokenize('This is a sample text'), tokenize('And this is another')"><!--$strings--></xsl:variable>
            <xsl:sequence xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          select="Q{http://www.obdurodon.org}count-words($Q{urn:x-xspec:compile:impl}param-d64e1)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario1-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Should tokenize and count words</xsl:message>
      <xsl:variable xmlns:djb="http://www.obdurodon.org"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns:xs="http://www.w3.org/2001/XMLSchema"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e30"
                    select="9"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e30, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-scenario1-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Should tokenize and count words</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e30"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..with input that has edge spaces</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>with input that has edge spaces</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
               <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
                  <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
                  <xsl:attribute name="name" namespace="">strings</xsl:attribute>
                  <xsl:attribute name="select" namespace="">tokenize('This is a sample text '), tokenize(' And this is another')</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          name="Q{urn:x-xspec:compile:impl}param-d73e1"
                          select="tokenize('This is a sample text '), tokenize(' And this is another')"><!--$strings--></xsl:variable>
            <xsl:sequence xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          select="Q{http://www.obdurodon.org}count-words($Q{urn:x-xspec:compile:impl}param-d73e1)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario2-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Should tokenize and count words</xsl:message>
      <xsl:variable xmlns:djb="http://www.obdurodon.org"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns:xs="http://www.w3.org/2001/XMLSchema"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e34"
                    select="9"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e34, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-scenario2-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Should tokenize and count words</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e34"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing function chapter-offset-to-x-pos</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/ixml/blithedale/blithedale-to-graph.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing function chapter-offset-to-x-pos</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
               <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
               <xsl:attribute name="function" namespace="">djb:chapter-offset-to-x-pos</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
                  <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
                  <xsl:attribute name="name" namespace="">chapter-offset</xsl:attribute>
                  <xsl:attribute name="select" namespace="">2</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          name="Q{urn:x-xspec:compile:impl}param-d82e1"
                          select="2"><!--$chapter-offset--></xsl:variable>
            <xsl:sequence xmlns:djb="http://www.obdurodon.org"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          xmlns:xs="http://www.w3.org/2001/XMLSchema"
                          select="Q{http://www.obdurodon.org}chapter-offset-to-x-pos($Q{urn:x-xspec:compile:impl}param-d82e1)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:variable xmlns:djb="http://www.obdurodon.org"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       name="Q{}expected-result"
                       select="(10 + 12) * 100 * 2 div 37"/>
         <xsl:variable xmlns:djb="http://www.obdurodon.org"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       name="Q{}tolerance"
                       select="0.0001"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}expected-result" select="$Q{}expected-result"/>
            <xsl:with-param name="Q{}tolerance" select="$Q{}tolerance"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}expected-result" as="item()*" required="yes"/>
      <xsl:param name="Q{}tolerance" as="item()*" required="yes"/>
      <xsl:message>Should be accurate within 0.0001</xsl:message>
      <xsl:variable xmlns:djb="http://www.obdurodon.org"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns:xs="http://www.w3.org/2001/XMLSchema"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e40"
                    select="map{'result': 'Success'}"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:djb="http://www.obdurodon.org"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                select="djb:compare-with-tolerance($expected-result, $x:result, $tolerance)"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:djb="http://www.obdurodon.org"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             xmlns:xs="http://www.w3.org/2001/XMLSchema"
                             select="djb:compare-with-tolerance($expected-result, $x:result, $tolerance)"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Scenario for testing function chapter-offset-to-x-pos Should be accurate within 0.0001'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e40, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Should be accurate within 0.0001</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="djb">http://www.obdurodon.org</xsl:namespace>
               <xsl:namespace name="xs">http://www.w3.org/2001/XMLSchema</xsl:namespace>
               <xsl:attribute name="test" namespace="">djb:compare-with-tolerance($expected-result, $x:result, $tolerance)</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e40"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
