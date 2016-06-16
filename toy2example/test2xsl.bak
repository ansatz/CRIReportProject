<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/">
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="reportstyle.css"/>
                <link rel="stylesheet" href="xslt.css"/>
                <!--<STYLE>
                    h2 {font-family: Arial,Univers,sans-serif;
                    font-size: 36pt }
                </STYLE>-->
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
    <!-- LIST ANALYSIS (methods + figures)    -->
    <xsl:template match="analysis" mode="analysis">
           <li id="{@id}"> 
               <xsl:apply-templates select="@id"/>
                <ul>
                    <!-- list methods -->
                    <xsl:apply-templates select="/analysis/method"/>
                    <!-- this helps if an empyt list, ie no member methods -->
                    <xsl:apply-templates select="method"/>            
                    <!--  list figures  -->
                   <xsl:apply-templates select="/analysis/figure"/>
                    <xsl:apply-templates select="figure"/>
                    <!-- csv to table element -->
                    <xsl:apply-templates select="table"/>
               </ul>
           </li>
    </xsl:template>

    <xsl:template name='wraptable' match="table">
        <!--<table style="border-color: red; border-width: thick;background-color=gray"> -->
        <li>
        <table border="1" style="bgcolor=orange"> 
        <xsl:call-template name='table'/>
        </table>
        </li>
    </xsl:template>   
 
    <!--  INSERT TABLE  -->
    <xsl:template name='table'>
        <xsl:param name='line_header'/>
        
        <!--  concat("http://localhost:1234",encode-for-uri("tmp.xsl")) -->
        <xsl:variable name="URIToCSV" select="encode-for-uri('/home/solver/CRIReportProject/toyexample/toy.csv')"/>
        <xsl:variable name="pathToCSV" select="'/home/solver/CRIReportProject/toyexample/toy.csv'"/>

        <!-- <br/><em><xsl:text> File path: </xsl:text></em><br/> -->
        <!-- <xsl:value-of select='$pathToCSV'/><br/> -->

      <xsl:choose>
        <!-- input file not exist -->
        <xsl:when test="not(unparsed-text-available($pathToCSV))">
            <xsl:text>not found : </xsl:text>
            <xsl:value-of select="$pathToCSV"/>
        </xsl:when>
        <!-- input file exist -->
        <xsl:otherwise>
                <xsl:choose>
                <!-- header -->
                <xsl:when test="not($line_header)">
                    <!--***** THDR: ******* 
                    <xsl:value-of select='$line_header'/>
                    -->
                    <xsl:variable name='headrow' select="tokenize(unparsed-text($pathToCSV), '\r?\n')"/>
                    <xsl:call-template name='table'>
                        <xsl:with-param name='line_header' select='true()'/>
                    </xsl:call-template>
                    <xsl:call-template name='tokenizeheader'>
                        <xsl:with-param name='text' select='$headrow[0]'/>
                    </xsl:call-template>
                   <!--  <xsl:for-each select="tokenize(unparsed-text($pathToCSV), '\r?\n')">  -->
                   <!-- recursively set header false -->
                   <!--  <xsl     <xsl:call-template name='table'> -->
                   <!--  <xsl         <xsl:with-param name='line_header' select='true()'/> -->
                   <!--  <xsl     </xsl:call-template> -->
                   <!-- insert header -->
                   <!--  <xsl     <tr> -->
                   <!--<xsl:call-template name="tokenizeheader"> -->                      
                   <!--  <xsl:with-param name="text" select="substring(.,3, string-length(.) -2)"/> -->
                   <!--  <xsl         <xsl:with-param name="text" select="substring(.,1, string-length(.))"/> -->
                   <!--  <xsl     </xsl:call-template>-->
                   <!--  <xsl     </tr>-->
                   <!--  <xsl </xsl:for-each>-->
                </xsl:when>
                <!-- data -->
                <xsl:otherwise>
                <xsl:for-each select="tokenize(unparsed-text($pathToCSV), '\r?\n')">
                    <!-- line count -->
                    <!-- <xsl:variable name='linecount' select="."/> -->
                    <!-- >data: <xsl:text/> -->
                    <!-- <xsl:value-of select='$linecount'/><br/> -->
                    <!-- insert <td> -->
                    <tr>
                    <xsl:call-template name="tokenize">                       
                        <!--<xsl:with-param name="text" select="substring(.,3, string-length(.) -2)"/> -->
                        <xsl:with-param name="text" select="substring(.,1, string-length(.))"/> 
                    </xsl:call-template>
                    </tr>
                </xsl:for-each>
                </xsl:otherwise>
                </xsl:choose>
        </xsl:otherwise>
        <!-- input file not exist -->
      </xsl:choose>
