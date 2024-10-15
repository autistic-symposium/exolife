@writecol

pro diagrams


;**********************************************************************************
;**********************************************************************************
;
; [MARINA VON STEINKIRCH, SPRING/2012]
;
;**********************************************************************************
;**********************************************************************************

@constants

;--------------Reading Files
restore, cOut + 'earthshine_pixels2.dat'	; aEarthshineFrame1,2,  aXEarthFinal, aEarthshine1,2

;------------------------------------------------
; 1) Molecular Fitting
;------------------------------------------------

cRange=where(aXEarthFinal gt 0.76 and aXEarthFinal lt  0.77); 02(A)
cBand1 = min(aEarthshine1[cRange])
iBand1 =  where(aEarthshine1 eq cBand1)


cRange=where(aXEarthFinal gt 0.68 and aXEarthFinal lt  0.70); 02(B)
cBand2 = min(aEarthshine1[cRange])
iBand2 =  where(aEarthshine1 eq cBand2)

waterx = [0.715,0.735]
watery = [0.4551,0.4551]
o3x = [0.6,0.68]
o3y = [0.52,0.52]

lines = [0,0,0]
colors = [100,50,70]

device, decomposed=0  
loadct,5 

PS_Start, FILENAME = cOutPlot + 'mo1.png'
plot,  aXEarthFinal, aEarthshine1*8/10, /nodata, title='Molecular Bands of the Earthshine ', ytitle='Relative Reflectivity', xtitle='Wavelenght (' + micro + 'm)', xrange=[0.6, 0.8], yrange=[0,0.8]
oplot,  aXEarthFinal, aEarthshine1*8/10, color = 0, psym = lines[0]
oplot,  waterx, watery, color = colors[0], psym = lines[0]
xyouts, 0.715, 0.4, 'H2O', CHARSIZE=2, noclip=1, color=colors[0]
oplot,  o3x, o3y, color = colors[2], psym = lines[0]
xyouts, 0.63, 0.45, 'O3', CHARSIZE=2, noclip=1, color=colors[2]
xyouts, 0.76, aEarthshine1[iBand1], '02(A)', orientation=90, CHARSIZE=2, noclip=1, color=150
xyouts, aXEarthFinal[iBand2],  0.6, '02(B)', orientation=90,CHARSIZE=2, noclip=1, color = 150
PS_End,/PNG


writecol, 'earthshine1.txt', aEarthshine1, aXEarthFinal
writecol, 'earthshine2.txt', aEarthshine2, aXEarthFinal

end


