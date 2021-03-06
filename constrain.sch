<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding='xslt2'>
    <pattern id="assert_methods">    
<!--        <rule context="//analysis[@id='NGS']/methods/@id"> -->
        <let name="NGS_methods" value="doc('contentconfig.xml')/cfg/analysis[@id='NGS']/method/@id"></let>
        <rule context="//analysis[@id='NGS']">    
            <assert test="true()"> 
                HI *****
                <value-of select="."/>
                <value-of select="name(..)"/>
            </assert>
            <!--<assert test="count(not(@id=$NGS_methods))">methods err</assert>-->
            <!--<report test="true()">
                Valid NGS methods are 'QC'
                <value-of select="$NGS_methods"/>
            </report>  -->
                <!--</sch:assert>-->
        </rule>
    </pattern>
    <!--<!-\- CHECK ATTRIBUTES -\->
    <pattern id="assert_attributes">
        <rule context="//analysis[@id='NGS']">
            <assert test="count(@*) = count(@id|@title)">Invalid attributes
            <value-of select="count(@*)"></value-of>
            </assert>
        </rule>
    </pattern>-->
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

    
    
    

</schema>




        
        
        
<!--<!-\-
        <!-\-    queryBinding="xslt2"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            schemaVersion="ISO19757-3">
    <sch:ns uri="http://www.w3.org/1999/xhtml" prefix="xhtml"/>-\->
    <!-\-
    <pattern>
        <rule context="end">
            <assert test=". &gt; preceding-sibling::start">The  
                end page cannot be less than the start page</assert>
        </rule>
    </pattern>
-\->
    <!-\- CHECK METHOD ELEMENTS -\->
    <sch:pattern id="assert_methods">    
        <sch:rule context="//analysis[@id='NGS']/methods/@id"> 
            <sch:let name="NGS_methods" value="doc('contentconfig.xml')/cfg/analysis[@id='NGS']/method/@id"></sch:let>
<!-\-            <sch:assert test="count(not(.=$NGS_methods))">-\->
            <sch:assert test="true()">
                Valid NGS methods are 'QC'
                <sch:value-of select="$NGS_methods"/>
                
            <!-\-</sch:assert>-\->
        </sch:rule>
    </sch:pattern>
    <!-\- CHECK ATTRIBUTES -\->
    <sch:pattern id="assert_attributes">
        <sch:rule context="//analysis[@id='NGS']">
        <assert test="count(@*) > count(@id|@title)">Invalid attribute</assert>
        </sch:rule>
    </sch:pattern>
    <!-\- 
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
    -\->    
</sch:schema>
-\->
-->

