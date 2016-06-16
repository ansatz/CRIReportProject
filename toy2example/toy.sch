<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern id="assert_attributes">
        <rule context="//analysis[@id='NGS']">
			<assert test="count(@*) = count(@id|@title)"> 
				Invalid attributes
				<value-of select="count(@*)"></value-of>
            </assert>
        </rule>
    </pattern>
</schema>
    
