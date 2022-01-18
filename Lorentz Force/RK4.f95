subroutine RK4(x, size_x, t, dt, derivsrk, param)
    implicit none

    integer(4) :: size_x, i
    real(8) :: K(4,size_x), temp(size_x), x(size_x)
    real(8) :: t, dt, param(*), derivsrk

    temp = x
    do i = 1, 4
        !Update acceleration according to temp
        !planet_a = - GM * temp(1:3) / norm2(temp(1:3))**3 + dt
        
        !Update the ith K
        K(i, 1:3) = temp(4:6)
        K(i, 4:6) = derivsrk(x, size_x, t, dt, param) !Calculate acceleration using derivsk
        !Use the correct step size
        if (i >= 3) then 
            temp = x + dt * K(i,:)
        else
            temp = x + 0.5 * dt * K(i,:)
        end if
    end do

    x = x + dt * (K(1,:) + 2*K(2,:) + 2*K(3,:) + K(4,:)) / 6

end subroutine