#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.2
=#

function macheta16()::Float16
    eta16::Float16 = 1.0
    while Float16(eta16 / 2.0) != Float16(0.0)
        mach16 = Float16(eta16 / 2)
    end
    eta16
end

function macheta32()::Float32
    eta32::Float32 = 1.0
    while Float32(eta32 / 2) != Float32(0.0)
        eta32 = Float32(eta32 / 2)
    end
    eta32
end

function macheta64()::Float64
    eta64::Float64 = 1.0
    while Float64(eta64 / 2) != Float64(0.0)
        eta64 = Float64(eta64 / 2)
    end
    eta64
end

println("[Float16] wynik otrzymany funkcja nextfloat: {" * string(nextfloat(Float16(0.0))) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheta16()) * "}")
println("[Float16] wynik otrzymany funkcja nextfloat: {" * string(nextfloat(Float32(0.0))) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheta32()) * "}")
println("[Float16] wynik otrzymany funkcja nextfloat: {" * string(nextfloat(Float64(0.0))) * "}; wynik obliczany zaimplementowana funkcja: {" * string(macheta64()) * "}")