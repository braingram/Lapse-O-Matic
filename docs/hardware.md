There are many components on the PCB that do not need to be initially
installed. The stock LED on the ESP32 Camera is quite bright and might mean
that no additional LEDs are required (more on this in the LEDs section below).

## Schematic

It will be helpful to consult the schematic during assembly. This can be
opened as a pdf located at:
`Lapse-O-Matic_PCB/Lapse_O_Matic_PCB.pdf`
or opened directly in KiCAD by opening the project:
`Lapse-O-Matic_PCB/Lapse_O_Matic_PCB.pro`
then opening the schematic or opening the schematic directly:
`Lapse-O-Matic_PCB/Lapse_O_Matic_PCB.sch`

This document will refer to components with their designations on the schematic
(so SW1 for the power switch, R9 for the 330 ohm current limiting resistor for
D4 the trigger indicator LED).

## Component Modifications

A few components will require modifications to fit within the corresponding
footprints on the PCB.

### Switch (SW1)

The switch (SW1) has 2 metal support tabs that are too large for the slots in
the PCB. Use a dremel, file, sand paper or other abrasive to grind these down
until they fit within the slots. It could also be ok to completely cut them
off although it will place extra stress on the switch pins whenever the switch
is used, reinforcing the back of the switch with some hot glue would restore
some of this strength.

### Screw terminals (J10 and J2)

The pins for the screw terminals are slightly too large for the holes in the
PCB. The pins are square in cross section and grinding the edges off of the
square profile will allow them to fit through the holes.

## Unused components

The following components do not need to be installed as they are related to
unused features of this board.

- PIR trigger (this is entirely unused)
  - R1
  - R2
  - Q1
- Components related to the external trigger (the beam break will be directly
  connected to the ESP32 input).
  - D1
  - SW2
  - R6
  - R8
  - Q2


## Optional components

### LEDs

The ESP32 camera has a very bright LED. It is possible that this will be
sufficient and no extra LEDs will need to be installed. If you would like
to use the extra LEDs install the following:

- R11: 330
- R12: 100k
- Q3 (the silkscreen is reversed for this part, install it with the metal
  tab facing the ESP32 NOT aligned with the small white offset rectangular
  mark on the silkcreen)
- R13: see R16 below
- R14: see R16 below
- R15: see R16 below
- R16: these current limiting resistors will set the LED brightness installing
  5 ohm resistors each LED will consume 20 mA when enabled (the recommended
  maximum  value for continuous operation)
- D5: see D8 below
- D6: see D8 below
- D7: see D8 below
- D8: the OVLEW1CB9 parts are suitable for 3.3 volt power (the other LED part
  was not tested and has a lower rated brightness per watt)

## Components to install

### Power supply

The design uses a 3.3 volt regulator that is only used for battery/external
power. When powered via the programming header (installed below) the ESP32
will be powered via the 5V supplied by the programming cable and regulated
to 3.3 volts using the regulator onboard the ESP32. The following components
are used for the external 3.3 volt regulator:

- SW1 (see note above about modifying this part)
- C1: 1 uF  (these are thin film capacitors and polarity does not matter)
- C3: 1 uF
- U1: MCP1826S (be sure to align this part with the silkscreen, the metal tab
  of the TO-220 package should be closest to the edge of the PCB aligned with
  the small white rectangular region of the silkscreen)
- J10: 2 position screw terminal (see note about modification above)

### Programming header

The ESP32 can be programmed in-circuit using a FTDI cable. Note that this
cable must have 3.3 volt signaling and 5 volt VCC (like this one
[from Sparkfun](https://www.sparkfun.com/products/9717)). To program
the ESP32 you must

- remove power
- bridge the 2 programming pins (J5)
- reapply power
- upload your sketch

If using the standard FTDI cable (with a female socket) you will want to
install 0.1 inch male header pins on:

- J4: male headers
- J5: male headers (this can be bridged with a jumper or jumper wire)
- R3: 1k
- R4: 1k

### RTC

The real-time clock has a row of 0.1 inch female sockets. Install the
following mating part:

- J3: male headers

The clock time will be set based on the time on the computer at the time
the sketch was compiled. If you would like to use a pre-compiled hex file you
will need to comment out the line with `F(__DATE__)` in Lapse-O-Matic.ino and
the RTC will need to be pre-programmed some other way.

### ESP32

The ESP32 (U3) should be mounted using female 0.1 inch sockets (soldered to the
PCB) and male 0.1" headers (soldered to the ESP32).

U3 Pin 9 should NOT be connected (for the version of the ESP32 camera I have
this pin is connected to ESP32 reset so attaching this to ground will hold the
ESP32 in reset). Keeping this pin disconnected can be done by not adding a 0.1
inch header to Pin 9 on the ESP32.

### Beam Break

To connect the beam break sensor some creative soldering is required. This is
done to work around the input protection for the external trigger input and to
deal with the active low output of the beam break. The LED component of the
beam break can be powered directly from the 3.3 volt supply by connecting:

- red wire to the 3.3 pin (pin 3) of J1 (the pin closest to the external input)
- black wire to the ground pin (1) of J1 (the opposite pin)

The photodiode portion of the beam break also requires power which can be
drawn from the external trigger connector J2 (if installing the screw
terminal in J2, see note above about modifying the pins):

- red wire to J2 pin 3
- black wire to J2 pin 1 (the pin closest to the external trigger button)

The signal pin should be connected to the input pin (4, GPIO13) of the
ESP32. This is likely best done by soldering the male header of the white
wire to the back of the PCB so that the ESP32 camera can still be removed
from PCB.

To provide a pull-up for this signal the following additional parts
should be added:

- R10: 10k
- R9: this should be bridged (connected with a short length of wire)
- D4: this should also be bridged

The bridges above are to connect one side of R10 to 3.3 Volts (the other
end is connected to GPIO13).

## Camera sensor

The stock camera sensor is a OV2640. This can be swapped with a higher
resolution OV5640 by carefully lifting the black tab of the zero insertion
force (ZIF) connector where the flexible orange part of the camera sensor
is connected to the ESP32 camera board. After the tab is lifted the sensor
should require very little force to remove. The OV2640 can then be replaced
with the OV5640. When connecting the sensor be sure the flexible part of the
sensor is fully seated in the ZIF connector before closing the black tab.
Note that the firmware is configured to run at the highest resolution allowed
by the OV5640. If using the lower resolution OV2640 the `IMAGE_SIZE` define
in Lapse-O-Matic/config.h needs to be set to a lower value (see the comments
in that file for other possible settings).
