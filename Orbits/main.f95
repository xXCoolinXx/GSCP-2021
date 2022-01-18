program orbits

    implicit none    

    !Declare variables
    integer(4), PARAMETER :: RK_n = 4
    real(8) :: dt, t, max, pi, star_m, planet_m, GM, final_time, KE, PE, G
    real(8) :: star_state(6), star_a(3)
    real(8) :: planet_state(6), planet_a(3)
    real(8) :: temp(6), K(RK_n,6)
    integer(4) :: i

    !Open data files
    open(unit = 69, file="position.dat")
    open(unit = 420, file = "velocity.dat")
    open(unit = 666, file = "acceleration.dat")

    open(unit = 68, file="KE.dat")
    open(unit = 421, file = "PE.dat")
    open(unit = 667, file = "E.dat")
    
    !Initialize variables
    pi = 4*atan(1.0)
    max = 0
    planet_m = 1 !5.972 * 10.0**24
    star_m = 69
    GM = 4*pi**2
    G = 6.67408 * 10.0**(-11)

    dt = 0.01
    t = 0
    final_time = 100

    planet_state(1) = 1.0 
    planet_state(2) = 0
    planet_state(3) = 0

    planet_state(4) = 0
    planet_state(5) = 2*pi
    planet_state(6) = 0 !2*pi

    !star_state(1) = 0 
    !star_state(2) = 0
    !star_state(3) = 0
    !star_state(4) = 0
    !star_state(5) = 0
    !star_state(6) = 0

    !Approximation and write loop
    do while (t < final_time)
        t = t + dt 
        !Runge-kutta
        temp = planet_state
        do i = 1, 4
            !Update acceleration according to temp
            planet_a = - GM * temp(1:3) / norm2(temp(1:3))**3 !+ dt
            
            !Update the ith K
            K(i, 1:3) = temp(4:6)
            K(i, 4:6) = planet_a
            !Use the correct step size
            if (i >= 3) then 
                temp = planet_state + dt * K(i,:)
            else
                temp = planet_state + 0.5 * dt * K(i,:)
            end if
        end do
        !Get the final approximation
        planet_state = planet_state + dt * (K(1,:) + 2*K(2,:) + 2*K(3,:) + K(4,:)) / 6

        !temp = star_state
        !do i = 1, 4
        !    !Update acceleration according to temp
        !    star_a = - G * planet_m * temp(1:3) / norm2(temp(1:3))**3
        !    
        !    !Update the ith K
        !    K(i, 1:3) = temp(4:6)
        !    K(i, 4:6) = star_a
        !    !Use the correct step size
        !    if (i >= 3) then 
        !        temp = star_state + dt * K(i,:)
        !    else
        !        temp = star_state + 0.5 * dt * K(i,:)
        !    end if
        !end do
        !!Get the final approximation
        !star_state = star_state + dt * (K(1,:) + 2*K(2,:) + 2*K(3,:) + K(4,:)) / 6

        !Write to file
        write(69,*) planet_state(1:3), star_state(1:3)
        write(420,*) planet_state(4:6), star_state(4:6)
        write(666,*) planet_a, star_a

        !Energy
        KE = 0.5 * planet_m * norm2(planet_state(4:6)) ** 2
        PE = - GM*planet_m / norm2(planet_state(1:3))
        write(68,*) t, KE
        write(421, *) t, PE 
        write(667, *) t, KE + PE 
    end do
end program