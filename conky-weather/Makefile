all: install

install: installdirs install-fonts

installdirs:
	mkdir -p /usr/local/share/fonts/truetype/conkyforecast

install-fonts:
	install -o root -g root -m 0644 fonts/ConkyWind.otf /usr/local/share/fonts/truetype/conkyforecast/
	install -o root -g root -m 0644 fonts/ConkyWeather.otf /usr/local/share/fonts/truetype/conkyforecast/