</xsl:template>

    <xsl:template name="tokenize2">
        <xsl:param name="csv" />
        <xsl:variable name="first-item" select="normalize-space(substring-before( concat( $csv, ','), ','))" /> 
        <xsl:if test="$first-item">
            <item>
            <xsl:value-of select="$first-item" /> 
            </item>  
            <xsl:call-template name="tokenize2"> 
                <xsl:with-param name="csv" select="substring-after($csv,',')" /> 
            </xsl:call-template>    
        </xsl:if>  
    </xsl:template>
    


    <xsl:template name="tokenizeheader">
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="'&#x9;'"/>
        <xsl:variable name="token" select="substring-before(concat($text, $delimiter), $delimiter)" />
        <xsl:if test="$token">
            <th>
                <xsl:value-of select="$token"/>
            </th>
        </xsl:if>
        <xsl:if test="contains($text, $delimiter)">
            <!-- recursive call -->
            <xsl:call-template name="tokenizeheader">
                <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="tokenize">
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="'&#x9;'"/>
        <xsl:variable name="token" select="substring-before(concat($text, $delimiter), $delimiter)" />
        <xsl:if test="$token">
            <td>
                <xsl:value-of select="$token"/>
            </td>
        </xsl:if>
        <xsl:if test="contains($text, $delimiter)">
            <!-- recursive call -->
            <xsl:call-template name="tokenize">
                <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


    <!-- LIST FIGURES -->
    <xsl:template match="figure">
        <li>
                    <div id="images">
                     <a style='text-decoration: none;'>
                        <img src="{@file}" style='width: 100px; height: 100px'/>
                        <div style='width: 90px; text-align: center;'>
                            <xsl:value-of select="@description"/>                            
    <!--                            <xsl:apply-templates/>-->
                        </div>
                     </a>
                    </div>
         </li>
    </xsl:template>

    <!-- LIST METHODS -->
    <xsl:template match="method">
            <li>
                <xsl:apply-templates select="@id"/>
                <xsl:for-each select="document('config.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                    <sup>
                        <a href="#cite{count(preceding::citation) +1}">
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
	<xsl:template match="//method" mode="cite">
            <xsl:for-each select="document('config.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                <li>
					<cite id="cite{count(preceding::citation) + 1}">
					[<xsl:value-of select="count(preceding::citation) + 1"/>]
					<xsl:apply-templates/>
                </cite>
                </li>
            </xsl:for-each>
    </xsl:template>
    <!-- figure images -->
    <!--<xsl:template match="figure">
        <li>
            <xsl:apply-templates select="@file"/>
            <!-\-citation-\->
            <!-\-                <xsl:if test="document('contentconfig.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                    <sup>
                        <a href="#cite{count(preceding::method) + 1}">
                            <xsl:value-of select="count(preceding::method) + 1"/>
                        </a>
                        </sup>
					</xsl:if>       -\->
            <!-\-<xsl:for-each select="document('config.xml')/cfg/analysis/method[@id=current()/@id]/citation">
                <sup>
                    <a href="#cite{count(preceding::citation) +1}">
                        <xsl:value-of select="count(preceding::citation) + 1"/>
                    </a>
                </sup>
            </xsl:for-each>-\->       
        </li>
    </xsl:template>
    -->
    <!--<xsl:template match="//figure">
        <img src="{@file}">
            <xsl:apply-templates select="@file"/>
        </img>
     <!-\-   <xsl:element name="imgs">
<!-\\-        <img>    -\\->
            <xsl:attribute name="src">
<!-\\-                <xsl:value-of select="figure/@file"/>-\\->
                hi
<!-\\-                <xsl:apply-templates select="@file"></xsl:apply-templates>-\\->
            </xsl:attribute>
        </xsl:element>
<!-\\-        </img>-\\->-\->
    </xsl:template>-->   
</xsl:stylesheet>
