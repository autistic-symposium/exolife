;-------------------------------------------------------------------------------------------
; Constants and variables.
;--------------------------------------------------------------------------------------------
cNumberFilesDark = 10
cNumberFilesBright = 11
cNumberFilesBright15 = 5
cNumberFilesBright30 = 6
cNumberExpTime = 3
cNumberFilesDarkCal=10
cFrameSizeX = 765
cFrameSizeY = 510

microletter = "155B
micro = '!9' + String(microletter) + '!X' 

;cSizeStrips = [[0,120], [170,200],[260, 290], [340,450]]

cOut = 'output/'
cOutPlot = 'output/plots/'
cBrightFolder = ['bright/15/', 'bright/30/']
cDarkFolder = 'dark/'
cStandFolder = 'cal/'
cDarkCalFolder = ['darkcal/15/','darkcal/30/','darkcal/120/'] 

cNeonLines =  [ 7032.41, 6402.25] ; first peak, second peak

aDark = fltarr (cNumberFilesDark,cFrameSizeX,cFrameSizeY)
aBright15 = fltarr (cNumberFilesBright15,cFrameSizeX,cFrameSizeY)
aBright30 = fltarr (cNumberFilesBright30,cFrameSizeX,cFrameSizeY)
aDarkPre = fltarr (cNumberFilesDark,cFrameSizeX,cFrameSizeY)
aBright15Pre = fltarr (cNumberFilesBright15,cFrameSizeX,cFrameSizeY)

aDarkCal15 = fltarr(cNumberFilesDarkCal,cFrameSizeX,cFrameSizeY)
aDarkCal30 = fltarr(cNumberFilesDarkCal,cFrameSizeX,cFrameSizeY)
aDarkCal120 = fltarr(cNumberFilesDarkCal,cFrameSizeX,cFrameSizeY)

aDarkFrame = fltarr(cFrameSizeX,cFrameSizeY)
aBright15Frame = fltarr(cFrameSizeX,cFrameSizeY)
aBright30Frame = fltarr(cFrameSizeX,cFrameSizeY)

aDarkCal15Frame = fltarr(cFrameSizeX,cFrameSizeY)
aDarkCal30Frame = fltarr(cFrameSizeX,cFrameSizeY)
aDarkCal120Frame = fltarr(cFrameSizeX,cFrameSizeY)

aEarthshineFrame = fltarr(cFrameSizeX)
aEarthshineSkyFrame = fltarr(cFrameSizeX)
aEarthshineFrame2 = fltarr(cFrameSizeX)
aEarthshineSkyFrame2 = fltarr(cFrameSizeX)
aEarthshineFrame1 = fltarr(cFrameSizeX)
aMoonshineSkyFrame1 = fltarr(cFrameSizeX)
aMoonshineFrame1 = fltarr(cFrameSizeX)
aMoonshineSkyFrame2 = fltarr(cFrameSizeX)
aMoonshineFrame2 = fltarr(cFrameSizeX)
aEarthshine1 = fltarr(cFrameSizeX)
aEarthshine2 = fltarr(cFrameSizeX)

