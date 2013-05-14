@writecol

pro fit


;**********************************************************************************
;**********************************************************************************
;
; [MARINA VON STEINKIRCH, SPRING/2012]
;
;**********************************************************************************
;**********************************************************************************

@constants

;--------------Reading Files
readcol, 'earthshine1.txt', eReflect, eWave
readcol, 'earthshine2.txt', eReflect2, eWave2
readcol, 'a.txt', aWave, aReflect		;atmosphere
readcol, 'g.txt', gWave, gReflect		;vegetation
readcol, 's.txt', sWave, sReflect		;ocean
readcol, 'r.txt', rWave, rReflect		;raylength
readcol, 't.txt', tWave, tReflect		;high


;---------------------------------------------------
; 1) Calculating Vegetation Edge and Raylength.
;---------------------------------------------------
iRr = where(eWave gt 0.65 and eWave lt  0.7)
iRi = where(eWave gt 0.74 and eWave lt  0.8)
cRr = median(eReflect[iRr])
cRi = median(eReflect[iRi])
VGE = (cRr-cRi)/cRi

iRr = where(eWave2 gt 0.65 and eWave2 lt  0.7)
iRi = where(eWave2 gt 0.74 and eWave2 lt  0.8)
cRr = median(eReflect2[iRr])
cRi = median(eReflect2[iRi])
VGE2 = (cRr-cRi)/cRi


iRb = where(eWave gt 0.5 and eWave lt  0.55)
iRr = where(eWave gt 0.65 and eWave lt  0.7)
cRb = median(eReflect[iRb])
cRr = median(eReflect[iRr])
RAY = (cRr-cRb)/cRb

print,VGE
print,VGE2
print, RAY


;---------------------------------------------------
; 2) Scaling, priting and saving output for fiting
;---------------------------------------------------
; ----- scaling to plot
aReflect = aReflect*10 -0.15
gReflect = gReflect*10
sReflect = sReflect*10
rReflect = rReflect*10
tReflect = tReflect*10 -0.15



device, decomposed=0  
loadct,5 

colors = [0,80,40,100, 5, 120] 
lines=[0,0,0,0, 0, 0]
names= ['Earthshine Spectra', 'Vegetation Reflection', 'Ocean Reflection', 'Atmosphere Transmission', 'Rayleigh Scattering', 'Neutral Reflectivity High Clouds']

PS_Start, FILENAME = cOutPlot + 'fit.png'
plot, eWave, eReflect, /nodata , title='Observed Reflectivity of Earthshine and Models ', ytitle='Relative Reflectivity', xtitle='Wavelenght (' + micro + 'm)', xrange=[0.5, 0.8], yrange=[0,1.2]
legend, names, color = colors, psym = lines, box=0, charsize=1

oplot,  eWave, eReflect, color = colors[0], psym=lines[0]
oplot,  gWave, gReflect, color = colors[1], psym=lines[1]
oplot,  sWave, sReflect, color = colors[2], psym = lines[2]
oplot,  aWave, aReflect, color = colors[3], psym = lines[3]
oplot,  rWave, rReflect, color = colors[4], psym = lines[4]
oplot,  tWave, tReflect, color = colors[5], psym = lines[5]

PS_End,/PNG

end


