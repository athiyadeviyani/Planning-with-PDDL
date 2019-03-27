(define (domain waiting)
    (:requirements :adl )
    
    (:types
        waiter
        customer
        plate
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
        (Holding ?p - plate)
        (IsHolding ?a - waiter)
    )
    
    
    ;;;; ACTIONS
    
    (:action PickUp
        :parameters (?p - plate ?loc - location)
        :precondition (and 
            (not (Holding ?p))
            (not (IsHolding Agent))
            (not (HasFood ?p))
            (At ?p ?loc)
            (At Agent ?loc)
        )
        :effect (and 
            (Holding ?p)
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
        )
        :effect (and 
            (At Agent ?newloc)
            (not (At Agent ?currloc))
        )
    )
    
)















