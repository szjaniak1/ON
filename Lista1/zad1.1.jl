#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.1
=#

function macheps16()::Float16
	mach16::Float16 = 1.0
	for i in 1:50
		if (Float16(1.0) + Float16(mach16 / 2.0) == Float16(1))
			break
		end
		mach16 = Float16(mach16 / 2)
	end
	mach16
end

function macheps32()::Float32
	mach32::Float32 = 1.0
	for i in 1:50
		if (Float32(1) + Float32(mach32 / 2) == Float32(1))
			break
		end
		mach32 = Float32(mach32 / 2)
	end
	mach32
end

function macheps64()::Float64
	mach64::Float64 = 1.0
	for i in 1:100
		if (Float64(1) + Float64(mach64 / 2) == Float64(1))
			break
		end
		mach64 = Float64(mach64 / 2)
	end
	mach64
end

println(string(eps(Float32)) * " -- " * string(macheps32()))