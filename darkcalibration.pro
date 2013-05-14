pro darkcalibration


;**********************************************************************************
;**********************************************************************************
;
; [MARINA VON STEINKIRCH, SPRING/2012]
;
; COLLECTION OF MACROS ON IDL TO STUDY EARTHSHINE:
;	1) darkcalibration.pro ---> dark frame calibration
;	2) earthshine.pro ---> extract sky, earthshine
;	3) neon.pro --> neon calibration
;	4) diagrams.pro  ---> print molecular bands
;	5) fit.pro + fit.C ---> model fitting
;
;**********************************************************************************
;**********************************************************************************

@constants


;----------------------------------------------------------------------
; 1) Read the all the images of our science, put into an array (raw)
;----------------------------------------------------------------------

;--- dark side
for i=0, cNumberFilesDark-1 do begin	
	aDark(i,*,*) = readfits(cDarkFolder+ strtrim(i+1,2) + '.FIT',hDa)	
endfor

;--- bright side (two time exposures)
for i=0, cNumberFilesBright-1 do begin
	if i lt 5 then begin		
		aBright15(i,*,*) = readfits(cBrightFolder[0] + strtrim(i+1,2) + '.FIT',hBr)	
	endif else begin 
		j=i-cNumberFilesBright15	
		aBright30(j,*,*) =readfits(cBrightFolder[1] + strtrim(i+1,2) + '.FIT',hBr)	
	endelse
endfor


;----- calibration dark
for j=0, cNumberExpTime-1 do begin
	for i=0, cNumberFilesDarkCal-1 do begin
		fDa = cDarkCalFolder[j] + strtrim(i+1,2) + '.FIT'
		if j eq 0 then 	aDarkCal15(i,*,*) = readfits(fDa, hDa)
		if j eq 1 then 	aDarkCal30(i,*,*) = readfits(fDa, hDa)
		if j eq 2 then 	aDarkCal120(i,*,*) = readfits(fDa, hDa)
	endfor
endfor


;---- median combining 
for x=0,cFrameSizeX-1 do begin
	for y=0,cFrameSizeY-1 do begin
		aDarkFrame(x,y) = median( aDark(*,x,y), /even )		
		aBright15Frame(x,y) = median( aBright15(*,x,y), /even ) 
		aBright30Frame(x,y) = median( aBright30(*,x,y), /even ) 
		aDarkCal15Frame(x,y) = median( aDarkCal15(*,x,y), /even ) 
		aDarkCal30Frame(x,y) = median( aDarkCal30(*,x,y), /even ) 
		aDarkCal120Frame(x,y) = median( aDarkCal120(*,x,y), /even ) 
	endfor
endfor	

;---- writing fits	
writefits, cOut  + 'dark0.fit', aDarkFrame, hDa
writefits, cOut  + 'bright0_15.fit', aBright15Frame, hBr
writefits, cOut  + 'bright0_30.fit', aBright30Frame, hB

aDarkPre = aDarkFrame
aBright15Pre = aBright15Frame


;-------------------------------------------------------------------------
;2) Substract dark.
;-------------------------------------------------------------------------

;--- resducing 
for i=0, cNumberFilesDark-1 do begin
	aDark(i,*,*) = aDark(i,*,*) - aDarkCal120Frame
endfor
for i=0, cNumberFilesBright15-1 do begin
	aBright15(i,*,*) = aBright15(i,*,*) - aDarkCal15Frame
endfor
for i=0, cNumberFilesBright30-1 do begin
	aBright30(i,*,*) = aBright30(i,*,*) - aDarkCal30Frame
endfor


;---- median combining 	
for x=0,cFrameSizeX-1 do begin
	for y=0,cFrameSizeY-1 do begin
		aDarkFrame(x,y) = median( aDark(*,x,y), /even )		
		aBright15Frame(x,y) = median( aBright15(*,x,y), /even ) 
		aBright30Frame(x,y) = median( aBright30(*,x,y), /even ) 
	endfor
endfor		


;---- writing fits	
writefits, cOut  + 'dark.fit', aDarkFrame, hDa
writefits, cOut  + 'bright_15.fit', aBright15Frame, hBr
writefits, cOut  + 'bright_30.fit', aBright30Frame, hBr
save, aDarkFrame  , aBright15Frame,  filename= cOut + 'dark_bright.dat'


end
