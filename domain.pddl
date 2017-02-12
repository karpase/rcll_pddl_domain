(define (domain RCLL)
    (:requirements :typing :durative-actions)
    (:types
      Team - object
      Robot - object
      Workpiece - object
      BaseWorkpiece - Workpiece
      RingWorkpiece - Workpiece
      CapWorkpiece - Workpiece
      DummyMagazineEndWorkpiece - Workpiece
      DeliverySlide - object
      Magazine - object
      Order - object
      Location - object
      Machine - Location
      BaseStation - Machine
      CapStation - Machine
      RingStation - Machine
      DeliveryStation - Machine
      StartLocation - Location
      MachineSide - object
      OrderSizeType - object
      WorkpieceColor - object
    )
    (:constants
       InputSide - MachineSide
       OutputSide - MachineSide
       OrderType0 - OrderSizeType
       OrderType1 - OrderSizeType
       OrderType2 - OrderSizeType
       OrderType3 - OrderSizeType
       Black - WorkpieceColor
       Red - WorkpieceColor
       Transparent - WorkpieceColor
       Silver - WorkpieceColor
       Blue - WorkpieceColor
       Green - WorkpieceColor
       Yellow - WorkpieceColor
       Orange - WorkpieceColor
       Gray - WorkpieceColor
    )
    (:predicates
      (above ?wor - Workpiece ?wor1 - Workpiece)
      (hasShelf ?mac - Machine)
      (machineSideClear ?mac - Machine ?side - MachineSide)
      (slideClear ?cap - CapStation)
      (canPlaceRing ?rin - RingStation ?r - RingWorkpiece)
      (hasColor ?rin - RingStation ?c - WorkpieceColor)
      (slideOn ?del - DeliveryStation ?ds - DeliverySlide)
      (control ?tea - Team)
      (emptyGripper ?rob - Robot)
      (clear ?wor - Workpiece)
      (filled ?ord - Order)
      (orderPossibleDeliverySlide ?ord - Order ?slide - DeliverySlide)
      (machineOwner ?mac - Machine ?tea - Team)
      (capInSlide ?cap - CapStation ?cap1 - CapWorkpiece)
      (robotOwner ?rob - Robot ?tea - Team)
      (at ?rob - Robot ?loc - Location)
      (atMachineSide ?rob - Robot ?mac - MachineSide)
      (holding ?rob - Robot ?wor - Workpiece)
      (color ?wor - Workpiece ?wor1 - WorkpieceColor)
      (wpAtMachine ?wor - Workpiece ?mac - Machine)
      (wpAtMachineSide ?wor - Workpiece ?mac - MachineSide)
      (baseOf ?wor - Workpiece ?bas - BaseWorkpiece)
      (wpOnShelf ?wor - Workpiece ?mac - Machine)
      (magazineTop ?mag - Magazine ?wor - Workpiece)
      (nextInMagazine ?mag - Magazine ?wp - Workpiece ?wor - Workpiece)
      (magazineInMachineSide ?mag - Magazine ?machine - Machine ?mac1 - MachineSide)
      (assigned ?ord - Order ?bas - BaseWorkpiece)
      (orderType ?ord - Order ?ord1 - OrderSizeType)
      (orderBaseColor ?ord - Order ?wor - WorkpieceColor)
      (orderRing1Color ?ord - Order ?wor - WorkpieceColor)
      (orderRing2Color ?ord - Order ?wor - WorkpieceColor)
      (orderRing3Color ?ord - Order ?wor - WorkpieceColor)
      (orderCapColor ?ord - Order ?wor - WorkpieceColor)
    )
    (:durative-action dispenseBaseWorkpiece
     :parameters (?self - BaseStation ?baseWP - BaseWorkpiece ?magazine - Magazine ?nextWP - Workpiece ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?self ?team))
         (over all (magazineInMachineSide ?magazine ?self OutputSide))
         (at start (magazineTop ?magazine ?baseWP))
         (at start (nextInMagazine ?magazine ?baseWP ?nextWP))
         (at start (machineSideClear ?self OutputSide))
       )
     :effect
       (and
         (at start (not (magazineTop ?magazine ?baseWP)))
         (at start (not (nextInMagazine ?magazine ?baseWP ?nextWP)))
         (at end (magazineTop ?magazine ?nextWP))
         (at start (not (machineSideClear ?self OutputSide)))
         (at end (wpAtMachine ?baseWP ?self))
         (at end (wpAtMachineSide ?baseWP OutputSide))
       )
    )

    (:durative-action loadCapIntoSlide
     :parameters (?self - CapStation ?onWP - Workpiece ?capWP - CapWorkpiece ?baseWP - BaseWorkpiece ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?self ?team))
         (at start (wpAtMachine ?baseWP ?self))
         (at start (wpAtMachineSide ?baseWP InputSide))
         (at start (baseOf ?onWP ?baseWP))
         (at start (clear ?capWP))
         (at start (machineSideClear ?self OutputSide))
         (at start (above ?capWP ?onWP))
         (at start (slideClear ?self))
       )
     :effect
       (and
         (at end (capInSlide ?self ?capWP))
         (at start (not (wpAtMachineSide ?baseWP InputSide)))
         (at end (machineSideClear ?self InputSide))
         (at start (not (above ?capWP ?baseWP)))
         (at start (not (baseOf ?capWP ?baseWP)))
         (at start (clear ?capWP))
         (at end (wpAtMachineSide ?baseWP OutputSide))
         (at end (not (machineSideClear ?self OutputSide)))
         (at end (not (slideClear ?self)))
       )
    )

    (:durative-action placeCapOnWP
     :parameters (?self - CapStation ?onWP - Workpiece ?capWP - CapWorkpiece ?baseWP - BaseWorkpiece ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?self ?team))
         (at start (wpAtMachine ?baseWP ?self))
         (at start (wpAtMachineSide ?baseWP InputSide))
         (at start (baseOf ?onWP ?baseWP))
         (at start (clear ?onWP))
         (at start (capInSlide ?self ?capWP))
         (over all (machineSideClear ?self OutputSide))
       )
     :effect
       (and
         (at start (not (capInSlide ?self ?capWP)))
         (at start (not (wpAtMachineSide ?baseWP InputSide)))
         (at end (machineSideClear ?self InputSide))
         (at end (above ?capWP ?onWP))
         (at end (baseOf ?capWP ?baseWP))
         (at start (not (clear ?onWP)))
         (at end (wpAtMachineSide ?baseWP OutputSide))
         (at end (not (machineSideClear ?self OutputSide)))
         (at end (slideClear ?self))
       )
    )

    (:durative-action placeRingOnWP
     :parameters (?self - RingStation ?onWP - Workpiece ?ringWP - RingWorkpiece ?baseWP - BaseWorkpiece ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?self ?team))
         (at start (wpAtMachine ?baseWP ?self))
         (at start (wpAtMachineSide ?baseWP InputSide))
         (at start (baseOf ?onWP ?baseWP))
         (at start (clear ?onWP))
         (over all (machineSideClear ?self OutputSide))
         (at start (canPlaceRing ?self ?ringWP))
       )
     :effect
       (and
         (at start (not (canPlaceRing ?self ?ringWP)))
         (at start (not (wpAtMachineSide ?baseWP InputSide)))
         (at end (machineSideClear ?self InputSide))
         (at end (above ?ringWP ?onWP))
         (at end (clear ?ringWP))
         (at end (baseOf ?ringWP ?baseWP))
         (at start (not (clear ?onWP)))
         (at end (wpAtMachineSide ?baseWP OutputSide))
       )
    )

    (:durative-action deliverWorkpiece
     :parameters (?self - DeliveryStation ?slide - DeliverySlide ?baseWP - BaseWorkpiece ?team - Team ?order - Order)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?self ?team))
         (at start (wpAtMachine ?baseWP ?self))
         (at start (wpAtMachineSide ?baseWP InputSide))
         (at start (assigned ?order ?baseWP))
         (at start (orderPossibleDeliverySlide ?order ?slide))
         (at start (slideOn ?self ?slide))
       )
     :effect
       (and
         (at start (not (wpAtMachine ?baseWP ?self)))
         (at start (not (wpAtMachineSide ?baseWP InputSide)))
         (at end (machineSideClear ?self InputSide))
         (at end (filled ?order))
       )
    )

    (:durative-action moveMachineToMachine
     :parameters (?self - Robot ?from_machine - Machine ?from_side - MachineSide ?to_machine - Machine ?to_side - MachineSide ?team - Team)
     :duration (= ?duration 10)
     :condition 
       (and
         (over all (control ?team))
         (over all (robotOwner ?self ?team))
         (at start (at ?self ?from_machine))
         (at start (atMachineSide ?self ?from_side))
         (over all (machineOwner ?to_machine ?team))
       )
     :effect
       (and
         (at start (not (at ?self ?from_machine)))
         (at start (not (atMachineSide ?self ?from_side)))
         (at end (at ?self ?to_machine))
         (at end (atMachineSide ?self ?to_side))
       )
    )

    (:durative-action placeWorkpieceInMachine
     :parameters (?self - Robot ?wp - BaseWorkpiece ?machine - Machine ?side - MachineSide ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?machine ?team))
         (over all (robotOwner ?self ?team))
         (over all (at ?self ?machine))
         (over all (atMachineSide ?self ?side))
         (at start (holding ?self ?wp))
         (at start (machineSideClear ?machine ?side))
       )
     :effect
       (and
         (at start (not (holding ?self ?wp)))
         (at end (emptyGripper ?self))
         (at end (wpAtMachine ?wp ?machine))
         (at end (wpAtMachineSide ?wp ?side))
         (at start (not (machineSideClear ?machine ?side)))
       )
    )

    (:durative-action pickupWorkpieceFromMachine
     :parameters (?self - Robot ?wp - Workpiece ?machine - Machine ?side - MachineSide ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?machine ?team))
         (over all (robotOwner ?self ?team))
         (over all (at ?self ?machine))
         (over all (atMachineSide ?self ?side))
         (at start (wpAtMachine ?wp ?machine))
         (at start (wpAtMachineSide ?wp ?side))
         (at start (emptyGripper ?self))
       )
     :effect
       (and
         (at start (not (wpAtMachine ?wp ?machine)))
         (at start (not (wpAtMachineSide ?wp ?side)))
         (at end (machineSideClear ?machine ?side))
         (at end (holding ?self ?wp))
         (at start (not (emptyGripper ?self)))
       )
    )

    (:durative-action placeWorkpieceInMachineShelf
     :parameters (?self - Robot ?wp - BaseWorkpiece ?machine - Machine ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?machine ?team))
         (over all (robotOwner ?self ?team))
         (over all (hasShelf ?machine))
         (over all (at ?self ?machine))
         (at start (holding ?self ?wp))
       )
     :effect
       (and
         (at start (not (holding ?self ?wp)))
         (at end (emptyGripper ?self))
         (at end (wpOnShelf ?wp ?machine))
       )
    )

    (:durative-action pickupWorkpieceFromMachineShelf
     :parameters (?self - Robot ?wp - BaseWorkpiece ?machine - Machine ?team - Team)
     :duration (= ?duration 1)
     :condition 
       (and
         (over all (control ?team))
         (over all (machineOwner ?machine ?team))
         (over all (robotOwner ?self ?team))
         (over all (hasShelf ?machine))
         (over all (at ?self ?machine))
         (at start (wpOnShelf ?wp ?machine))
         (at start (emptyGripper ?self))
       )
     :effect
       (and
         (at start (not (wpOnShelf ?wp ?machine)))
         (at end (holding ?self ?wp))
         (at start (not (emptyGripper ?self)))
       )
    )

    (:durative-action moveStartToMachine
     :parameters (?self - Robot ?from - StartLocation ?to_machine - Machine ?to_side - MachineSide ?team - Team)
     :duration (= ?duration 10)
     :condition 
       (and
         (over all (control ?team))
         (over all (robotOwner ?self ?team))
         (at start (at ?self ?from))
         (over all (machineOwner ?to_machine ?team))
       )
     :effect
       (and
         (at start (not (at ?self ?from)))
         (at end (at ?self ?to_machine))
         (at end (atMachineSide ?self ?to_side))
       )
    )

    (:durative-action moveMachineToStart
     :parameters (?self - Robot ?from_machine - Machine ?from_side - MachineSide ?to - StartLocation ?team - Team)
     :duration (= ?duration 10)
     :condition 
       (and
         (over all (control ?team))
         (over all (robotOwner ?self ?team))
         (at start (at ?self ?from_machine))
         (at start (atMachineSide ?self ?from_side))
       )
     :effect
       (and
         (at start (not (at ?self ?from_machine)))
         (at start (not (atMachineSide ?self ?from_side)))
         (at end (at ?self ?to))
       )
    )

    (:durative-action assignWPtoOrder0
     :parameters (?self - Order ?baseWP - BaseWorkpiece ?baseColor - WorkpieceColor ?capWP - CapWorkpiece ?capColor - WorkpieceColor)
     :duration (= ?duration 0)
     :condition 
       (and
         (at start (orderType ?self OrderType0))
         (at start (orderBaseColor ?self ?baseColor))
         (at start (orderCapColor ?self ?capColor))
         (at start (color ?baseWP ?baseColor))
         (at start (color ?capWP ?capColor))
         (at start (above ?capWP ?baseWP))
         (at start (clear ?capWP))
       )
     :effect
       (at end (assigned ?self ?baseWP))
    )

    (:durative-action assignWPtoOrder1
     :parameters (?self - Order ?baseWP - BaseWorkpiece ?baseColor - WorkpieceColor ?capWP - CapWorkpiece ?capColor - WorkpieceColor ?ring1WP - RingWorkpiece ?ring1Color - WorkpieceColor)
     :duration (= ?duration 0)
     :condition 
       (and
         (at start (orderType ?self OrderType1))
         (at start (orderBaseColor ?self ?baseColor))
         (at start (orderRing1Color ?self ?ring1Color))
         (at start (orderCapColor ?self ?capColor))
         (at start (color ?baseWP ?baseColor))
         (at start (color ?ring1WP ?ring1Color))
         (at start (color ?capWP ?capColor))
         (at start (above ?ring1WP ?baseWP))
         (at start (above ?capWP ?ring1WP))
         (at start (clear ?capWP))
       )
     :effect
       (at end (assigned ?self ?baseWP))
    )

    (:durative-action assignWPtoOrder2
     :parameters (?self - Order ?baseWP - BaseWorkpiece ?baseColor - WorkpieceColor ?capWP - CapWorkpiece ?capColor - WorkpieceColor ?ring1WP - RingWorkpiece ?ring1Color - WorkpieceColor ?ring2WP - RingWorkpiece ?ring2Color - WorkpieceColor)
     :duration (= ?duration 0)
     :condition 
       (and
         (at start (orderType ?self OrderType2))
         (at start (orderBaseColor ?self ?baseColor))
         (at start (orderRing1Color ?self ?ring1Color))
         (at start (orderRing2Color ?self ?ring2Color))
         (at start (orderCapColor ?self ?capColor))
         (at start (color ?baseWP ?baseColor))
         (at start (color ?ring1WP ?ring1Color))
         (at start (color ?ring2WP ?ring2Color))
         (at start (color ?capWP ?capColor))
         (at start (above ?ring1WP ?baseWP))
         (at start (above ?ring2WP ?ring1WP))
         (at start (above ?capWP ?ring2WP))
         (at start (clear ?capWP))
       )
     :effect
       (at end (assigned ?self ?baseWP))
    )

    (:durative-action assignWPtoOrder3
     :parameters (?self - Order ?baseWP - BaseWorkpiece ?baseColor - WorkpieceColor ?capWP - CapWorkpiece ?capColor - WorkpieceColor ?ring1WP - RingWorkpiece ?ring1Color - WorkpieceColor ?ring2WP - RingWorkpiece ?ring2Color - WorkpieceColor ?ring3WP - RingWorkpiece ?ring3Color - WorkpieceColor)
     :duration (= ?duration 0)
     :condition 
       (and
         (at start (orderType ?self OrderType3))
         (at start (orderBaseColor ?self ?baseColor))
         (at start (orderRing1Color ?self ?ring1Color))
         (at start (orderRing2Color ?self ?ring2Color))
         (at start (orderRing3Color ?self ?ring3Color))
         (at start (orderCapColor ?self ?capColor))
         (at start (color ?baseWP ?baseColor))
         (at start (color ?ring1WP ?ring1Color))
         (at start (color ?ring2WP ?ring2Color))
         (at start (color ?ring3WP ?ring3Color))
         (at start (color ?capWP ?capColor))
         (at start (above ?ring1WP ?baseWP))
         (at start (above ?ring2WP ?ring1WP))
         (at start (above ?ring3WP ?ring2WP))
         (at start (above ?capWP ?ring3WP))
         (at start (clear ?capWP))
       )
     :effect
       (at end (assigned ?self ?baseWP))
    )

)

