(define (domain waiting)
    (:requirements :adl )
    
    (:types
        waiter customer plate - item
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
        (Holding ?p - plate)
        (IsHolding ?a - waiter)
    )
    
    
    ;;;; ACTIONS
    
    (:action PickUp
        :parameters (?a - waiter ?p - plate ?loc - location)
        :precondition (and 
            (not (Holding ?p))
            (not (IsHolding ?a))
            (not (HasFood ?p))
            (At ?p ?loc)
            (At ?a ?loc)
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
            (At ?a ?loc)
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
            (At ?a BUFF)
            (not (HasFood ?p))
            (Holding ?p)
            (IsHolding ?a)
        )
        :effect (HasFood ?p)
    )
    
    (:action Move 
        :parameters (?a - waiter ?currloc - location ?newloc - location)
        :precondition (and
            (At ?a ?currloc)
            (Adjacent ?currloc ?newloc)
        )
        :effect (and 
            (At ?a ?newloc)
            (not (At ?a ?currloc))
        )
    )
    
)















