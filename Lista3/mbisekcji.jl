module bisekcji
export mbisekcji

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

end