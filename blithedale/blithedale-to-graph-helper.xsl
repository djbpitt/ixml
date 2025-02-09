<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Thanks to Amanda Galtman                                           -->
  <!-- https://github.com/galtm/xspectacles/issues/62#issuecomment-2646385567 -->
  <!-- ================================================================== -->
  <xsl:function name="djb:compare-with-tolerance" as="map(*)">
    <xsl:param name="expected"/>
    <xsl:param name="result"/>
    <xsl:param name="tolerance"/>
    <xsl:choose>
      <!-- ============================================================== -->
      <!-- <x:expect> can include @test that invokes function loaded via  -->
      <!--   <x:helper>, with result returned to @select                  -->
      <!--   https://github.com/xspec/xspec/wiki/Integrating-Your-Own-Test-Helpers -->
      <!-- Set expected result to map{ 'result' : 'Success' }             -->
      <!-- Run test as @test value inside <xsl:choose>                    -->
      <!-- When test succeeds, return expected map                        -->
      <!-- When test fails, return different map entry, the result        -->
      <!-- Could return anything, but map combines result and label       -->
      <!-- ============================================================== -->
      <xsl:when test="abs($expected - $result) lt $tolerance">
        <xsl:map-entry key="'result'" select="'Success'"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Information to help investigate failure -->
        <xsl:map-entry key="'abs-diff'" select="abs($expected - $result)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
