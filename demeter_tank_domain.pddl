; Simple UAV read sensor domain
; With action durations

(define (domain demeter-domain) 
    (:requirements :typing :fluents :durative-actions :duration-inequalities :negative-preconditions)

    (:types
        vehicle waypoint data   
    )

    (:functions
        (battery-amount ?v - vehicle)
        (recharge-rate ?v - vehicle)
        (battery-capacity)
    )

    (:predicates
        (can-move ?x - waypoint ?y - waypoint)
        (is-in ?d - data ?w - waypoint)
        (been-at ?v - vehicle ?w - waypoint)
        (carry ?v - vehicle ?d - data)
        (at ?v - vehicle ?w - waypoint)
        (is-at-surface ?w - waypoint)
        (data-sent ?d - data)
        ;(waypoint ?w - waypoint)
        ;(data ?d - data)
        ;(vehicle ?v - vehicle)
        (empty ?v - vehicle)
        (recharging ?v - vehicle)
    )
    ;define actions here
    (:durative-action move
        :parameters (?v - vehicle ?y ?z - waypoint)
        :duration(= ?duration 2)
        :condition (and 
            ;(at start (vehicle ?v))
            ;(at start (waypoint ?y))
            ;(at start (waypoint ?z))
            (over all (can-move ?y ?z)) 
            (at start (at ?v ?y))
            (at start (> (battery-amount ?v) 8)))
           
        :effect (and 
            (at end (at ?v ?z))
            (at end (been-at ?v ?y))
            (at start (not (at ?v ?y)))
            (at start (decrease (battery-amount ?v) 8)))
    )
    
    (:durative-action get-data
        :parameters (?v - vehicle ?d - data ?w - waypoint)
        :duration(= ?duration 15)
        :condition (and 
            ;(at start (vehicle ?v))
            ;(at start (data ?d))
            ;(at start (waypoint ?w))
            (at start (is-in ?d ?w))
            (over all (at ?v ?w))
            (at start (empty ?v))
            (at start (>= (battery-amount ?v) 50))
        )
        :effect (and 
            (at end (not (is-in ?d ?w)))
            (at end (carry ?v ?d))
            (at end (not (empty ?v)))
            (at start (decrease (battery-amount ?v) 50)) 
    )
    )
    (:durative-action transmit-data
        :parameters (?v - vehicle ?d - data ?w - waypoint)
        :duration (= ?duration 10)
        :condition (and 
            ;(at start (vehicle ?v))
            ;(at start (data ?d))
            ;(at start (waypoint ?w))
            (at start (is-at-surface ?w))
            (over all (at ?v ?w))
            (at start (carry ?v ?d))
            (at start (> (battery-amount ?v) 2)))
        
        :effect (and 
            (at end (is-in ?d ?w))
            (at end (not (carry ?v ?d)))
            (at end (data-sent ?d))
            (at end (empty ?v))     
            (at start (decrease (battery-amount ?v) 2))   
            )
    )
    (:durative-action recharge
        :parameters (?v - vehicle ?w - waypoint)

        :duration 
            (= ?duration 
                (/ (- 100 (battery-amount ?v)) (recharge-rate ?v)))
        :condition (and 
            ;(at start (vehicle ?v))
            ;(at start (waypoint ?w))
            (at start (at ?v ?w))
            (over all (is-at-surface ?w))
            (at start (< (battery-amount ?v) 100))
            ;(at start (recharging ?v))
        )
        :effect (and
            (at end (increase (battery-amount ?v) (* ?duration (recharge-rate ?v))))
        )
            
    )
)