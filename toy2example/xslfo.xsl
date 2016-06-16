<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- generate PDF page structure -->
    <!-- http://cocoon.apache.org/2.1/howto/howto-html-pdf-publishing.html -->
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page"
                    page-height="29.7cm" 
                    page-width="21cm"
                    margin-top="1cm" 
                    margin-bottom="2cm" 
                    margin-left="2.5cm" 
                    margin-right="2.5cm"
                    >
                    <fo:region-before extent="3cm"/>
                    <fo:region-body margin-top="3cm"/>
                    <fo:region-after extent="1.5cm"/>
                </fo:simple-page-master>
                
                <fo:page-sequence-master master-name="all">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference 
                            master-reference="page" page-position="first"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="all">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block><xsl:apply-templates/></fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- list analysis    -->
    <!--<xsl:template match="analysis" mode="analysis">
        <li id="{@id}"> 
            <xsl:apply-templates select="@id"/> 
            <ul><xsl:apply-templates select="/analysis/method"></xsl:apply-templates>
                <xsl:apply-templates select="method"/>           
            </ul>
        </li>
    </xsl:template>
    -->
    <xsl:template match="analysis" mode="analysis">
        <fo:list-block padding="4pt">
            <xsl:apply-templates select="@id"/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <h2>Report for Dr Zoidberg</h2>
                <div><xsl:value-of  select="current-date()"/></div>
                <div><xsl:apply-templates select="/report/date"></xsl:apply-templates></div>
            </head>
            <body>
                <h2>Table of Contents</h2>
                <ul><xsl:apply-templates select="//analysis" mode="toc"/></ul>
                
                <h2>Analysis</h2>
                <ul><xsl:apply-templates select="//analysis" mode="analysis"/></ul>   
                <!-- <xsl:apply-templates select="/report/analysis/method"/>-->
                
                <h2>Citations</h2>
                <ul><xsl:apply-templates select="//method" mode="cite"></xsl:apply-templates></ul>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page"
                    page-height="29.7cm" 
                    page-width="21cm"
                    margin-top="1cm" 
                    margin-bottom="2cm" 
                    margin-left="2.5cm" 
                    margin-right="2.5cm"
                    >
                    <fo:region-before extent="3cm"/>
                    <fo:region-body margin-top="3cm"/>
                    <fo:region-after extent="1.5cm"/>
                </fo:simple-page-master>
                
                <fo:page-sequence-master master-name="all">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference 
                            master-reference="page" page-position="first"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="all">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block><xsl:apply-templates/></fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>