pro earthshine


;**********************************************************************************
;**********************************************************************************
;
; [MARINA VON STEINKIRCH, SPRING/2012]
;
;
; Before the sky subtraction, we had the trace determined from the point spectra 
; on ATV.
;**********************************************************************************
;**********************************************************************************

@constants

;--------------Reading the all the calibrated images of our science
readcol,cOut+'earthshine1.txt', aXEarth, aEarthshine1		; over slit
readcol,cOut+'earthshinesky1.txt',aXEarthSky, aEarthshineSky1
readcol,cOut+'earthshine2.txt', aXEarth, aEarthshine2
readcol,cOut+'earthshinesky2.txt',aXEarthSky, aEarthshineSky2
readcol,cOut+'earthshine3.txt', aXEarth, aEarthshine3
readcol,cOut+'earthshinesky3.txt',aXEarthSky, aEarthshineSky3
readcol,cOut+'earthshine4.txt', aXEarth, aEarthshine4
readcol,cOut+'earthshinesky4.txt',aXEarthSky, aEarthshineSky4
readcol,cOut+'earthshine5.txt', aXEarth, aEarthshine5
readcol,cOut+'earthshinesky5.txt',aXEarthSky, aEarthshineSky5
readcol,cOut+'earthshine6.txt', aXEarth, aEarthshine6
readcol,cOut+'earthshinesky6.txt',aXEarthSky, aEarthshineSky6

readcol,cOut+'earthshine.txt', aXEarth, aEarthshine		; point source trace
readcol,cOut+'earthshinesky.txt',aXEarthSky, aEarthshineSky

readcol,cOut+'moonshine.txt', aXMoon, aMoonshine		;15 sec	expo
readcol,cOut+'moonshinesky.txt', aXMoonSky, aMoonshineSky	
readcol,cOut+'moonshine1.txt', aXMoon, aMoonshine1		; 30 sec expo
readcol,cOut+'moonshinesky1.txt', aXMoonSky, aMoonshineSky1


;-------------------------------------------------
; 1) SKY SUBTRACTION FOR MOONSHINE.
;-------------------------------------------------
aMoonshine = aMoonshine + aMoonshine1/2 - aMoonshineSky - aMoonshineSky1/2
aMoonshine = median( aMoonshine,2)

;-------- Calculating S/N
SNMoon = aMoonshine/(aMoonshineSky1 +aMoonshineSky)
print, Median(SNMoon)


;-------------------------------------------------
; 2) SKY SUBTRACTION FOR EARTHSHINE.
;-------------------------------------------------
;--- point source trace
aEarthshineFrame1= aEarthshine
aEarthshineSkyFrame1 = aEarthshineSky

; ---- integrating over strips
aEarthshineFrame2= aEarthshine1+aEarthshine2 + aEarthshine3 +aEarthshine4 +aEarthshine5+aEarthshine6
aEarthshineSkyFrame2 = aEarthshineSky1+aEarthshineSky2+aEarthshineSky3+aEarthshineSky4+aEarthshineSky5+aEarthshineSky6


; ----- matching sky before subtraction
cRange=where(aXEarth gt 400 and aXEarth lt  500)

cEarthMax = min(aEarthshineFrame1[cRange])
iEarthMax = where(aEarthshineFrame1 eq cEarthMax)
cEarthSkyMax = min(aEarthshineSkyFrame1[cRange])
iEarthSkyMax = where(aEarthshineSkyFrame1 eq cEarthSkyMax)
cDiff = iEarthMax - iEarthSkyMax 
cSizeMoon= n_elements(aEarthshineSkyFrame1)
for i = 0, cSizeMoon-1 do begin
	aEarthshineSkyFrame1(i) = aEarthshineSkyFrame1(i + cDiff)
endfor

cEarthMax = min(aEarthshineFrame2[cRange])
iEarthMax = where(aEarthshineFrame2 eq cEarthMax)
cEarthSkyMax = min(aEarthshineSkyFrame2[cRange])
iEarthSkyMax = where(aEarthshineSkyFrame2 eq cEarthSkyMax)
cDiff = iEarthMax - iEarthSkyMax 
cSizeMoon= n_elements(aEarthshineSkyFrame2)
for i = 0, cSizeMoon-1 do begin
	aEarthshineSkyFrame2(i) = aEarthshineSkyFrame2(i + cDiff)
