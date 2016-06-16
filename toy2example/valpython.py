import StringIO
import shlex, subprocess
from lxml import isoschematron
from lxml import etree

# _VALIDATE_
# parse sch,xml,relaxNG
parser_xml = etree.XMLParser()
sch_doc = etree.parse('toy.sch')
schematron = isoschematron.Schematron(sch_doc, store_report = True)

#xml_doc = etree.parse('toy.xsl', parser_xml)
xml_doc = etree.parse('toy.xsl')

##compact to relaxNG
#pytrang randng.rnc randng.rng 
randNG_doc = etree.parse('randng.rng')
relaxng = etree.RelaxNG(randNG_doc)

# validate against schematron
validationResult = schematron.validate(xml_doc)
print '--------------------'
print validationResult

# validate against relaxNG
try:
	validateRelaxng = relaxng.assert_(xml_doc)
	print 'relaxNG worked'
except AssertionError as e:
	error = relaxng.error_log.last_error
	print relaxng.error_log
	print error.type_name
	if error.type_name == 'RELAXNG_ERR_ATTRVALID':
		print 'invalid attribute'
#		RELAXNG_ERR_ELEMNAME

# _TRANSFORM_ 
#just run it from shell
cmd = "java -cp /usr/share/java/saxonb.jar net.sf.saxon.Transform -xsl:test2.xsl -s:toy.xml -o:toy6.html"
args = shlex.split(cmd)
#subprocess.Popen(args)


