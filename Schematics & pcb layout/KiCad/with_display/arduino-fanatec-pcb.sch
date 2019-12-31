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
P 6050 4550
F 0 "A1" H 6050 3461 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 6050 3370 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 6200 3600 50  0001 L CNN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 6050 3550 50  0001 C CNN
	1    6050 4550
	1    0    0    -1  
$EndComp
$Comp
L Logic_LevelTranslator:Simple_Chinese_Logic_level_shifter U1
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
$Comp
L power:GND #PWR0102
U 1 1 5E047AF8
P 6550 5650
F 0 "#PWR0102" H 6550 5400 50  0001 C CNN
F 1 "GND" H 6555 5477 50  0000 C CNN
F 2 "" H 6550 5650 50  0001 C CNN
F 3 "" H 6550 5650 50  0001 C CNN
	1    6550 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5550 6550 5550
Wire Wire Line
	6550 5550 6550 5650
Wire Wire Line
	4100 5350 4100 5550
Wire Wire Line
	5550 5150 4900 5150
Wire Wire Line
	4900 4550 4400 4550
Wire Wire Line
	5550 5050 4800 5050
Wire Wire Line
	4800 4750 4400 4750
Wire Wire Line
	5550 5250 5000 5250
Wire Wire Line
	5000 4350 4400 4350
Wire Wire Line
	5000 5250 5000 4350
Wire Wire Line
	4800 5050 4800 4750
Wire Wire Line
	4900 5150 4900 4550
Wire Wire Line
	5550 4150 5100 4150
Wire Wire Line
	5100 4150 5100 4950
Wire Wire Line
	4400 4950 5100 4950
Wire Wire Line
	4100 3300 4100 3950
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
Text Label 5250 3950 0    50   ~ 0
D0
Wire Wire Line
	6550 5250 6600 5250
Wire Wire Line
	6600 5250 6600 5400
Wire Wire Line
	6600 5400 7150 5400
Wire Wire Line
	6550 5150 6650 5150
Wire Wire Line
	6650 5150 6650 5300
Wire Wire Line
	6650 5300 7150 5300
Wire Wire Line
	6550 5050 6700 5050
Wire Wire Line
	6700 5050 6700 5200
Wire Wire Line
	6700 5200 7150 5200
Wire Wire Line
	6550 4950 6750 4950
Wire Wire Line
	6750 4950 6750 5100
Wire Wire Line
	6750 5100 7150 5100
Wire Wire Line
	6550 4850 6800 4850
Wire Wire Line
	6800 4850 6800 5000
Wire Wire Line
	6800 5000 7150 5000
Wire Wire Line
	6550 4750 6850 4750
Wire Wire Line
	6850 4750 6850 4900
Wire Wire Line
	6850 4900 7150 4900
Wire Wire Line
	6900 4650 6900 4800
Wire Wire Line
	6900 4800 7150 4800
Wire Wire Line
	6950 4700 7150 4700
$Comp
L Connector_Generic:Conn_02x18_Odd_Even J3
U 1 1 5E0993EB
P 7350 4500
F 0 "J3" H 7400 5517 50  0000 C CNN
F 1 "Conn_02x18_Odd_Even" H 7400 5426 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x18_P2.54mm_Vertical" H 7350 4500 50  0001 C CNN
F 3 "~" H 7350 4500 50  0001 C CNN
	1    7350 4500
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Small Diode1
U 1 1 5E0EED80
P 3550 3300
F 0 "Diode1" H 3550 3413 50  0000 C CNN
F 1 "." H 3550 3414 50  0001 C CNN
F 2 "Diode_THT:D_5W_P10.16mm_Horizontal" V 3550 3300 50  0001 C CNN
F 3 "~" V 3550 3300 50  0001 C CNN
	1    3550 3300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3000 3300 3450 3300
Wire Wire Line
	3650 3300 4100 3300
Text Label 7100 3700 0    50   ~ 0
0
Wire Wire Line
	7150 3700 7100 3700
Text Label 7100 3800 0    50   ~ 0
1
Text Label 6800 3900 0    50   ~ 0
TM_CLK
Text Label 6800 4000 0    50   ~ 0
TM_D
Text Label 6800 4100 0    50   ~ 0
DP_U
Text Label 6800 4200 0    50   ~ 0
DP_D
Text Label 6800 4300 0    50   ~ 0
DP_L
Wire Wire Line
	6550 5550 7650 5550
