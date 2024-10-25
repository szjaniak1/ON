#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 2
=#

result16::Float16 = Float16(3.0) * (Float16(4.0) / Float16(3.0) - one(Float16)) - one(Float16)
println("[Float16] wynik otrzymany funkcja eps: {" * string(eps(Float16)) * "}; wynik obliczany sposobem Khana: {" * string(result16) * "}")

result32::Float32 = Float32(3.0) * (Float32(4.0) / Float32(3.0) - one(Float32)) - one(Float32)
println("[Float32] wynik otrzymany funkcja eps: {" * string(eps(Float32)) * "}; wynik obliczany sposobem Khana: {" * string(result32) * "}")

result64::Float64 = Float64(3.0) * (Float64(4.0) / Float64(3.0) - one(Float64)) - one(Float64)
println("[Float64] wynik otrzymany funkcja eps: {" * string(eps(Float64)) * "}; wynik obliczany sposobem Khana: {" * string(result64) * "}")