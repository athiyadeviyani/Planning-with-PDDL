(define (domain waiting)
    (:requirements :adl )
    
    (:types
        ; add broom as an item
        waiter customer plate broom - item
        location
    )
    
    (:constants x
        Agent - waiter
        BUFF - location
    )
    
    (:predicates
        (Adjacent ?x - location ?y - location)
        (At ?x - item ?y - location)
        (HasFood ?p - plate)
        (IsServed ?c - customer)
        (Holding ?x - item) ; changed Holding parameter from 'plate' to 'item' so a 'broom' can be held
        (IsHolding ?a - waiter)
        
        ; Additional predicate
        (BrokenPlate ?loc - location)
    )
    
    
    ;;;; ACTIONS
    
    (:action PickUp
        :parameters (?a - waiter ?p - plate ?loc - location)
        :precondition (and 
            (not (Holding ?p))
            (not (IsHolding ?a))
            (not (HasFood ?p))
            (At ?p ?loc)
            (At Agent ?loc)
        )
        :effect (and 
            (Holding ?p)
            (IsHolding ?a)
        )
    )
    
    (:action HandOver
        :parameters (?p - plate ?loc - location ?a - waiter ?c - customer)
        :precondition (and
            (At ?c ?loc)
            (At Agent ?loc)
            (Holding ?p)
            (IsHolding ?a)
            (HasFood ?p)
            (not (IsServed ?c))
        )
        :effect (and
            (not (Holding ?p))
            (not (IsHolding ?a))
            (IsServed ?c)
        )
    )
    
    (:action Fill
        :parameters (?a - waiter ?p - plate)
        :precondition (and 
            (At Agent BUFF)
            (not (HasFood ?p))
            (Holding ?p)
            (IsHolding ?a)
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
        :parameters (?x - location ?y - location ?b - broom)
        :precondition (and 
            ; Agent must be At an adjacent location to the rubbish
            (At Agent ?x)
            (Adjacent ?x ?y)
            
            ; Agent must be holding a broom
            (Holding ?b)
            
            ; There must be a broken plate at the target location
            (BrokenPlate ?y)
        )
        :effect (not(BrokenPlate ?y))
    )
    
    ; The agent cannot hold a plate and the broom at the same time, so must Put Down one item 
    ; to Pick Up the other
    (:action PutDown
        :parameters (?a - waiter ?x - item ?loc - location)
        :precondition (and 
            (Holding ?x)
            (IsHolding ?a)
            (At Agent ?loc)
        )
        :effect (and 
            (At ?x ?loc)
            (not (Holding ?x))
            (not (IsHolding ?a))
        )
    )
    
)















