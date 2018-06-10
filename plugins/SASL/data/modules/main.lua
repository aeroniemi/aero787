----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

size = {2048, 2048}
panelWidth3d = 2048
panelHeight3d = 2048
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
addSearchPath(moduleDirectory .. "/displays/pfd/")
addSearchPath(moduleDirectory .. "/displays/mfd/")
addSearchPath(moduleDirectory .. "/displays/radios")

-- Screen textures
--pfdDisplayTx = sasl.gl.createRenderTarget(1280, 960)

-- Fonts
fontLato = sasl.gl.loadFont("fonts/lato.ttf")
fontLatoBold = sasl.gl.loadFont("fonts/latoBold.ttf")
fontLatoBlack = sasl.gl.loadFont("fonts/latoBlack.ttf")
-- DO NOT USE
oxygenFont = sasl.gl.loadFont("fonts/Oxygen.ttf")

tailNumber = createGlobalPropertys("aero787/general/tailNumber", "G-TUIC", false, false)
selcalCode = createGlobalPropertys("aero787/general/selcalCode", "AL-CR", false, false)
flightNumber = createGlobalPropertys("aero787/general/flightNumber", "TOM85TH", false, false)
inverterSw = createGlobalPropertyi("aero787/cockpit/overhead/inverter", 0, false, false)
batterySw = createGlobalPropertyi("aero787/cockpit/overhead/battery", 0, false, false)
apuGenSw = createGlobalPropertyi("aero787/cockpit/overhead/apuGen", 0, false, false)
engGenSw = createGlobalPropertyi("aero787/cockpit/overhead/engGen", 0, false, false)
baroStd = createGlobalPropertyi("aero787/cockpit/baroStd", 1, false, false)
baroHpa = createGlobalPropertyi("aero787/cockpit/baroHpa", 1, false, false)
baroQfe = createGlobalPropertyi("aero787/cockpit/baroQfe", 0, false, false)
decisionHeight = createGlobalPropertyi("aero787/cockpit/decisionHeight", 100, false, false)
decisionBaro = createGlobalPropertyi("aero787/cockpit/decisionBaro", 1, false, false)
useMeters = createGlobalPropertyi("aero787/cockpit/useMeters", 0, false, false)
leftRadioPage = createGlobalPropertyi("aero787/cockpit/leftRadio/page", 1, false, false)
fun = createGlobalPropertyi("aero787/cockpit/fun", 1, false, false)

-- radio buttons
LR1 = sasl.createCommand("aero787/cockpit/leftRadio/LR1", " LR1 ")
LR2 = sasl.createCommand("aero787/cockpit/leftRadio", " LR2 ")
LR3 = sasl.createCommand("aero787/cockpit/leftRadio", " LR3 ")
LR4 = sasl.createCommand("aero787/cockpit/leftRadio", " LR4 ")
LR5 = sasl.createCommand("aero787/cockpit/leftRadio/LR5", " LR5 ")
LR6 = sasl.createCommand("aero787/cockpit/leftRadio", " LR6 ")
LR7 = sasl.createCommand("aero787/cockpit/leftRadio/LR7", " LR7 ")
LR8 = sasl.createCommand("aero787/cockpit/leftRadio", " LR8 ")

autoflightStatus = createGlobalPropertyi("aero787/cockpit/autoflightStatus", 1, false, false)

overspeedSpeed = createGlobalPropertyi("aero787/flying/overspeedSpeed", 390, false, false)
maxManSpeed = createGlobalPropertyi("aero787/flying/maxManSpeed", 360, false, false)

underspeedSpeed = createGlobalPropertyi("aero787/flying/underspeedSpeed", 220, false, false)
minManSpeed = createGlobalPropertyi("aero787/flying/minManSpeed", 230, false, false)
imperial = createGlobalPropertyi("aero787/flying/imperial", 0, false, false)
engineMode = createGlobalPropertyi("aero787/flying/autoflight/engineMode", 0, false, false)
engineMaxN1 = createGlobalPropertyf("aero787/flying/autoflight/engineMaxN1", 95.3, false, false)
engineExpN1 = createGlobalPropertyf("aero787/flying/autoflight/engineExpN1", 95.3, false, false)

