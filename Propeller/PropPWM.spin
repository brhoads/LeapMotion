{Object_Title_and_Purpose}


CON                                           
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000
        MAXDUTY = 31
OBJ
  pwm      : "PWM_32_v4.spin"
  serial   : "FullDuplexSerial.spin"
  pst      : "FullDuplexSerial.spin"
PUB main | packet
  pst.start(31,30,%0000, 115200)  
  pwm.Start

  serial.start(0, 1, %0000, 115200)
  serial.str(string("Connected",10,13))

  repeat
    packet := serial.rx
    pst.bin(packet,8)
    pst.tx(10)
    pst.tx(13)
    pwm.PWM(17+(packet>>5),MAXDUTY-(packet & %00011111),(packet & %00011111))

{{  repeat
    repeat duty from 0 to MAXDUTY
      duty &= %00011111
      PWM.PWM(17+(%00001111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%00101111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%01001111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%01101111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%10001111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%10101111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%11001111>>5),MAXDUTY-duty,duty)
      PWM.PWM(17+(%11101111>>5),MAXDUTY-duty,duty)
      waitcnt(clkfreq/16+cnt)
    duty := 0
    repeat duty from 0 to MAXDUTY
      duty &= %00011111 
      PWM.PWM(17+(%00001111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%00101111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%01001111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%01101111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%10001111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%10101111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%11001111>>5),duty,MAXDUTY-duty)
      PWM.PWM(17+(%11101111>>5),duty,MAXDUTY-duty)         
      waitcnt(clkfreq/16+cnt)   }}