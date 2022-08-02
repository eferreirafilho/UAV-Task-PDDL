; Define the problem
; Only one sensor in a specific waypoint
; Only one "Surface Waypoint"
(define (problem p01)
    (:domain
        demeter-domain
    )
    (:objects
        ;Surface Waypoints
        cable_start sensor_surface_waypoint - Waypoint
        
        ;Cable Waypoints Sensors
        waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 waypoint7 waypoint8 waypoint9 waypoint10 - Waypoint


        
        ;Data from sensor
        data1 - Data

        ;robot
        vehicle1 - Vehicle
    )
    (:init

        ; Initialize battery capacity
        (= (battery-capacity) 100)
        (can-move cable_start waypoint1) (can-move waypoint1 waypoint2) (can-move waypoint2 waypoint3) (can-move waypoint3 waypoint4) (can-move waypoint4 waypoint5) (can-move waypoint5 waypoint6) (can-move waypoint6 waypoint7) (can-move waypoint7 waypoint8) (can-move waypoint8 waypoint9) (can-move waypoint9 waypoint10)
        (can-move waypoint1 cable_start) (can-move waypoint2 waypoint1) (can-move waypoint3 waypoint2) (can-move waypoint4 waypoint3) (can-move waypoint5 waypoint4) (can-move waypoint6 waypoint5) (can-move waypoint7 waypoint6) (can-move waypoint8 waypoint7) (can-move waypoint9 waypoint8) (can-move waypoint10 waypoint9)
        ; Define allowed moviments from underwater sensors to surface waypoints
        (can-move waypoint1 sensor_surface_waypoint) (can-move waypoint2 sensor_surface_waypoint) (can-move waypoint3 sensor_surface_waypoint) (can-move waypoint4 sensor_surface_waypoint) (can-move waypoint5 sensor_surface_waypoint) (can-move waypoint6 sensor_surface_waypoint) (can-move waypoint7 sensor_surface_waypoint)(can-move waypoint8 sensor_surface_waypoint) (can-move waypoint9 sensor_surface_waypoint) (can-move waypoint10 sensor_surface_waypoint)
        ; Allow moviment from surface to cable start
        (can-move sensor_surface_waypoint cable_start)        
        ; Define data in sensors
        (is-in data1 waypoint7); (is-in data2 waypoint5)
        ; Define transmit data positions (cable start and surface waypoints)
        (is-at-surface sensor_surface_waypoint) (is-at-surface cable_start)
        (empty vehicle1); (empty vehicle2); demeter start without data
        (at vehicle1 cable_start); (at vehicle2 cable_start); demeter start at cable start
        (= (battery-amount vehicle1) 50); (= (battery-amount vehicle2) 10) ; initial battery
        (= (recharge-rate vehicle1) 1); (= (recharge-rate vehicle2) 1) ; recharge rate
        ; Traverse cost between allowable waypoints
        (= (traverse-cost vehicle1 cable_start waypoint1) 3)
        (= (traverse-cost vehicle1 waypoint1 waypoint2) 1)
        (= (traverse-cost vehicle1 waypoint2 waypoint3) 1.2)
        (= (traverse-cost vehicle1 waypoint3 waypoint4) 1.4)
        (= (traverse-cost vehicle1 waypoint4 waypoint5) 1.6)
        (= (traverse-cost vehicle1 waypoint5 waypoint6) 1.8)
        (= (traverse-cost vehicle1 waypoint6 waypoint7) 2)             
        (= (traverse-cost vehicle1 waypoint7 waypoint8) 2.2)
        (= (traverse-cost vehicle1 waypoint8 waypoint9) 2.4)
        (= (traverse-cost vehicle1 waypoint9 waypoint10) 2.6)
        (= (traverse-cost vehicle1 waypoint1 cable_start) 3)
        (= (traverse-cost vehicle1 waypoint10 waypoint9) 2.6)
        (= (traverse-cost vehicle1 waypoint9 waypoint8) 2.4)
        (= (traverse-cost vehicle1 waypoint8 waypoint7) 2.2)
        (= (traverse-cost vehicle1 waypoint7 waypoint6) 2)
        (= (traverse-cost vehicle1 waypoint6 waypoint5) 1.8)
        (= (traverse-cost vehicle1 waypoint5 waypoint4) 1.6)
        (= (traverse-cost vehicle1 waypoint4 waypoint3) 1.4)
        (= (traverse-cost vehicle1 waypoint3 waypoint2) 1.2)
        (= (traverse-cost vehicle1 waypoint2 waypoint1) 1)
        (= (traverse-cost vehicle1 waypoint1 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint2 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint3 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint4 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint5 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint6 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint7 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint8 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint9 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 waypoint10 sensor_surface_waypoint) 5)
        (= (traverse-cost vehicle1 sensor_surface_waypoint cable_start) 5)            

    )
    (:goal
        (and
            (data-sent data1); (data-sent data2) ; Data have been sent
            (at vehicle1 cable_start) ; vehicle has to finish in the surface
            (= (battery-amount vehicle1) 100) ; Finish with full battery
        )
    )

    (:metric 
        minimize (total-time)
    )
)