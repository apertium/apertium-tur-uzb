import sys;

cat = sys.argv[1];
tags = '<s n="' + cat.replace('.', '"/><s n="') + '"/>';	
for line in sys.stdin.readlines(): #{
	row = line.split(':');
	l = row[0].replace(' ', '<b/>');
	r = row[1].strip();
	
	if ',' in r: #{
		for w in r.split(','): #{
			w = w.strip().replace(' ', '<b/>');
				
			print('    <e><p><l>%s%s</l><r>%s%s</r></p></e>' % (w, tags, l, tags));	
		#}

	else: #{
		print('    <e><p><l>%s%s</l><r>%s%s</r></p></e>' % (r.replace(' ', '<b/>'), tags, l, tags));	
	#}
#}
