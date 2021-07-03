// Licence: Lesser GNU Public License 2.1 (LGPL)
#pragma rtGlobals=3		// Use modern global access method.


Menu "Macros"
	"Graph tool", graphtool_MakePanel()
end



Function graphtool_MakePanel()
	if (WinType("Graphtool") == 7)
		// if the panel already exists, show it
		DoWindow/F Graphtool
	else
		init_flags()

		NewPanel/K=1/W=(381,55,680,435)/N=Graphtool
		ModifyPanel fixedSize=1,noEdit=1

		PopupMenu popup_category,pos={10,10},size={115,20},title="For  ",fSize=12
		PopupMenu popup_category,mode=1,value=#"multiLoader_getcategories()"
		PopupMenu popup_loader,pos={10,36},size={115,20},title="File Loader",fSize=12
		PopupMenu popup_loader,mode=1,value=#"multiLoader_listfuncofcateg()"

		Button button_load,pos={100,350},size={80,20},title="Load",fSize=14, proc=multiLoader_loadbutton
		Button button_autoload,pos={10,350},size={80,20},title="Auto Load",fSize=14, proc=multiLoader_autoloadbutton // need a working xx_check_file() function for each file type

		Button button_about,pos={210,10},size={80,20},title="About ...",fSize=14, proc=multiLoader_info//バージョン情報などを入力する。

		SetDrawEnv textrgb= (26205,52428,1),fstyle= 5,fsize= 14;DelayUpdate
		DrawText 110,80,"Settings"
		variable y = 35
		// spectra
		SetDrawEnv textrgb= (65535,0,0),fstyle= 1;DelayUpdate
		DrawText 10,70+y,"Spectra"
		CheckBox check0 title="include ADC",pos={10,80+y},variable=$("root:Packages:Import_Tool:flags:"+f_includeADC)
		CheckBox check1 title="single channeltrons",pos={10,100+y},variable=$("root:Packages:Import_Tool:flags:"+f_includeNDET)
		CheckBox check2 title="single scans",pos={10,120+y},variable=$("root:Packages:Import_Tool:flags:"+f_includeNscans)
		CheckBox check3 title="just detector",pos={10,140+y},variable=$("root:Packages:Import_Tool:flags:"+f_onlyDET)
		CheckBox check4 title="incl. transmission Func.",pos={10,160+y},variable=$("root:Packages:Import_Tool:flags:"+f_includeTF)
		// counts (y-axis)	
		SetDrawEnv textrgb= (65535,0,0),fstyle= 1;DelayUpdate
		DrawText 150,70+y,"Y-axis"
		CheckBox check5 title="div by #scans",pos={150,80+y},variable=$("root:Packages:Import_Tool:flags:"+ f_divbyNscans)
		CheckBox check6 title="div by lifetime",pos={150,100+y},variable=$("root:Packages:Import_Tool:flags:"+f_divbytime)
		CheckBox check7 title="div by DetectorGain",pos={150,120+y},variable=$("root:Packages:Import_Tool:flags:"+f_divbygain)
		CheckBox check8 title="interpolate counts",pos={150,140+y},variable=$("root:Packages:Import_Tool:flags:"+f_interpolate)
		CheckBox check14 title="div by TF",pos={150,160+y},variable=$("root:Packages:Import_Tool:flags:"+f_divbyTF)
		y=80
		// x-axis
		SetDrawEnv textrgb= (65535,0,0),fstyle= 1;DelayUpdate
		DrawText 150,160+y,"X-axis"
		CheckBox check9 title="convert to cm^-1",pos={150,170+y},variable=$("root:Packages:Import_Tool:flags:"+f_converttoWN)
		CheckBox check10 title="vs. Ekin",pos={150,190+y},variable=$("root:Packages:Import_Tool:flags:"+ f_vsEkin)
		CheckBox check11 title="pos. Ebind",pos={150,210+y},variable=$("root:Packages:Import_Tool:flags:"+f_posEbin)
		CheckBox check_askenergy title="ask for Eph",pos={150,230+y},variable=$("root:Packages:Import_Tool:flags:"+f_askforE)
		// storing
		SetDrawEnv textrgb= (65535,0,0),fstyle= 1;DelayUpdate
		DrawText 10,160+y,"Storing"
		CheckBox check12 title="store@root",pos={10,170+y},variable=$("root:Packages:Import_Tool:flags:"+f_importtoroot)
		CheckBox check13 title="ask for append",pos={10,190+y},variable=$("root:Packages:Import_Tool:flags:"+f_askforEXT)
		CheckBox check15 title="ask for wave prefix",pos={10,210+y},variable=$("root:Packages:Import_Tool:flags:"+f_askforwaveprefix)
		SetVariable setvar0  title="suffix",pos={10,230+y},size={115,20},value=$("root:Packages:Import_Tool:flags:"+f_suffix)

		SetDrawLayer UserBack
		// spectra
		SetDrawEnv linethick= 2,linefgc= (65535,21845,0),fillpat= 0
		DrawRRect 5,85,135, 215
		// storing
		SetDrawEnv linethick= 2,linefgc= (65535,21845,0),fillpat= 0
		DrawRRect 5,220,135, 335
		// counts (y-axis)	
		SetDrawEnv linethick= 2,linefgc= (65535,21845,0),fillpat= 0
		DrawRRect 145,85,275, 215
		// x-axis
		SetDrawEnv linethick= 2,linefgc= (65535,21845,0),fillpat= 0
		DrawRRect 145,220,275, 335
	endif
	return 0
end