-- AIR Datarefs
equipCoolFwd = createGlobalPropertyi("aero787/cockpit/overhead/air/equipCoolFwd", 0, false, false)
equipCoolAft = createGlobalPropertyi("aero787/cockpit/overhead/air/equipCoolAft", 0, false, false)
recircUpper = createGlobalPropertyi("aero787/cockpit/overhead/air/recircUpper", 0, false, false)
recircLower = createGlobalPropertyi("aero787/cockpit/overhead/air/recircLower", 0, false, false)
packLeft = createGlobalPropertyi("aero787/cockpit/overhead/air/packLeft", 0, false, false)
packRight = createGlobalPropertyi("aero787/cockpit/overhead/air/packRight", 0, false, false)
reset = createGlobalPropertyi("aero787/cockpit/overhead/air/reset", 0, false, false)
trimAirLeft = createGlobalPropertyi("aero787/cockpit/overhead/air/trimAirLeft", 0, false, false)
trimAirRight = createGlobalPropertyi("aero787/cockpit/overhead/air/trimAirRight", 0, false, false)
ventilation = createGlobalPropertyi("aero787/cockpit/overhead/air/ventilation", 0, false, false)
-- LIGHTS Datarefs
beacon = createGlobalPropertyi("aero787/cockpit/overhead/lights/beacon", 0, false, false)
nav = createGlobalPropertyi("aero787/cockpit/overhead/lights/nav", 0, false, false)
strobe = createGlobalPropertyi("aero787/cockpit/overhead/lights/strobe", 0, false, false)
taxi = createGlobalPropertyi("aero787/cockpit/overhead/lights/taxi", 0, false, false)
ldgLeft = createGlobalPropertyi("aero787/cockpit/overhead/lights/ldgLeft", 0, false, false)
ldgRight = createGlobalPropertyi("aero787/cockpit/overhead/lights/ldgRight", 0, false, false)
ldgNose = createGlobalPropertyi("aero787/cockpit/overhead/lights/ldgNose", 0, false, false)
rwyRight = createGlobalPropertyi("aero787/cockpit/overhead/lights/runwayRight", 0, false, false)
seatbelts = createGlobalPropertyi("aero787/cockpit/overhead/lights/seatbelts", 0, false, false)

c1Elec = createGlobalPropertyi("aero787/cockpit/overhead/hydra/c1Elec", 0, false, false)
c2Elec = createGlobalPropertyi("aero787/cockpit/overhead/hydra/c2Elec", 0, false, false)
LElec = createGlobalPropertyi("aero787/cockpit/overhead/hydra/LElec", 0, false, false)
RElec = createGlobalPropertyi("aero787/cockpit/overhead/hydra/RElec", 0, false, false)
LEng = createGlobalPropertyi("aero787/cockpit/overhead/hydra/LEng", 0, false, false)
REng = createGlobalPropertyi("aero787/cockpit/overhead/hydra/REng", 0, false, false)
-- Colours
colourBlack = {0, 0, 0, 1}
colourBlackHalf = {0, 0, 0, 0.3}
colourBlue = {0, 0.4, 0.8, 1}
colourBrown = {0.4, 0.2, 0, 1}
colourWhite = {1.0, 1.0, 1.0, 1.0}
colourPink = {1, 0, 1, 1.0}
colourGrey = {0.32, 0.32, 0.32, 1.0}
colourGreen = {0.04, 0.93, 0, 1.0}
colourCyan = {0.02, 0.96, 0.96, 1.0}
colourYellow = {1, 1, 0, 1.0}
colourRed = {1, 0, 0, 1.0}

propZuluTime = {
	globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours"),
	globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
}

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

function draw()
	drawAll(components)
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

function update()
	updateAll(components)
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

components = {
	--radio{},
	--transponder{},
	--chrono{},
	B787PFDcore {position = {0, 1088, 1280, 960}},
	B787MFDcore {position = {0, 128, 1280, 960}},
	B787radioLcore {position = {1280, 1568, 640, 480}}

	--PFD { position = { 284, 297, 100, 100 } }
}

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
