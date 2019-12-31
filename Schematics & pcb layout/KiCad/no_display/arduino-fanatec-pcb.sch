EESchema Schematic File Version 4
LIBS:arduino-fanatec-pcb-cache
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
L MCU_Module:Arduino_Nano_v3.x A1
U 1 1 5E03D530
P 5500 3550
F 0 "A1" H 5500 2461 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 5500 2370 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 5650 2600 50  0001 L CNN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 5500 2550 50  0001 C CNN
	1    5500 3550
	1    0    0    -1  
$EndComp
$Comp
L Logic_LevelTranslator:Simple_Chinese_Logic_level_shifter U1
U 1 1 5E047133
P 3450 3650
F 0 "U1" H 3450 4531 50  0000 C CNN
F 1 "Simple_Chinese_Logic_level_shifter" H 3450 4440 50  0000 C CNN
F 2 "Package_DIP:DIP-12_W10.16mm" H 3450 2900 50  0001 C CNN
F 3 "https://www.aliexpress.com/item/1972789887.html?spm=a2g0o.productlist.0.0.bbfa6f2fPhqdNn&algo_pvid=2205d59a-1fc0-49a4-90b1-846e095ca41e&algo_expid=2205d59a-1fc0-49a4-90b1-846e095ca41e-0&btsid=993594d5-036f-4640-9256-54d97fdaf998&ws_ab_test=searchweb0_0,searchweb201602_1,searchweb201603_53" H 3560 3745 50  0001 C CNN
	1    3450 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5E0466D1
P 3550 4550
F 0 "#PWR0101" H 3550 4300 50  0001 C CNN
F 1 "GND" H 3555 4377 50  0000 C CNN
F 2 "" H 3550 4550 50  0001 C CNN
F 3 "" H 3550 4550 50  0001 C CNN
	1    3550 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5E047AF8
P 6000 4650
F 0 "#PWR0102" H 6000 4400 50  0001 C CNN
F 1 "GND" H 6005 4477 50  0000 C CNN
F 2 "" H 6000 4650 50  0001 C CNN
F 3 "" H 6000 4650 50  0001 C CNN
	1    6000 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 4550 6000 4550
Wire Wire Line
	6000 4550 6000 4650
Wire Wire Line
	3550 4350 3550 4550
Wire Wire Line
	5000 4150 4350 4150
Wire Wire Line
	4350 3550 3850 3550
Wire Wire Line
	5000 4050 4250 4050
Wire Wire Line
	4250 3750 3850 3750
Wire Wire Line
	5000 4250 4450 4250
Wire Wire Line
	4450 3350 3850 3350
Wire Wire Line
	4450 4250 4450 3350
Wire Wire Line
	4250 4050 4250 3750
Wire Wire Line
	4350 4150 4350 3550
Wire Wire Line
	5000 3150 4550 3150
Wire Wire Line
	4550 3150 4550 3950
Wire Wire Line
	3850 3950 4550 3950
Wire Wire Line
	5700 2550 5700 2300
Wire Wire Line
	3550 2300 3550 2950
Wire Wire Line
	5700 2300 3550 2300
Wire Wire Line
	3050 3550 2750 3550
Wire Wire Line
	2750 3550 2750 3350
Wire Wire Line
	2750 3350 2400 3350
Wire Wire Line
	3050 3750 2650 3750
Wire Wire Line
	2650 3750 2650 3450
Wire Wire Line
	2650 3450 2400 3450
Wire Wire Line
	3350 4350 2550 4350
Wire Wire Line
	2550 4350 2550 3750
Wire Wire Line
	2550 3550 2400 3550
Wire Wire Line
	2400 3750 2550 3750
Connection ~ 2550 3750
Wire Wire Line
	2550 3750 2550 3550
Wire Wire Line
	3050 3350 2850 3350
Wire Wire Line
	2850 3350 2850 3850
Wire Wire Line
	2850 3850 2400 3850
Wire Wire Line
	2950 3950 2950 2950
Wire Wire Line
	2950 2950 3350 2950
Wire Wire Line
	3050 3950 3050 4050
Wire Wire Line
	3050 4050 2400 4050
Text Label 4950 2950 0    50   ~ 0
0
Wire Wire Line
	5000 2950 4950 2950
Wire Wire Line
	6000 4250 6050 4250
Wire Wire Line
	6050 4250 6050 4400
Wire Wire Line
	6050 4400 6600 4400
Wire Wire Line
	6000 4150 6100 4150
Wire Wire Line
	6100 4150 6100 4300
Wire Wire Line
	6100 4300 6600 4300
Wire Wire Line
	6000 4050 6150 4050
Wire Wire Line
	6150 4050 6150 4200
Wire Wire Line
	6150 4200 6600 4200
Wire Wire Line
	6000 3950 6200 3950
Wire Wire Line
	6200 3950 6200 4100
Wire Wire Line
	6200 4100 6600 4100
Wire Wire Line
	6000 3850 6250 3850
Wire Wire Line
	6250 3850 6250 4000
Wire Wire Line
	6250 4000 6600 4000
Wire Wire Line
	6000 3750 6300 3750
Wire Wire Line
	6300 3750 6300 3900
Wire Wire Line
	6300 3900 6600 3900
Wire Wire Line
	6350 3650 6350 3800
Wire Wire Line
	6350 3800 6600 3800
Wire Wire Line
	6400 3700 6600 3700
