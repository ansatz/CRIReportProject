<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    schemaVersion="ISO19757-3">
    <sch:ns uri="http://www.w3.org/1999/xhtml" prefix="xhtml"/>
    <!--
    <pattern>
        <rule context="end">
            <assert test=". &gt; preceding-sibling::start">The  
                end page cannot be less than the start page</assert>
        </rule>
    </pattern>
    refs:
    http://www.iro.umontreal.ca/~lapalme/ForestInsteadOfTheTrees/HTML/ch03s04.html
    http://www.ldodds.com/papers/schematron_xsltuk.html
    XPath is like match expr ~> assert/test
    http://www.w3schools.com/xsl/xpath_syntax.asp
    http://www.xmlplease.com/validhierarchy
    http://stackoverflow.com/questions/5550094/schematron-xpath-testing-for-valid-set-of-sub-elements-and-attributes?rq=1
    -->
    <!-- CHECK METHOD ELEMENTS -->
    <sch:pattern id="assert_methods">    
        <sch:rule context="//analysis[@id='NGS']/methods/@id"> 
            <sch:let name="NGS_methods" value="doc('contentconfig.xml')/cfg/analysis[@id='NGS']/method/@id"></sch:let>
            <!--            <sch:assert test="count(not(.=$NGS_methods))">-->
            <sch:assert test="true()">
                Valid NGS methods are 'QC'
                <sch:value-of select="$NGS_methods"/>
                
                <!--</sch:assert>-->
        </sch:rule>
    </sch:pattern>
    <!-- CHECK ATTRIBUTES -->
    <sch:pattern id="assert_attributes">
        <sch:rule context="//analysis[@id='NGS']">
            <assert test="count(@*) > count(@id|@title)">Invalid attribute</assert>
        </sch:rule>
    </sch:pattern>
    <!-- 
    <sch:report role="warn" test="true()
         change this to true() for debugging 
        context = <sch:value-of select="//Document/documentType"/>;
        registryItemValue = <sch:value-of select="$registryItemValue"/>;
        refValue = <sch:value-of select="$refValue"/>;
        refPath = <sch:value-of select="$refPath"/>;
        refXmlFilename = <sch:value-of select="$refXmlFilename"/>;
        qualifierValue1 = <sch:value-of select="$qualifierValue"/>;
        qualifierValue2 = <sch:value-of select="$refXmlFilename//registry/entry/item[@key='dataProvider' and @value='MY-SHOP']/../item[@key='ns']/@value"/>;
        path = <sch:value-of select="$path"/>;
        registryXmlFilename = <sch:value-of select="$refXmlFilename"/>;
        ngsmethods = <sch:value-of select="NGS_methods"/>
        </sch:report>
    -->    
</sch:schema>



