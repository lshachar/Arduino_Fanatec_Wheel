EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L arduino-fanatec-pcb-rescue:Simple_Chinese_Logic_level_shifter-Logic_LevelTranslator U1
U 1 1 5E047133
P 4000 4650
F 0 "U1" H 4000 5531 50  0000 C CNN
F 1 "Simple_Chinese_Logic_level_shifter" H 4000 5440 50  0000 C CNN
F 2 "Package_DIP:DIP-12_W10.16mm" H 4000 3900 50  0001 C CNN
F 3 "https://www.aliexpress.com/item/1972789887.html?spm=a2g0o.productlist.0.0.bbfa6f2fPhqdNn&algo_pvid=2205d59a-1fc0-49a4-90b1-846e095ca41e&algo_expid=2205d59a-1fc0-49a4-90b1-846e095ca41e-0&btsid=993594d5-036f-4640-9256-54d97fdaf998&ws_ab_test=searchweb0_0,searchweb201602_1,searchweb201603_53" H 4110 4745 50  0001 C CNN
	1    4000 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5E0466D1
P 4100 5550
F 0 "#PWR0101" H 4100 5300 50  0001 C CNN
F 1 "GND" H 4105 5377 50  0000 C CNN
F 2 "" H 4100 5550 50  0001 C CNN
F 3 "" H 4100 5550 50  0001 C CNN
	1    4100 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 5350 4100 5550
Wire Wire Line
	3600 4550 3300 4550
Wire Wire Line
	3300 4550 3300 4350
Wire Wire Line
	3300 4350 2950 4350
Wire Wire Line
	3600 4750 3200 4750
Wire Wire Line
	3200 4750 3200 4450
Wire Wire Line
	3200 4450 2950 4450
Wire Wire Line
	3900 5350 3100 5350
Wire Wire Line
	3100 5350 3100 4750
Wire Wire Line
	3100 4550 2950 4550
Wire Wire Line
	2950 4750 3100 4750
Connection ~ 3100 4750
Wire Wire Line
	3100 4750 3100 4550
Wire Wire Line
	3600 4350 3400 4350
Wire Wire Line
	3400 4350 3400 4850
Wire Wire Line
	3400 4850 2950 4850
Wire Wire Line
	3500 4950 3500 3950
Wire Wire Line
	3500 3950 3900 3950
Wire Wire Line
	3600 4950 3600 5050
Wire Wire Line
	3600 5050 2950 5050
$Comp
L Device:D_Small Diode1
U 1 1 5E0EED80
P 3550 3450
F 0 "Diode1" H 3550 3563 50  0000 C CNN
F 1 "." H 3550 3564 50  0001 C CNN
F 2 "Diode_THT:D_5W_P10.16mm_Horizontal" V 3550 3450 50  0001 C CNN
F 3 "~" V 3550 3450 50  0001 C CNN
	1    3550 3450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3000 3450 3450 3450
$Comp
L Connector:Conn_01x08_Female J1
U 1 1 5E07D8D7
P 2750 4650
F 0 "J1" H 2642 5135 50  0000 C CNN
F 1 "SPI Connector 01x08_Male" H 2642 5044 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical" H 2750 4650 50  0001 C CNN
F 3 "~" H 2750 4650 50  0001 C CNN
	1    2750 4650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2950 4950 3500 4950
Wire Wire Line
	2950 4650 3000 4650
Wire Wire Line
	3000 4650 3000 3450
Text Notes 2600 4800 0    50   ~ 0
GND
Text Notes 2600 4600 0    50   ~ 0
GND
Text Notes 2650 4700 0    50   ~ 0
5V
Text Notes 2650 5100 0    50   ~ 0
CS
Text Notes 2600 5000 0    50   ~ 0
3V3
Text Notes 2600 4900 0    50   ~ 0
SCK
Text Notes 2550 4500 0    50   ~ 0
MOSI
Text Notes 2550 4400 0    50   ~ 0
MISO
Text Label 5050 4650 0    50   ~ 0
D7
Wire Wire Line
	5350 4850 5050 4850
Wire Wire Line
	5350 4750 5050 4750
Wire Wire Line
	5350 4650 5050 4650
Wire Wire Line
	5350 4550 5050 4550
Wire Wire Line
	5350 4450 5050 4450
Wire Wire Line
	5350 4350 5050 4350
Text Label 5050 4350 0    50   ~ 0
TM_D
Text Label 5050 4250 0    50   ~ 0
TM_CLK
Wire Wire Line
	5050 3950 5350 3950
Wire Wire Line
	5050 4050 5350 4050
Wire Wire Line
	5050 4250 5350 4250
Wire Wire Line
	6050 3450 6150 3450
Wire Wire Line
	6050 3550 6050 3450
Text Label 6150 3450 0    50   ~ 0
5V
Text Label 5050 4950 0    50   ~ 0
D10
Text Label 5050 4850 0    50   ~ 0
D9
Text Label 5050 4450 0    50   ~ 0
D5
Text Label 5050 4550 0    50   ~ 0
D6
Text Label 5050 4750 0    50   ~ 0
D8
Text Label 5050 4050 0    50   ~ 0
D1
Text Label 5050 3950 0    50   ~ 0
D0
Wire Wire Line
	6350 5550 6350 5650
Wire Wire Line
	5950 5550 6350 5550
$Comp
L power:GND #PWR0102
U 1 1 5E047AF8
P 6350 5650
F 0 "#PWR0102" H 6350 5400 50  0001 C CNN
F 1 "GND" H 6355 5477 50  0000 C CNN
F 2 "" H 6350 5650 50  0001 C CNN
F 3 "" H 6350 5650 50  0001 C CNN
	1    6350 5650
	1    0    0    -1  
$EndComp
$Comp
L arduino-fanatec-pcb-rescue:Arduino_Nano_v3.x-MCU_Module A1
U 1 1 5E03D530
P 5850 4550
F 0 "A1" H 5850 3461 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 5850 3370 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 6000 3600 50  0001 L CNN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 5850 3550 50  0001 C CNN
	1    5850 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 4950 4800 4950
Wire Wire Line
	5350 4150 4800 4150
Wire Wire Line
	4700 4350 4400 4350
Wire Wire Line
	5350 5250 4700 5250
Wire Wire Line
	4700 5250 4700 4350
Wire Wire Line
	4600 4550 4400 4550
Wire Wire Line
	5350 5150 4600 5150
Wire Wire Line
	4600 5150 4600 4550
Wire Wire Line
	4500 4750 4400 4750
Wire Wire Line
	5350 5050 4500 5050
Wire Wire Line
	4500 5050 4500 4750
Connection ~ 6050 3450
Wire Wire Line
	6050 3450 4100 3450
Wire Wire Line
	4100 3450 4100 3950
Wire Wire Line
	3650 3450 4100 3450
Connection ~ 4100 3450
Wire Wire Line
	4800 4150 4800 4950
Wire Wire Line
	4800 4950 5350 4950
Connection ~ 4800 4950
$EndSCHEMATC
