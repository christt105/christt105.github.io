# Cover images: what to create, and why one image never fits

The Stack theme reads a single frontmatter field (`image`, plus this site's
own `banner` on top of it) and reuses it for several boxes of very different
shape. No single source photo can look right in all of them — that's a
known, acknowledged limitation of the theme itself, not something specific
to this site. See
[hugo-theme-stack#1115](https://github.com/CaiJimmy/hugo-theme-stack/issues/1115):
the author measured the theme's own boxes (home list ~11:3, related-posts
~5:3, archives thumbnail 1:1) and concluded that satisfying all of them from
one image leaves as little as ~27% of the frame usable — the rest gets
cropped away in at least one context. Their proposed fix was CSS overrides
per box; a commenter suggested the more durable answer is to standardize on
a couple of purpose-built source images per post instead of fighting the
crop in code. That's the approach this site takes.

## The two boxes on this site

Checked directly against this site's actual templates (`layouts/_partials/`)
and CSS, not the theme's defaults, since several are already overridden here.

### `banner` — landscape, 1600×900 (16:9)

Used by: the big header on blog posts and `/projects/*` single pages, each
row in the `/blog/` index, and the `og:image`/`twitter:image` social preview.

Rendered up to ~1232px wide with CSS `object-fit: cover`, height capped at
`50vh` of the viewport on the single-page header (fixed 150–250px on index
rows). On short/wide screens the top and bottom get cropped off — **keep the
subject centered in the middle ~60% of the frame**, nothing important near
the top or bottom edge. This crop is a plain CSS center-crop, so it's at
least predictable.

Falls back to `image` if not set — fine for any post whose cover is already
landscape (most of them).

### `image` — square, 800×800 (1:1)

Used by: the category term-page badge (60×60), the compact list-item
thumbnail (60×60), and the `/projects/` grid card (contain inside a 4:3 box
— this one never crops, any ratio survives it).

The two 60×60 spots are generated via Hugo's `.Fill`, which defaults to
**"Smart" cropping** — an automatic anchor-detection heuristic, not a
guaranteed center-crop. The same #1115 report found Smart crop landing
off-center in inconsistent ways across differently-sized derivatives of the
same source. Don't rely on it protecting an off-center subject — **keep the
subject/logo centered with ~12-15% padding on all sides** so wherever Smart
crop lands, it's still inside the frame.

## Templates

`docs/image-templates/banner-template.png` and
`docs/image-templates/square-template.png` are blank canvases at the right
pixel size with the safe zone marked (blue border = safe, red-tinted band =
may get cropped). Open one as the bottom layer in whatever you're using to
build the cover and compose on top of it, then delete the guide layer before
exporting.

## When to bother with a separate `banner`

Most posts: don't. One landscape `image` (a photo, a screenshot, ~3:2 to
16:9) already works fine as both `image` and, by fallback, `banner`.

Only add a real `banner` when the actual asset is square or portrait —
typically a project logo. `content/projects/godosters/banner.png` and
`content/projects/elit3d/banner.png` are the current examples: since neither
project has real banner art, those are auto-generated placeholders (flat
`#1e1e1e` background matching the site's dark theme, logo centered at
40–55% of the canvas height) rather than a hand-made design — swap them for
real artwork if that ever exists.
