.PHONY: build present

# Depends on imagemagick

build:
	reveal-md index.md --static _site
	reveal-md index.md --print _site/slides.pdf
        # Use --no-sandbox for Puppeteer when printing PDF
	PUPPETEER_ARGS="--no-sandbox" reveal-md index.md --print _site/slides.pdf
	# make webp version of of each slide
	mkdir -p _site/webp
	convert -density 300 _site/slides.pdf -quality 90 _site/webp/slides.png
	for f in _site/webp/*.png; do \
		convert $$f -quality 90 $${f%.png}.webp; \
	done
	rm _site/webp/*.png

present:
	reveal-md index.md --watch

clean:
	rm -rf _site
