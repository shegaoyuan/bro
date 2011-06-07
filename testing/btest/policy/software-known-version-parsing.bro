# @TEST-EXEC: bro %INPUT > output
# @TEST-EXEC: btest-diff output

@load software

global ts = network_time();
global matched_software: table[string] of Software::Info = {
	["OpenSSH_4.4"] = 
		[$name="OpenSSH", $version=[$major=4,$minor=4], $host=0.0.0.0, $ts=ts],
	["OpenSSH_5.2"] = 
		[$name="OpenSSH", $version=[$major=5,$minor=2], $host=0.0.0.0, $ts=ts],
	["Apache/2.0.63 (Unix) mod_auth_kerb/5.3 mod_ssl/2.0.63 OpenSSL/0.9.7a mod_fastcgi/2.4.2"] =
		[$name="Apache", $version=[$major=2,$minor=0,$minor2=63,$addl="Unix"], $host=0.0.0.0, $ts=ts],
	["Apache/1.3.19 (Unix)"] =
		[$name="Apache", $version=[$major=1,$minor=3,$minor2=19,$addl="Unix"], $host=0.0.0.0, $ts=ts],
	["ProFTPD 1.2.5rc1 Server (Debian)"] =
		[$name="ProFTPD", $version=[$major=1,$minor=2,$minor2=5,$addl="rc1"], $host=0.0.0.0, $ts=ts],
	["wu-2.4.2-academ[BETA-18-VR14](1)"] = 
		[$name="wu", $version=[$major=2,$minor=4,$minor2=2,$addl="academ"], $host=0.0.0.0, $ts=ts],
	["wu-2.6.2(1)"] =
		[$name="wu", $version=[$major=2,$minor=6,$minor2=2,$addl="1"], $host=0.0.0.0, $ts=ts],
	["Java1.2.2-JDeveloper"] =
		[$name="Java", $version=[$major=1,$minor=2,$minor2=2,$addl="JDeveloper"], $host=0.0.0.0, $ts=ts],
	["Java/1.6.0_13"] = 
		[$name="Java", $version=[$major=1,$minor=6,$minor2=0,$addl="13"], $host=0.0.0.0, $ts=ts],
	["Python-urllib/3.1"] = 
		[$name="Python-urllib", $version=[$major=3,$minor=1], $host=0.0.0.0, $ts=ts],
	["libwww-perl/5.820"] = 
		[$name="libwww-perl", $version=[$major=5,$minor=820], $host=0.0.0.0, $ts=ts],
	["Wget/1.9+cvs-stable (Red Hat modified)"] = 
		[$name="Wget", $version=[$major=1,$minor=9,$addl="+cvs"], $host=0.0.0.0, $ts=ts],
	["Wget/1.11.4 (Red Hat modified)"] = 
		[$name="Wget", $version=[$major=1,$minor=11,$minor2=4,$addl="Red Hat modified"], $host=0.0.0.0, $ts=ts],
	["curl/7.15.1 (i486-pc-linux-gnu) libcurl/7.15.1 OpenSSL/0.9.8a zlib/1.2.3 libidn/0.5.18"] =
		[$name="curl", $version=[$major=7,$minor=15,$minor2=1,$addl="i486-pc-linux-gnu"], $host=0.0.0.0, $ts=ts],
	["Apache"] = 
		[$name="Apache", $host=0.0.0.0, $ts=ts],
	["Zope/(Zope 2.7.8-final, python 2.3.5, darwin) ZServer/1.1 Plone/Unknown"] =
		[$name="Zope/(Zope", $version=[$major=2,$minor=7,$minor2=8,$addl="final"], $host=0.0.0.0, $ts=ts],
	["The Bat! (v2.00.9) Personal"] =
		[$name="The Bat!", $version=[$major=2,$minor=0,$minor2=9,$addl="Personal"], $host=0.0.0.0, $ts=ts],
	["Flash/10,2,153,1"] =
		[$name="Flash", $version=[$major=10,$minor=2,$minor2=153,$addl="1"], $host=0.0.0.0, $ts=ts],
	["mt2/1.2.3.967 Oct 13 2010-13:40:24 ord-pixel-x2 pid 0x35a3 13731"] = 
		[$name="mt2", $version=[$major=1,$minor=2,$minor2=3,$addl="967"], $host=0.0.0.0, $ts=ts],
	["CacheFlyServe v26b"] =
		[$name="CacheFlyServe", $version=[$major=26,$addl="b"], $host=0.0.0.0, $ts=ts],
	["Apache/2.0.46 (Win32) mod_ssl/2.0.46 OpenSSL/0.9.7b mod_jk2/2.0.4"] =
		[$name="Apache", $version=[$major=2,$minor=0,$minor2=46,$addl="Win32"], $host=0.0.0.0, $ts=ts],
	# I have no clue how I'd support this without a special case.
	#["Apache mod_fcgid/2.3.6 mod_auth_passthrough/2.1 mod_bwlimited/1.4 FrontPage/5.0.2.2635"] =
	#	[$name="Apache", $version=[], $host=0.0.0.0, $ts=ts],
	["Apple iPhone v4.3.1 Weather v1.0.0.8G4"] =
		[$name="Apple iPhone", $version=[$major=4,$minor=3,$minor2=1,$addl="Weather"], $host=0.0.0.0, $ts=ts],
	["Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"] =
		[$name="Safari", $version=[$major=5,$minor=0,$minor2=2,$addl="Mobile"], $host=0.0.0.0, $ts=ts],
	["Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.205 Safari/534.16"] = 
		[$name="Chrome", $version=[$major=10,$minor=0,$minor2=648,$addl="205"], $host=0.0.0.0, $ts=ts],
	["Opera/9.80 (Windows NT 6.1; U; sv) Presto/2.7.62 Version/11.01"] =
		[$name="Opera", $version=[$major=11,$minor=1], $host=0.0.0.0, $ts=ts],
	["Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b2 Thunderbird/3.1.5"] =
		[$name="Thunderbird", $version=[$major=3,$minor=1,$minor2=5], $host=0.0.0.0, $ts=ts],
	["iTunes/9.0 (Macintosh; Intel Mac OS X 10.5.8) AppleWebKit/531.9"] = 
		[$name="iTunes", $version=[$major=9,$minor=0,$addl="Macintosh"], $host=0.0.0.0, $ts=ts],
	["Java1.3.1_04"] =
		[$name="Java", $version=[$major=1,$minor=3,$minor2=1,$addl="04"], $host=0.0.0.0, $ts=ts],
	["Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"] = 
		[$name="Safari", $version=[$major=4,$minor=0,$addl="Mobile"], $host=0.0.0.0, $ts=ts],
	["Opera/9.80 (J2ME/MIDP; Opera Mini/9.80 (S60; SymbOS; Opera Mobi/23.348; U; en) Presto/2.5.25 Version/10.54"] = 
		[$name="Opera Mini", $version=[$major=10,$minor=54], $host=0.0.0.0, $ts=ts],
	["Opera/9.80 (J2ME/MIDP; Opera Mini/5.0.18741/18.794; U; en) Presto/2.4.15"] =
		[$name="Opera Mini", $version=[$major=5,$minor=0,$minor2=18741], $host=0.0.0.0, $ts=ts],
	["Opera/9.80 (Windows NT 5.1; Opera Mobi/49; U; en) Presto/2.4.18 Version/10.00"] =
		[$name="Opera Mobi", $version=[$major=10,$minor=0], $host=0.0.0.0, $ts=ts],
	["Mozilla/4.0 (compatible; MSIE 8.0; Android 2.2.2; Linux; Opera Mobi/ADR-1103311355; en) Opera 11.00"] =
		[$name="Opera Mobi", $version=[$major=11,$minor=0], $host=0.0.0.0, $ts=ts],
	["Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; GTB5; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.2)"] =
		[$name="MSIE", $version=[$major=7,$minor=0], $host=0.0.0.0, $ts=ts],
	["Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.1; Media Center PC 3.0; .NET CLR 1.0.3705; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1)"] =
		[$name="MSIE", $version=[$major=7,$minor=0,$addl="b"], $host=0.0.0.0, $ts=ts],
	["Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)"] =
		[$name="Netscape", $version=[$major=7,$minor=2], $host=0.0.0.0, $ts=ts],
	# This next one currently fails.
	#["The Bat! (3.0.1 RC3) Professional"] =
	#	[$name="The Bat!", $version=[$major=3,$minor=0,$minor2=1,$addl="RC3"], $host=0.0.0.0, $ts=ts],
	# This is an FTP client (found with CLNT command)
	["Total Commander"] =
		[$name="Total Commander", $version=[], $host=0.0.0.0, $ts=ts],
	#["(vsFTPd 2.0.5)"] =
	#	[$name="vsFTPd", $version=[$major=2,$minor=0,$minor2=5], $host=0.0.0.0, $ts=ts],
	
		
};

event bro_init()
	{
	for ( sw in matched_software )
		{
		local output = Software::parse(sw, 0.0.0.0, Software::UNKNOWN);
		local baseline: Software::Info;
		baseline = matched_software[sw];
		if ( baseline$name == output$name &&
		     Software::cmp_versions(baseline$version,output$version) == 0 )
			print fmt("success on: %s", sw);
		else
			{
			print fmt("failure on: %s", sw);
			print fmt("    test name:        %s", output$name);
			print fmt("    test version:     %s", output$version);
			print fmt("    baseline name:    %s", baseline$name);
			print fmt("    baseline version: %s", baseline$version);
			}
		}
	}