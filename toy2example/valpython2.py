import sh
import StringIO
import sys
import argparse
import shlex, subprocess
from lxml import isoschematron
from lxml import etree
import os.path

##compact to relaxNG
#pytrang randng.rnc randng.rng 

def validate(xmlIn):
	# load sch/rng into objects
	sch_doc = etree.parse('toy.sch')
	schematron = isoschematron.Schematron(sch_doc, store_report = True)

	xml_doc = etree.parse(xmlIn)
	
	#convert compressed to regular
	if not os.path.isfile('randng.rnc'):
		try:
			pytrang = "pytrang randng.rnc randng.rng"
			cargs = shlex.split(pytrang)
			subprocess.Popen(cargs)
		except:
			print 'relaxNG rnc -> rng err\n Is pytrang installed?'
				
		
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
		print error
		print relaxng.error_log
		print error.domain_name
		print error.type_name
		if error.type_name == 'RELAXNG_ERR_ATTRVALID':
			print 'invalid attribute'
			#RELAXNG_ERR_ELEMNAME

def transform(xmlIn,htmlOut,transformarg='html'):
	# _TRANSFORM_ 
	#just run it from shell
	#cmd = "java -cp /usr/share/java/saxonb.jar net.sf.saxon.Transform -xsl:test2.xsl -s:toy.xml -o:toy8.html"
	if transformarg == 'html':
		cmd = "java -cp /usr/share/java/saxonb.jar net.sf.saxon.Transform -xsl:test22.xsl -s:%s -o:%s;" % (xmlIn,htmlOut)
	elif transformarg == 'pdf':
		print 'transform pdf'
		wkhtmltopdf = os.path.join('/share/toyexample','wkhtmltopdf')
		#print('PATH', wkhtmltopdf)
		cmd1 = "java -cp /usr/share/java/saxonb.jar net.sf.saxon.Transform -xsl:test22.xsl -s:%s -o:%s;\n" % (xmlIn,htmlOut)
		out = os.path.join(os.getcwd(),'out.pdf') 
		#out = os.path.join(os.getcwd(),'out.pdf')
		print('OUT ', out)
		cmd = cmd1 + 'sleep 10;\n'+ wkhtmltopdf +' '+htmlOut + ' ' +out
		#cmd = cmd1 + ' sleep 10;' + ' '+ wkhtmltopdf +' ' +out
		print str(cmd)
		print type(cmd)
	#run shell cmd
	# multi commands, no shlex.split list, just use str with shell=True
	subprocess.Popen(cmd, shell=True)

#argparse

#parse and subparsers(view, transform)
parser = argparse.ArgumentParser(prog='CRIReportGenerator')
subparsers = parser.add_subparsers(dest='cmd')
subparsers.required=False

#transform parser
#xmlIn htmlOut 
tparser = subparsers.add_parser('transform', help='transform docs')
tparser.add_argument('--input', '-i', help='xml input file')
tparser.add_argument('--output', '-o', help='output file')
tparser.add_argument('--transform', '-t', default='html', choices=['html','pdf'], help='transform type')

#view parser
vparser = subparsers.add_parser('view', help='view xml tree' )
vparser.add_argument('--config', action='store_true',default=True, help='view config.xml tree')
vparser.add_argument('--db', action='store_true', help='view db.xml tree')

#parse args
args = parser.parse_args()
print 'ARG',vars(args)

# view xml tree of configs
#if args.config and xmlIn == None and not args.db:
if args.cmd == 'view' and not args.db:
	try:
		print( sh.xmllint( sh.cat('config.xml', _piped=True), "--format", "-") )
	except Exception:
		pass
elif args.cmd == 'view' and args.db:
	try:
		#print( sh.xmllint( sh.cat('config.xml', _piped=True), "--format", "-") )
		print 'db-----'
	except Exception:
		pass

if args.cmd == 'transform':
	xmlIn = args.input
	htmlOut = args.output
	transformarg = args.transform
	#validate
	validate(xmlIn)
	# transform html
	print 'transform'
	transform( xmlIn, htmlOut,transformarg )

