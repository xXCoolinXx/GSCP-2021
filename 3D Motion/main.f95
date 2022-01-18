program freefall

    implicit none    
    
    !Declare variables
    real(8) :: g, dt, t, max, pi, C_d, rho, r, m, launch_angle, v_i
    real(8), Allocatable, DIMENSION(:,:) :: x, v, a, vwind
    real(8), Allocatable, Dimension(:) :: KE, PE, E
    integer(4) :: i, steps

    !Open data files
    open(unit = 69, file="velocity.dat")
    open(unit = 420, file = "position.dat")
    open(unit = 666, file = "acceleration.dat")

    open(unit = 68, file="KE.dat")
    open(unit = 421, file = "PE.dat")
    open(unit = 667, file = "E.dat")
    
    !Initialize variables
    pi = 4*atan(1.0)
    g = -9.8
    max = 0

    dt = 0.001
    t = 100
    steps = floor(t/dt)
    

    ALLOCATE(x(3, steps), v(3, steps), a(3, steps), vwind(3,steps))
    ALLOCATE(KE(steps), PE(steps), E(steps))

    x(1,1) = 0
    x(2,1) = 0
    x(3,1) = 1 !1.01

    launch_angle = 50 * pi /180
    !launch_angle  = 26.4 * pi / 180
    !write(*,*) "Enter initial velocity"
    !read(*,*) v_i
    v_i = 20
    v(1,1) = v_i * cos(launch_angle)
    v(2,1) = 0
    v(3,1) = v_i * sin(launch_angle)
    vwind(1,:) = 0
    vwind(2,:) = 50
    vwind(3,:) = 0

    a(1,1) = 0
    a(2,1) = 0
    a(3,:) = g
    
    !Drag
    !m = 0.00972 !plastic !kg
    !r = 0.0253/2 !plastic 
    
    m = 0.6797 !steel 
    r = 0.02543/2 !steel !m
    
    C_d = 0.47 !?
    rho = 1.2754 !kg/m^3

    !Verlet
    x(:,2) = x(:,1) + v(:,1)*dt + 0.5 * dt**2 * a(:,1)
    a(:,2) = a(:,2) - 1/ (2*m) * C_d * pi * r**2 * rho * v(:,1) * norm2(v(:,1))

    do i = 3, steps
        !Oily
        !a(:,i) = a(:,i) - 1/ (2*m) * C_d * pi * r**2 * rho * (v(:,i-1) - vwind(:,i-1)) * norm2(v(:,i-1) - vwind(:,i-1))
        !v(:, i) = a(:, i) * dt + v(:, i-1)
        !x(:, i) = 0.5*(v(:, i) + v(:, i-1))*dt + x(:, i-1)

        !Verlet
        a(:,i-1) = a(:,i-1) - 1/ (2*m) * C_d * pi * r**2 * rho * (v(:,i-2) - vwind(:,i-2)) * norm2(v(:,i-2) - vwind(:,i-2))
        x(:, i) = 2 * x(:, i-1) - x(:, i-2) + dt**2 * a(:, i-1)
        v(:, i-1) = (x(:, i) - x(:, i-2)) / (2*dt)

        if(v(3,i-1) < 0 .AND. v(3,i-2) > 0 .AND. max==0) then
            max = x(3,i-1)
        end if

        if( x(3,i) <= r) then
            steps = i - 1
            exit
        end if
    end do

    write(*,*) "Max height was", max
    write(*,*) "Time was", steps*dt
    write(*,*) "Range was", norm2(x(:, steps) - x(:, 1))
    do i=1, steps
        write(420,*) i*dt, x(:, i)
        write(69,*) i*dt, v(:, i)
        write(666,*) i*dt, a(:, i)

        KE(i) = 0.5 * m * (x(1, i)**2 +  x(2, i)**2 + x(3,i)**2)
        PE(i) = -m*g*x(3,i)
        E(i) = KE(i) + PE(i)
        write(68,*) i*dt, KE(i)
        write(421,*) i*dt, PE(i)
        write(667,*) i*dt, E(i)
    end do
end program