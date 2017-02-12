(define (problem Planning_Problem)
    (:domain RCLL)
    (:objects
      RedTeam - Team
      BlueTeam - Team
      RedRobot1 - Robot
      RedRobot2 - Robot
      RedRobot3 - Robot
      BlueRobot1 - Robot
      BlueRobot2 - Robot
      BlueRobot3 - Robot
      RedBS - BaseStation
      RedCS1 - CapStation
      RedCS2 - CapStation
      RedRS2 - RingStation
      RedRS1 - RingStation
      RedDS - DeliveryStation
      BlueBS - BaseStation
      BlueCS1 - CapStation
      BlueCS2 - CapStation
      BlueRS1 - RingStation
      BlueRS2 - RingStation
      BlueDS - DeliveryStation
      o1 - Order
      RedBSMagazine1 - Magazine
      RedBSMagazine2 - Magazine
      RedBSMagazine3 - Magazine
      bwp1 - BaseWorkpiece
      bwp2 - BaseWorkpiece
      bwp3 - BaseWorkpiece
      bwp4 - BaseWorkpiece
      bwpc1 - BaseWorkpiece
      c1 - CapWorkpiece
      r1 - RingWorkpiece
      DeliverySlide1 - DeliverySlide
      RedStartLocation - StartLocation
      BlueStartLocation - StartLocation
      DummyMagazineEndWorkpiece1 - DummyMagazineEndWorkpiece
      DummyMagazineEndWorkpiece2 - DummyMagazineEndWorkpiece
      DummyMagazineEndWorkpiece3 - DummyMagazineEndWorkpiece
      r2 - RingWorkpiece
    )
    (:init
      ;;(above c1 bwpc1)
      (control RedTeam)
      (robotOwner RedRobot1 RedTeam)
      (at RedRobot1 RedStartLocation)
      ;;(emptyGripper RedRobot1)
      ;;(robotOwner RedRobot2 RedTeam)
      ;;(at RedRobot2 RedStartLocation)
      ;;(emptyGripper RedRobot2)
      ;;(robotOwner RedRobot3 RedTeam)
      ;;(at RedRobot3 RedStartLocation)
      ;;(emptyGripper RedRobot3)
      ;;(robotOwner BlueRobot1 BlueTeam)
      ;;(at BlueRobot1 BlueStartLocation)
      ;;(emptyGripper BlueRobot1)
      ;;(robotOwner BlueRobot2 BlueTeam)
      ;;(at BlueRobot2 BlueStartLocation)
      ;;(emptyGripper BlueRobot2)
      ;;(robotOwner BlueRobot3 BlueTeam)
      ;;(at BlueRobot3 BlueStartLocation)
      ;;(emptyGripper BlueRobot3)
      (machineOwner RedBS RedTeam)
      ;;(machineSideClear RedBS OutputSide)
      (machineOwner RedCS1 RedTeam)
      ;;(slideClear RedCS1)
      ;;(hasShelf RedCS1)
      ;;(machineSideClear RedCS1 InputSide)
      ;;(machineSideClear RedCS1 OutputSide)
      (machineOwner RedCS2 RedTeam)
      ;;(slideClear RedCS2)
      ;;(hasShelf RedCS2)
      ;;(machineSideClear RedCS2 InputSide)
      ;;(machineSideClear RedCS2 OutputSide)
      (machineOwner RedRS2 RedTeam)
      ;;(machineSideClear RedRS2 InputSide)
      ;;(machineSideClear RedRS2 OutputSide)
      ;;(canPlaceRing RedRS2 r2)
      (machineOwner RedRS1 RedTeam)
      ;;(machineSideClear RedRS1 InputSide)
      ;;(machineSideClear RedRS1 OutputSide)
      ;;(canPlaceRing RedRS1 r1)
      (machineOwner RedDS RedTeam)
      ;;(machineSideClear RedDS InputSide)
      ;;(slideOn RedDS DeliverySlide1)
      ;;(machineOwner BlueBS BlueTeam)
      ;;(machineOwner BlueCS1 BlueTeam)
      ;;(machineOwner BlueCS2 BlueTeam)
      ;;(machineOwner BlueRS1 BlueTeam)
      ;;(machineOwner BlueRS2 BlueTeam)
      ;;(machineOwner BlueDS BlueTeam)
      ;;(orderType o1 OrderType2)
      ;;(orderBaseColor o1 Black)
      ;;(orderRing1Color o1 Red)
      ;;(orderRing2Color o1 Red)
      ;;(orderCapColor o1 Red)
      ;;(orderPossibleDeliverySlide o1 DeliverySlide1)
      ;;(magazineTop RedBSMagazine1 bwp1)
      ;;(nextInMagazine RedBSMagazine1 bwp1 bwp2)
      ;;(nextInMagazine RedBSMagazine1 bwp2 DummyMagazineEndWorkpiece1)
      ;;(magazineInMachineSide RedBSMagazine1 RedBS OutputSide)
      ;;(magazineTop RedBSMagazine2 bwp3)
      ;;(nextInMagazine RedBSMagazine2 bwp3 DummyMagazineEndWorkpiece2)
      ;;(magazineInMachineSide RedBSMagazine2 RedBS OutputSide)
      ;;(magazineTop RedBSMagazine3 bwp4)
      ;;(nextInMagazine RedBSMagazine3 bwp4 DummyMagazineEndWorkpiece3)
      ;;(magazineInMachineSide RedBSMagazine3 RedBS OutputSide)
      ;;(color bwp1 Black)
      ;;(clear bwp1)
      ;;(baseOf bwp1 bwp1)
      ;;(color bwp2 Black)
      ;;(clear bwp2)
      ;;(baseOf bwp2 bwp2)
      ;;(color bwp3 Black)
      ;;(clear bwp3)
      ;;(baseOf bwp3 bwp3)
      ;;(color bwp4 Black)
      ;;(clear bwp4)
      ;;(baseOf bwp4 bwp4)
      ;;(color bwpc1 Transparent)
      ;;(baseOf bwpc1 bwpc1)
      ;;(wpOnShelf bwpc1 RedCS1)
      ;;(color c1 Red)
      ;;(clear c1)
      ;;(baseOf c1 bwpc1)
      ;;(color r1 Red)
      ;;(color r2 Red)
    )
    (:goal
      (and
        ;;(assigned o1 bwp1)
        ;;(filled o1)
	(at RedRobot1 RedBS)
      )
    )
)
