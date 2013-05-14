pro neon

;**********************************************************************************
;**********************************************************************************
;
; [MARINA VON STEINKIRCH, SPRING/2012]
;
;**********************************************************************************
;**********************************************************************************

@constants

;-------------------------------------------------
; 1) CALCULATING DISPERSION FROM NEON
;-------------------------------------------------
restore, cOut + 'earthshine_pixels1.dat'	;aEarthshineFrame1,  aXEarth, aEarthshine1
;restore, cOut + 'earthshine_pixels2.dat'	;aEarthshineFrame2,  aXEarth, aEarthshine2
readcol, cOut +'neon.txt', aXNeon, aNeon

;--------- Reading neon spectra: finding first maximum
cFirstMax = max(aNeon)
iFirstMax = where(aNeon eq cFirstMax)


;--------- Reading neon spectra: finding second maximum
cRange=where(aXNeon gt 300 and aXNeon lt  400)
cSecondMax = max(aNeon[cRange])
iSecondMax =  where(aNeon eq cSecondMax)


;--------- Calculating dispersion
cDistancePixel =   iFirstMax - iSecondMax
cDistanceWaveLen = cNeonLines[0] -  cNeonLines[1]
cDispersion = cDistanceWaveLen/cDistancePixel
cB=  cNeonLines[0] - (aXEarth[iFirstMax]- aXEarth[0])*cDispersion


;-------------------------------------------------
; 2) NORMALIZING THE SPECTRAS.
;-------------------------------------------------
cSizeEarth= n_elements(aXEarth)
aXEarthFinal = fltarr(cSizeEarth)
for i = 0, cSizeEarth-1 do begin
	aXEarthFinal(i)= (aXEarth(i)*cDispersion + cB)/10000
endfor

aEarthshine1 = median(aEarthshine1,2)*100+0.6
aEarthshine2 = median(aEarthshine2,2)*100+0.6
aEarthshineFrame2 = aEarthshineFrame1*1000 +0.6
aEarthshineFrame1 = aEarthshineFrame1/10000+ 0.05 


;-------------------------------------------------
; 3) PLOTING
;-------------------------------------------------
device, decomposed=0  
loadct,5 

PS_Start, FILENAME = cOutPlot + 'reflectivity1.png'
plot,  aXEarthFinal, aEarthshine1, /nodata, title='Reflectivity of the Earthshine (Point Spectra Trace)', ytitle='Relative Reflectivity', xtitle='Wavelenght (' + micro + 'm)', xrange=[0.6, 0.8], yrange=[0,1]
oplot,  aXEarthFinal, aEarthshine1, color = 50
PS_End,/PNG

PS_Start, FILENAME = cOutPlot + 'reflectivity2.png'
plot,  aXEarthFinal, aEarthshine1, /nodata, title='Reflectivity of the Earthshine (Integrating Slits)', ytitle='Relative Reflectivity', xtitle='Wavelenght (' + micro + 'm)', xrange=[0.6, 0.8], yrange=[0,1]
oplot,  aXEarthFinal, aEarthshine1, color = 100
PS_End,/PNG


PS_Start, FILENAME = cOutPlot + 'spectra1.png'
plot,  aXEarthFinal, aEarthshineFrame1,/nodata, title='Spectra of the Earthshine (Point Spectra Trace)', ytitle='Relative Intensity', xtitle='Wavelenght (' + micro + 'm)',  xrange=[0.55, 0.8], yrange=[0.,0.2]
oplot,  aXEarthFinal, aEarthshineFrame1, color = 50
PS_End,/PNG

PS_Start, FILENAME = cOutPlot + 'spectra2.png'
plot,  aXEarthFinal, aEarthshineFrame1,/nodata, title='Spectra of the Earthshine (Integrating Slits)', ytitle='Relative Intensity', xtitle='Wavelenght (' + micro + 'm)',  xrange=[0.55, 0.8], yrange=[0.,0.2]
oplot,  aXEarthFinal, aEarthshineFrame1, color = 100
PS_End,/PNG


save, aEarthshineFrame1,  aXEarthFinal, aEarthshine1, aEarthshineFrame2, aEarthshine2, filename= cOut + 'earthshine_pixels2.dat'

end