$Comp
L Connector_Generic:Conn_02x18_Odd_Even J3
U 1 1 5E0993EB
P 6800 3500
F 0 "J3" H 6850 4517 50  0000 C CNN
F 1 "Conn_02x18_Odd_Even" H 6850 4426 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x18_P2.54mm_Vertical" H 6800 3500 50  0001 C CNN
F 3 "~" H 6800 3500 50  0001 C CNN
	1    6800 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Small Diode1
U 1 1 5E0EED80
P 3000 2300
F 0 "Diode1" H 3000 2413 50  0000 C CNN
F 1 "." H 3000 2414 50  0001 C CNN
F 2 "Diode_THT:D_5W_P10.16mm_Horizontal" V 3000 2300 50  0001 C CNN
F 3 "~" V 3000 2300 50  0001 C CNN
	1    3000 2300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2450 2300 2900 2300
Wire Wire Line
	3100 2300 3550 2300
Connection ~ 3550 2300
Text Label 6550 2700 0    50   ~ 0
0
Wire Wire Line
	6600 2700 6550 2700
Text Label 6550 2800 0    50   ~ 0
1
Text Label 6550 2900 0    50   ~ 0
2
Text Label 6550 3000 0    50   ~ 0
3
Text Label 6550 3100 0    50   ~ 0
4
Text Label 6550 3200 0    50   ~ 0
5
Text Label 6550 3300 0    50   ~ 0
6
Wire Wire Line
	6000 4550 7100 4550
Wire Wire Line
	7100 4550 7100 4400
Connection ~ 6000 4550
Connection ~ 7100 2800
Wire Wire Line
	7100 2800 7100 2700
Connection ~ 7100 2900
Wire Wire Line
	7100 2900 7100 2800
Connection ~ 7100 3000
Wire Wire Line
	7100 3000 7100 2900
Connection ~ 7100 3100
Wire Wire Line
	7100 3100 7100 3000
Connection ~ 7100 3200
Wire Wire Line
	7100 3200 7100 3100
Connection ~ 7100 3300
Wire Wire Line
	7100 3300 7100 3200
Connection ~ 7100 3400
Wire Wire Line
	7100 3400 7100 3300
Connection ~ 7100 3500
Wire Wire Line
	7100 3500 7100 3400
Connection ~ 7100 3600
Wire Wire Line
	7100 3600 7100 3500
Connection ~ 7100 3700
Wire Wire Line
	7100 3700 7100 3600
Connection ~ 7100 3800
Wire Wire Line
	7100 3800 7100 3700
Connection ~ 7100 3900
Wire Wire Line
	7100 3900 7100 3800
Connection ~ 7100 4000
Wire Wire Line
	7100 4000 7100 3900
Connection ~ 7100 4100
Wire Wire Line
	7100 4100 7100 4000
Connection ~ 7100 4200
Wire Wire Line
	7100 4200 7100 4100
Connection ~ 7100 4300
Wire Wire Line
	7100 4300 7100 4200
Connection ~ 7100 4400
Wire Wire Line
	7100 4400 7100 4300
Wire Wire Line
	6550 3300 6600 3300
Wire Wire Line
	6550 3200 6600 3200
Wire Wire Line
	6550 3100 6600 3100
Wire Wire Line
	6550 3000 6600 3000
Wire Wire Line
	6550 2900 6600 2900
Wire Wire Line
	6550 2800 6600 2800
Text Label 4950 3050 0    50   ~ 0
1
Text Label 4950 3250 0    50   ~ 0
9
Text Label 4950 3350 0    50   ~ 0
8
Text Label 4950 3450 0    50   ~ 0
7
Text Label 4950 3550 0    50   ~ 0
6
Text Label 4950 3650 0    50   ~ 0
5
Text Label 4950 3750 0    50   ~ 0
4
Text Label 4950 3850 0    50   ~ 0
3
Text Label 4900 3950 0    50   ~ 0
2
Wire Wire Line
	4900 3950 5000 3950
Wire Wire Line
	4950 3850 5000 3850
Wire Wire Line
	4950 3750 5000 3750
Wire Wire Line
	4950 3650 5000 3650
Wire Wire Line
	4950 3550 5000 3550
Wire Wire Line
	4950 3450 5000 3450
Wire Wire Line
	4950 3350 5000 3350
Wire Wire Line
	4950 3250 5000 3250
Wire Wire Line
	4950 3050 5000 3050
$Comp
L Connector:Conn_01x08_Female J1
U 1 1 5E07D8D7
P 2200 3650
F 0 "J1" H 2092 4135 50  0000 C CNN
F 1 "Conn_01x08_Female" H 2092 4044 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical" H 2200 3650 50  0001 C CNN
F 3 "~" H 2200 3650 50  0001 C CNN
	1    2200 3650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2400 3950 2950 3950
Wire Wire Line
	2400 3650 2450 3650
Wire Wire Line
	2450 3650 2450 2300
Wire Wire Line
	6000 3650 6350 3650
Wire Wire Line
	6550 3400 6600 3400
Wire Wire Line
	6550 3500 6600 3500
Text Label 6550 3500 0    50   ~ 0
8
Text Label 6550 3400 0    50   ~ 0
7
Wire Wire Line
	6400 3550 6400 3700
Wire Wire Line
	6000 3550 6400 3550
Text Label 6550 3600 0    50   ~ 0
9
Wire Wire Line
	6550 3600 6600 3600
$EndSCHEMATC
