import math

k = 0


def func(x):
	global k
	k += 1
	return x + 1 / math.log(x)


def first_derivative(x):
	global k
	k += 1
	return 1 - 1 / (x * (math.log(x) ** 2))

# Алгоритм средней точки
left = 1.5
right = 3
epsilon = 0.001
x = (left + right) / 2
dy = first_derivative(x)
while abs(dy) > epsilon:
	if dy < 0:
		left = x
	else:
		right = x
	x = (left + right) / 2
	dy = first_derivative(x)
print("x =", x, "за", k, "вызовов функций")

# Алгоритм хорд
left = 1.5
right = 3
epsilon = 0.001
d_left = first_derivative(left)
d_right = first_derivative(right)
continue_search = True

if d_left * d_right >= 0:
	continue_search = False

while continue_search:
	x = left - d_left / (d_left - d_right) * (left - right)
	d_x = first_derivative(x)
	if abs(d_x) <= epsilon:
		break
	if abs(d_x) > epsilon:
		if d_x > 0:
			right = x
			d_right = first_derivative(right)
		if d_x <= 0:
			left = x
			d_left = first_derivative(left)

result = 0
if d_left > 0 and d_right > 0:
	result = left
elif d_left < 0 and d_right < 0:
	result = right
else:
	result = (left if abs(d_left) < epsilon else right)
print("x =", result, "за", k, "вызовов функций")

