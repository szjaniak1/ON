#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.1
=#

function macheps16()::Float16
    mach16::Float16 = 1.0
    while Float16(1.0) + Float16(mach16 / 2.0) != Float16(1.0)
        mach16 = Float16(mach16 / 2.0)
    end
    mach16
end

function macheps32()::Float32
    mach32::Float32 = 1.0
    while Float32(1.0) + Float32(mach32 / 2.0) != Float32(1.0)
        mach32 = Float32(mach32 / 2.0)
    end
    mach32
end

function macheps64()::Float64
    mach64::Float64 = 1.0
    while Float64(1.0) + Float64(mach64 / 2.0) != Float64(1.0)
        mach64 = Float64(mach64 / 2.0)
    end
    mach64
end

println("[Float16] wynik otrzymany funkcja eps: {" * string(eps(Float16)) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheps16()) * "}")
println("[Float32] wynik otrzymany funkcja eps: {" * string(eps(Float32)) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheps32()) * "}")
println("[Float64] wynik otrzymany funkcja eps: {" * string(eps(Float64)) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheps64()) * "}")