Wire Wire Line
	7650 5550 7650 5400
Connection ~ 6550 5550
Connection ~ 7650 3800
Wire Wire Line
	7650 3800 7650 3700
Connection ~ 7650 3900
Wire Wire Line
	7650 3900 7650 3800
Connection ~ 7650 4000
Wire Wire Line
	7650 4000 7650 3900
Connection ~ 7650 4100
Wire Wire Line
	7650 4100 7650 4000
Connection ~ 7650 4200
Wire Wire Line
	7650 4200 7650 4100
Connection ~ 7650 4300
Wire Wire Line
	7650 4300 7650 4200
Connection ~ 7650 4400
Wire Wire Line
	7650 4400 7650 4300
Connection ~ 7650 4500
Wire Wire Line
	7650 4500 7650 4400
Connection ~ 7650 4600
Wire Wire Line
	7650 4600 7650 4500
Connection ~ 7650 4700
Wire Wire Line
	7650 4700 7650 4600
Connection ~ 7650 4800
Wire Wire Line
	7650 4800 7650 4700
Connection ~ 7650 4900
Wire Wire Line
	7650 4900 7650 4800
Connection ~ 7650 5000
Wire Wire Line
	7650 5000 7650 4900
Connection ~ 7650 5100
Wire Wire Line
	7650 5100 7650 5000
Connection ~ 7650 5200
Wire Wire Line
	7650 5200 7650 5100
Connection ~ 7650 5300
Wire Wire Line
	7650 5300 7650 5200
Connection ~ 7650 5400
Wire Wire Line
	7650 5400 7650 5300
Wire Wire Line
	7100 3800 7150 3800
Text Label 5250 4050 0    50   ~ 0
D1
Text Label 5250 4350 0    50   ~ 0
TM_D
Text Label 5250 4450 0    50   ~ 0
DP_U
Text Label 5250 4550 0    50   ~ 0
DP_D
Text Label 5250 4650 0    50   ~ 0
DP_L
Text Label 5250 4750 0    50   ~ 0
DP_R
Text Label 5250 4850 0    50   ~ 0
DP_M
Text Label 5250 4950 0    50   ~ 0
D10
Wire Wire Line
	5500 4850 5550 4850
Wire Wire Line
	5500 4750 5550 4750
Wire Wire Line
	5500 4650 5550 4650
Wire Wire Line
	5500 4550 5550 4550
Wire Wire Line
	5500 4450 5550 4450
$Comp
L Connector:Conn_01x08_Female J1
U 1 1 5E07D8D7
P 2750 4650
F 0 "J1" H 2642 5135 50  0000 C CNN
F 1 "Conn_01x08_Female" H 2642 5044 50  0000 C CNN
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
	3000 4650 3000 3300
Wire Wire Line
	6550 4650 6900 4650
Text Label 6800 4500 0    50   ~ 0
DP_M
Text Label 6800 4400 0    50   ~ 0
DP_R
Wire Wire Line
	6950 4550 6950 4700
Wire Wire Line
	6550 4550 6950 4550
Text Label 7000 4600 0    50   ~ 0
D10
$Comp
L Connector:Conn_01x04_Female J2
U 1 1 5E0D2281
P 6050 2850
F 0 "J2" H 6078 2826 50  0000 L CNN
F 1 "TM1637 4 digit Display connector" H 6078 2735 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Horizontal" H 6050 2850 50  0001 C CNN
F 3 "~" H 6050 2850 50  0001 C CNN
	1    6050 2850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5E0C11A5
P 5700 3050
F 0 "#PWR0103" H 5700 2800 50  0001 C CNN
F 1 "GND" V 5705 2922 50  0000 R CNN
F 2 "" H 5700 3050 50  0001 C CNN
F 3 "" H 5700 3050 50  0001 C CNN
	1    5700 3050
	0    1    1    0   
$EndComp
Connection ~ 4100 3300
Text Label 6400 3300 0    50   ~ 0
5V
Wire Wire Line
	6250 3300 4100 3300
Wire Wire Line
	6250 3550 6250 3300
Wire Wire Line
	6250 3300 6400 3300