endfor


; ----subtraction, median combining
aEarthshineFrame1 = aEarthshineFrame1 - aEarthshineSkyFrame1
aEarthshineFrame1 = median(aEarthshineFrame1,2)
aEarthshineFrame2 = aEarthshineFrame2 - aEarthshineSkyFrame2
aEarthshineFrame2 = median(aEarthshineFrame2,2)

;-------- Calculating S/N
SNEarth1 = aEarthshineFrame1/aEarthshineSkyFrame1
print, Median(SNEarth1)	
SNEarth2 = aEarthshineFrame2/aEarthshineSkyFrame2
print, Median(SNEarth2)	


;-------------------------------------------------
; 4) EXTRACTING REFLECTIVITY and PLOTTING.
;-------------------------------------------------
;----- matching moonshine and earthshine before subtraction
cRange=where(aXEarth gt 400 and aXEarth lt  500)
cEarthMax = min(aEarthshineFrame1[cRange])
iEarthMax = where(aEarthshineFrame1 eq cEarthMax)
cMoonMax = min(aMoonshine[cRange])
iMoonMax = where(aMoonshine eq cMoonMax)
cDiff = iMoonMax - iEarthMax
cSizeMoon= n_elements(aMoonshine)
for i = 0, cSizeMoon-1 do begin
	aMoonshineFrame1(i) = aMoonshine(i + cDiff)
endfor

cRange=where(aXEarth gt 400 and aXEarth lt  500)
cEarthMax = min(aEarthshineFrame2[cRange])
iEarthMax = where(aEarthshineFrame2 eq cEarthMax)
cMoonMax = min(aMoonshine[cRange])
iMoonMax = where(aMoonshine eq cMoonMax)
cDiff = iMoonMax - iEarthMax
cSizeMoon= n_elements(aMoonshine)
for i = 0, cSizeMoon-1 do begin
	aMoonshineFrame2(i) = aMoonshine(i + cDiff)
endfor



;------ ploting
device, decomposed=0  
loadct,5 

colors = [50,100] 
lines=[0,0]
names= [' Earthshine', 'Relative Moonshine Shape']
PS_Start, FILENAME = cOutPlot+'earth_point.png'
plot,  aXEarth, aEarthshineFrame, /nodata, title='Earthshine after Sky Subtraction using Point Source Trace' , xtitle='CCD Pixels Range', ytitle='Relative Intensity', yrange = [-100,3000]
oplot,  aXEarth, aEarthshineFrame1, color=colors[0], psym= lines[0]
oplot,  aXMoon, median(aMoonshineFrame1,4)*2/1000, color = colors[1], psym=lines[1]
legend, names, color = colors, psym = lines
PS_End,/PNG

PS_Start, FILENAME = cOutPlot+'earth_strip.png'
plot,  aXEarth, aEarthshineFrame, /nodata, title='Earthshine after Sky Subtraction integrating Over the Strip' , xtitle='CCD Pixels Range', ytitle='Relative Intensity', yrange = [-100,8000]
oplot,  aXEarth, aEarthshineFrame2, color=colors[0], psym= lines[0]
oplot,  aXMoon, median(aMoonshineFrame2,4)*5/1000, color = colors[1], psym=lines[1]
legend, names, color = colors, psym = lines
PS_End,/PNG




aEarthshine1= aEarthshineFrame1/aMoonshineFrame1
aEarthshine2= aEarthshineFrame2/aMoonshineFrame2

names= ['Tracing from Point Source times Integration Step', 'Integrating over Slit']
PS_Start, FILENAME = cOutPlot+'reflectivity0.png'
plot,  aXEarth, aEarthshine2, /nodata, title='Reflection Spectrum of Earthshine' ,xtitle='Pixels Range',ytitle='Relative Intensity', yrange=[-0.05, 0.08]
oplot,  aXEarth, aEarthshine1*6,  color = colors[0], psym=lines[0]
oplot,  aXEarth, aEarthshine2,  color = colors[1], psym=lines[1]
legend, names, color = colors, psym = lines
PS_End,/PNG


save, aEarthshineFrame1,  aXEarth, aEarthshine1, filename= cOut + 'earthshine_pixels1.dat'
save, aEarthshineFrame2,  aXEarth, aEarthshine2, filename= cOut + 'earthshine_pixels2.dat'

	
end
