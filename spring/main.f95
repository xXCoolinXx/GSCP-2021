program shm

    implicit none    
    
    !Declare variables
    real(8) :: k, m, dt, t, pi, w, C_d, rho, r
    real(8), allocatable, DIMENSION(:) :: x, v, a, KE, PE, E
    integer(4) :: i, steps

    !Open data files
    open(unit = 69, file="velocity.dat")
    open(unit = 420, file = "position.dat")
    open(unit = 666, file = "acceleration.dat")

    open(unit = 68, file = "KE.dat")
    open(unit = 421, file = "PE.dat")
    open(unit = 667, file = "E.dat")

    !Initialize variables
    k = 3.134
    !m = 0.100 
    m = 0.120
    w = k / m
    C_d = 4.6
    r = .207/2
    !rho = 0 
    rho = 1.2754
    pi = 4*atan(1.0)
    t = 5 !2 * pi * sqrt(1/w)! seconds
    dt = 0.01
    
    steps = floor(t / dt)
    
    ALLOCATE(x(steps),v(steps), a(steps)) 
    ALLOCATE(KE(steps), PE(steps), E(steps))
    
    !x(1) = 0.0712413566893 
    x(1) = 0.0803833021504
    v(1) = 0
    a(1) = -w * x(1)

    x(2) = x(1) + v(1)*dt + 0.5 * dt**2 * a(1)
    a(2) = - w * x(2) 
    v(2) = (x(2) - x(1)) / dt

    do i = 3, steps
        !Euler's method (bad)
        !a(i) = -w * x(i - 1)
        !v(i) = a(i)*dt + v(i-1) 
        !x(i) = 0.5*(v(i-1) + v(i))*dt + x(i-1) !Midpoint method

        !Verlet's method (good)
        !x(i) = 2 * x(i-1) - x(i-2) + dt**2 * a(i-1)
        !a(i) = -w * x(i)
        !v(i) = (2 * x(i) - 2 * x(i-1) + dt**2 * a(i)) / (2*dt)
        
        !Damping
        x(i) = 2 * x(i-1) - x(i-2) + dt**2 * a(i-1)
        a(i) = -w * x(i) - 1/ (2*m) * C_d * pi * r**2 * rho * v(i-1) * abs(v(i-1))
        v(i) = (2 * x(i) - 2 * x(i-1) + dt**2 * a(i)) / (2*dt)
        
    end do

    do i = 1, steps
        !Write all the values
        write(69, *) i*dt, ",", v(i)
        write(420, *) i*dt, ",", x(i) 
        write(666, *) i*dt, ",", a(i)

        KE(i) = 0.5 * m * (v(i))**2
        PE(i) = 0.5*k* (x(i))**2
        E(i)  = KE(i) + PE(i)
        write(68, *) i*dt, ",", KE(i)
        write(421, *) i*dt, ",", PE(i) 
        write(667, *) i*dt, ",", E(i)
    end do

end program