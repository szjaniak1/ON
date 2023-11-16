module mstycznych

function mstycznych(f::Function, pf::Function, x0::Float64, delta::Float64, epsilon::Float64, maxit::UInt64)
	err::UInt8 = 0
	it::UInt64 = 0
	x1 = Float64 = 0.0
	val::Float64 = f(x0)
	val_prime::Float64 = pf(x0)

	if abs(val) < epsilon
		return 0, x0, val, err
	end

	for it in range(maxit)
		
		if abs(val_prime) < epsilon
			err = 1
			break
		end

		x1 = x0 - val / val_prime

		if abs(x1 - x0) <= delta
			return x1, val, it, err
		end

		x0 = x1
	end

	return x0, val, it, err
end

end