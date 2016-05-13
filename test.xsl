<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
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
    
    <!-- list analysis    -->
    <xsl:template match="analysis" mode="analysis">
           <li id="{@id}"> 
               <xsl:apply-templates select="@id"/> 
                <ul><xsl:apply-templates select="/analysis/method"></xsl:apply-templates>
                    <xsl:apply-templates select="method"/>           
                </ul>
           </li>
    </xsl:template>
    <!-- list methods    -->
    <xsl:template match="method">
            <li>
                <xsl:apply-templates select="@id"/>
                <!--citation-->
                <xsl:for-each select="document('contentconfig.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                    <sup>
                        <a href="#cite{count(preceding::citation) + 1}">
                            <xsl:value-of select="count(preceding::citation) + 1"/>
                        </a>
                        </sup>
                </xsl:for-each>       
            </li>
    </xsl:template>
    
    <!--TOC based on analysis -->
    <xsl:template match="analysis" mode="toc">
        <li>
            <a href="#{@id}">
            <xsl:apply-templates select="@id"/>
            </a>
        </li>
    </xsl:template>
    
    <!--Citations    -->
    <xsl:template match="method" mode="cite">
        
            <xsl:for-each select="document('contentconfig.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                <li>
                    <cite id="cite{count(preceding::citation) + 1}">
                    [<xsl:value-of select="count(preceding::citation) + 1"/>]
                    <xsl:apply-templates/>
                    </cite>
                </li>
            </xsl:for-each>
        
    </xsl:template>
    
</xsl:stylesheet>