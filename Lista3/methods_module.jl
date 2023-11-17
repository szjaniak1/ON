#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadnanie 1, 2, 3
=#

module methods

export mbisekcji
export mstycznych
export msiecznych

NEAR_ZERO = 2^(-2.0^32)

function mstycznych(f::Function, pf::Function, x0::Float64, delta::Float64, epsilon::Float64, maxit::UInt64)
	err::UInt8 = 0
	it::UInt64 = 0
	x1::Float64 = 0.0
	val::Float64 = f(x0)
	val_prime::Float64 = 0.0

	if abs(val) < epsilon
		return x0, val, it, err
	end

	for it in 1:maxit
		val_prime = pf(x0)
		x1 = x0 - (val / val_prime)
		val = f(x1)

		if abs(val_prime) <= NEAR_ZERO || isinf(abs(val_prime))
			err = 2
			return x0, f(x0), it, err
		end

		if abs(x1 - x0) < delta || abs(val) < epsilon
			return x1, val, it, err
		end

		x0 = x1
	end

	err = 1
	return x0, val, it, err
end

function mbisekcji(f::Function, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
	err::UInt8 = 0
	it::UInt64 = 0
	val::Float64 = 0.0
	e::Float64 = b - a
	c::Float64 = (1 / 2)  * (a + b)

	u::Float64 = f(a)
	v::Float64 = f(b)
	if sign(u) == sign(v)
		err = 1
		return c, val, it, err
	end

	while abs(e) > epsilon && abs(f(c)) > delta
		e = e / 2
		c = a + e
		val = f(c)
		it = it + 1

		if abs(e) < delta || abs(val) < epsilon
			return c, val, it, err
		end

		if sign(val) != sign(u)
			b = c
			v = val
		else
			a = c
			u = val
		end
	end

	return c, val, it, err
end

function msiecznych(f::Function, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::UInt64)
	err::UInt8 = 0
	it::UInt64 = 0
	val::Float64 = f(x0)
	val_next::Float64 = f(x1)

	for it in 1:maxit
		if abs(val) > abs(val_next)
			x0, x1 = x1, x0
		end

		d = (x1 - x0) / (val_next - val)
		x1 = x0
		val_next = val

		x0 = x0 - d * val
		val = f(x0)

		if abs(val) < epsilon || abs(x1 - x0) < delta
			return x0, val, it, err
		end
	end

	err = 1
	return x0, val, it, err
end

end