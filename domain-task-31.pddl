(define (domain waiting)
    (:requirements :adl )
    
    (:types
        waiter 
        customer 
        plate 
        broom ; added broom to sweep
        food ; added food, for dropped food
        location
    )
    
    (:constants x
        Agent - waiter
        BUFF - location
    )
    
    (:predicates
        (Adjacent ?x - location ?y - location)
        (At ?x - object ?y - location)
        (HasFood ?p - plate)
        (IsServed ?c - customer)
        (Holding ?x - object) ; changed Holding parameter from 'plate' to 'object' so a 'broom' can be held
        (IsHolding ?a - waiter)
        
        ; Additional predicate
        (BrokenPlate ?loc)
        (DroppedFood ?loc)
    )
    
    
    ;;;; ACTIONS
    
    (:action PickUp ; changed so can pick up broom
        :parameters (?x - object ?loc - location)
        :precondition (and 
            (not (Holding ?x)) 
            (not (IsHolding Agent))
           ; (not (HasFood ?x))
            (At ?x ?loc)
            (At Agent ?loc)
        )
        :effect (and 
            (Holding ?x)
            (IsHolding Agent)
        )
    )
    
    (:action HandOver
        :parameters (?p - plate ?loc - location ?c - customer)
        :precondition (and
            (At ?c ?loc)
            (At Agent ?loc)
            (Holding ?p)
            (IsHolding Agent)
            (HasFood ?p)
            (not (IsServed ?c))
        )
        :effect (and
            (not (Holding ?p))
            (not (IsHolding Agent))
            (IsServed ?c)
        )
    )
    
    (:action Fill
        :parameters (?p - plate)
        :precondition (and 
            (At Agent BUFF)
            (not (HasFood ?p))
            (Holding ?p)
            (IsHolding Agent)
        )
        :effect (HasFood ?p)
    )
    
    (:action Move 
        :parameters (?currloc - location ?newloc - location)
        :precondition (and
            (At Agent ?currloc)
            (Adjacent ?currloc ?newloc)
            
            ; The agent cannot Move into an area if it contains Broken Plate
            (not (BrokenPlate ?newloc))


        )
        :effect (and 
            (At Agent ?newloc)
            (not (At Agent ?currloc))
        )
    )
    
    ; The agent can remove broken plates and dropped food from an area by Sweeping it Up
    (:action SweepUp
        :parameters (?x - location ?y - location ?b - broom )
        :precondition (and 
            ; Agent must be At an adjacent location to the rubbish
            (At Agent ?x)
            (Adjacent ?x ?y)
            
            ; Agent must be holding a broom
            (Holding ?b)
            (IsHolding Agent)
            
            ; There must be a broken plate or dropped food at the target location
            (or (BrokenPlate ?y) (DroppedFood ?y))
        )
        :effect (and 
            (not (DroppedFood ?y))
            (not (BrokenPlate ?y))
        )
    )
    
    ; The agent cannot hold a plate and the broom at the same time, so must Put Down one item 
    ; to Pick Up the other
    (:action PutDown
        :parameters (?x - object ?loc - location)
        :precondition (and 
            (Holding ?x)
            (IsHolding Agent)
            (At Agent ?loc)
        )
        :effect (and 
            (At ?x ?loc)
            (not (IsHolding Agent))
            (not (Holding ?x))
            
        )
    )
    
)