Connection ~ 6250 3300
Text Label 5550 2850 0    50   ~ 0
TM_D
Text Label 5600 2950 0    50   ~ 0
5V
$Comp
L Switch:SW_Push DpadDown1
U 1 1 5E118348
P 4550 2500
F 0 "DpadDown1" H 4550 2693 50  0000 C CNN
F 1 "SW_Push" H 4550 2694 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4550 2700 50  0001 C CNN
F 3 "~" H 4550 2700 50  0001 C CNN
	1    4550 2500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push DpadLeft1
U 1 1 5E11D0BC
P 4550 2800
F 0 "DpadLeft1" H 4550 2993 50  0000 C CNN
F 1 "SW_Push" H 4550 2994 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4550 3000 50  0001 C CNN
F 3 "~" H 4550 3000 50  0001 C CNN
	1    4550 2800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push DpadRight1
U 1 1 5E11D0C2
P 4550 3100
F 0 "DpadRight1" H 4550 3293 50  0000 C CNN
F 1 "SW_Push" H 4550 3294 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4550 3300 50  0001 C CNN
F 3 "~" H 4550 3300 50  0001 C CNN
	1    4550 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 2200 4750 2500
Connection ~ 4750 2500
Wire Wire Line
	4750 2500 4750 2800
Wire Wire Line
	4750 2800 4750 3100
Connection ~ 4750 2800
$Comp
L power:GND #PWR0104
U 1 1 5E124EB3
P 4750 3100
F 0 "#PWR0104" H 4750 2850 50  0001 C CNN
F 1 "GND" V 4755 2972 50  0000 R CNN
F 2 "" H 4750 3100 50  0001 C CNN
F 3 "" H 4750 3100 50  0001 C CNN
	1    4750 3100
	0    -1   -1   0   
$EndComp
Connection ~ 4750 3100
Text Label 5250 4250 0    50   ~ 0
TM_CLK
Text Label 4100 2500 0    50   ~ 0
DP_D
Text Label 4100 2800 0    50   ~ 0
DP_L
Text Label 4100 3100 0    50   ~ 0
DP_R
Text Label 4100 2200 0    50   ~ 0
DP_U
$Comp
L Switch:SW_Push DpadUp1
U 1 1 5E0EDBBC
P 4550 2200
F 0 "DpadUp1" H 4550 2393 50  0000 C CNN
F 1 "SW_Push" H 4550 2394 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4550 2400 50  0001 C CNN
F 3 "~" H 4550 2400 50  0001 C CNN
	1    4550 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 1900 4750 2200
Text Label 4100 1900 0    50   ~ 0
DP_M
$Comp
L Switch:SW_Push Menu1
U 1 1 5E138078
P 4550 1900
F 0 "Menu1" H 4550 2093 50  0000 C CNN
F 1 "SW_Push" H 4550 2094 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4550 2100 50  0001 C CNN
F 3 "~" H 4550 2100 50  0001 C CNN
	1    4550 1900
	1    0    0    -1  
$EndComp
Text Label 5550 2750 0    50   ~ 0
TM_CLK
Wire Wire Line
	5550 2850 5850 2850
Wire Wire Line
	5550 2750 5850 2750
Wire Wire Line
	5600 2950 5850 2950
Wire Wire Line
	5700 3050 5850 3050
Wire Wire Line
	5250 4350 5550 4350
Wire Wire Line
	5250 4250 5550 4250
Wire Wire Line
	4350 1900 4100 1900
Wire Wire Line
	4350 2200 4100 2200
Wire Wire Line
	4100 2500 4350 2500
Wire Wire Line
	4350 2800 4100 2800
Wire Wire Line
	4100 3100 4350 3100
Wire Wire Line
	5250 4950 5550 4950
Wire Wire Line
	5250 4050 5550 4050
Wire Wire Line
	5250 3950 5550 3950
Wire Wire Line
	6800 3900 7150 3900
Wire Wire Line
	6800 4000 7150 4000
Wire Wire Line
	6800 4100 7150 4100
Wire Wire Line
	6800 4200 7150 4200
Wire Wire Line
	6800 4300 7150 4300
Wire Wire Line
	6800 4400 7150 4400
Wire Wire Line
	6800 4500 7150 4500
Wire Wire Line
	7000 4600 7150 4600
Connection ~ 4750 2200
$EndSCHEMATC
