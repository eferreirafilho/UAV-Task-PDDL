(define (problem rover-3)

    (:domain 
        rover-domain3
    )
    
    (:objects
        waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6  
        
        objective1
        
        sample1

        rover1
    )
    
    (:init
        (= (battery-capacity) 100)
        (= (sample-capacity) 1)

        (waypoint waypoint1) (waypoint waypoint2) (waypoint waypoint3) 
        (waypoint waypoint4) (waypoint waypoint5) (waypoint waypoint6) 
        
        (can-move waypoint1 waypoint5)
        (can-move waypoint2 waypoint5) (can-move waypoint3 waypoint4) 
        (can-move waypoint3 waypoint6) (can-move waypoint4 waypoint3) 
        (can-move waypoint5 waypoint1) (can-move waypoint5 waypoint2)
        (can-move waypoint6 waypoint3) (can-move waypoint5 waypoint3)
        (can-move waypoint3 waypoint1) (can-move waypoint6 waypoint2)
        (can-move waypoint6 waypoint4) (can-move waypoint4 waypoint6)
        
        
        (is-in sample1 waypoint1)

        (is-recharging-dock waypoint1)
        (is-dropping-dock waypoint2)
        
        (rover rover1)
        (at rover1 waypoint6)
        (= (battery-amount rover1) 80)
        (= (recharge-rate rover1) 10) 
        (= (sample-amount rover1) 0)
    )
    
    (:goal
        (and 
            (stored-sample sample1)            
            (at rover1 waypoint1))
    )
    
    (:metric 
        minimize (total-time)
    )
)