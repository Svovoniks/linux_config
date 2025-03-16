import sys
st = ""

for i in sys.argv[1:]:
	st+=(i+" ")

st = st[:-1]

for n in range(0, 27):
	final = ""
	for i in range(len(st)):
		ch = st[i]

		if ch == " ":
			final +=ch
			continue

		if ch.isupper():
			a = "A"
			z = "Z"
		else:
			a = "a"
			z = "z"

		num = ord(ch)+n
		if (num > ord(z)):
			num-=(ord(z) - ord(a) +1)
		final+=chr(num)
	print(str(n) + " " + final)
input()
