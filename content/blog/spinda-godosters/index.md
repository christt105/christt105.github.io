---
title: "Spinda: Analyzing its code across multiple projects and how I recreated it in Godosters"
description: A deep dive into the code of Pokémon Emerald, Essentials, Unity, and other tools to understand how the 4+ billion Spinda patterns are generated and how I implemented it in Godot 4.
date: 2026-06-28
image: cover.png
keywords:
  - godot
  - game dev
  - pokémon
  - spinda
  - shaders
  - emerald
  - essentials
  - unity
readingTime: true
comments: true
draft: false
categories:
  - Godosters
tags:
  - godot
  - devlog
  - programming
  - shaders
  - pokémon
---
Hello again! Today I bring you a pretty technical and slightly nerdy topic, but one I've been wanting to investigate for a long time. If you've ever played Pokémon from Ruby, Sapphire, or Emerald onwards, you've definitely come across Spinda, the panda Pokémon with infinite patterns.

The truth is that this pocket monster is an absolute technical nightmare for any developer trying to make a fangame or clone. At the same time, I think it's a very interesting mechanic that enriches the world of these creatures. Today we're going to dissect how it works internally in the original games, how it has been solved in other tools, and finally, how I implemented it in Godosters.

![Spinda in the anime with various spot patterns](spinda_anime.png)

## What's so special about Spinda?

For those who don't know, Spinda is a Pokémon introduced in the third generation that has a unique mechanic: its spots are never the same.

Internally, the game uses the Personality Value (PID), a unique 32-bit number for each Pokémon, to determine the exact coordinates of 4 spots on its face. This means there are no less than 4,294,967,296 possible combinations.

![Examples of Spinda patterns with various PIDs](spinda_patterns.png)

But how is this drawn on screen without having 4 billion saved images? Let's take a look.

## The original solution: Pokémon Emerald (Game Boy Advance)

![Original Spinda from Pokémon Emerald](spinda_pokemon_emerald.png)

I dove into the decompiled `pokeemerald` code on GitHub to understand how they did it back in 2004 with the limited resources of the GBA.

Far from using polygons or weird rotations, the 4 spots are simply 16x16 pixel binary images (1 bit per pixel).

![Spot 1](spot_0.png) ![Spot 2](spot_1.png) ![Spot 3](spot_2.png) ![Spot 4](spot_3.png)

*(Above: The 4 original binary textures extracted from pokeemerald)*

The game takes the 32 bits of the PID and divides them into 4 blocks of 8 bits. For each spot, it uses the first 4 bits to calculate the X offset (between -8 and +7 pixels from its base) and the other 4 bits for the Y offset.

To put it all into perspective, here is the almost complete main function that does all the magic ([view on GitHub](https://github.com/pret/pokeemerald/blob/master/src/pokemon.c#L5749-L5787)) *(Note: I've adapted it from a C macro to a normal function to make it easier to read)*:

```c
void draw_spinda_spots(u32 personality, u8 *dest) 
{
    for (int i = 0; i < 4; i++) 
    {
        u8 x = gSpindaSpotGraphics[i].x + ((personality & 0x0F) - 8);
        u8 y = gSpindaSpotGraphics[i].y + (((personality & 0xF0) >> 4) - 8);

        for (int row = 0; row < SPINDA_SPOT_HEIGHT; row++)
        {
            s32 spotPixelRow = gSpindaSpotGraphics[i].image[row];
            for (int column = x; column < x + SPINDA_SPOT_WIDTH; column++)
            {
                u8 *destPixels = dest + /* ... 
                 ... */;
                if (spotPixelRow & (1 << (column - x)))
                {
                    try_draw_spot_pixel(destPixels, shift);
                }
            }
            y++;
        }
        personality >>= 8;
    }
}
```

Briefly explained, this is the step-by-step of what this block does:
1. **Loops through the 4 spots**.
2. **`gSpindaSpotGraphics`** is simply a predefined data array that stores the base starting coordinates of Spinda's face and the binary drawing of the 4 spot textures we saw earlier.
3. **Calculates the final `x` and `y` coordinates** by adding the random offset extracted from the `personality` (the PID) to that base coordinate.
4. With a few `for` loops going through each row and column of the 16x16 spot square, the C code works its magic with my beloved pointers to find which exact memory address in the console's RAM (`destPixels`) corresponds to that pixel of the base sprite.
5. It checks the binary mask of the spot texture (`if (spotPixelRow & ...)`), and if there's drawing on that pixel, it calls the final macro `TRY_DRAW_SPOT_PIXEL` to color it.
6. Finally, it pushes the PID number 8 bits to the right (`personality >>= 8`) to be able to read the pseudo-random positions of the next spot in the next loop iteration.

However, as you can imagine, the game doesn't just color that pixel wildly inside `TRY_DRAW_SPOT_PIXEL`; it first makes sure the destination belongs to Spinda's skin, to avoid staining the black outlines or the transparent background.

Here you have the empty base sprite to which these calculations are applied in memory:

![Base Spinda sprite in GBA (empty)](spinda_gba_front.png)

To paint the spot respecting the body boundaries, it uses the following macro in [`src/pokemon.c`](https://github.com/pret/pokeemerald/blob/master/src/pokemon.c#L5744-L5747). Here I explain line by line the magic behind the check:

```c
// Draw spot pixel if this is Spinda's body color
void try_draw_spot_pixel(u8 *pixels, int shift) 
{
    if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift))) 
     && ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift)))) 
    { 
        *(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift)); 
    }
}
```

* `if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift)))`: This line looks at the current color value of the pixel in RAM and checks if it's "greater than or equal to" the lightest color of the palette corresponding to Spinda's body (`FIRST_SPOT_COLOR`). The `shift` variable is used because pixels in GBA (which are 4 bits per pixel) are sometimes grouped in pairs within the same byte.
* `&& ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift))))`: And besides, it checks if it's "less than or equal to" the darkest color of Spinda's body (`LAST_SPOT_COLOR`). This guarantees 100% that the pixel we are going to paint belongs exclusively to Spinda's skin, and not its eyes or black outlines.
* `*(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift));`: If the above conditions are met, it enters the final instruction, where a mathematical adjustment (`SPOT_COLOR_ADJUSTMENT`) in the palette is magically added to the pixel's color, transforming it into the reddish color of the spot.

To make sure I had understood it correctly, I ran some tests. I decided to alter the original ROM, deleting exactly that same conditional check to force the game to draw the spots ignoring the body limits:

```diff
 // Draw spot pixel if this is Spinda's body color
 void try_draw_spot_pixel(u8 *pixels, int shift) 
 {
-    if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift))) 
-     && ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift)))) 
-    { 
         *(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift)); 
     }
 }
```

I recompiled the modified game, and as you can see in this final screenshot taken from my original console :), the spots now float freely over the background and are painted over the eyes or black borders because they are no longer restricted to drawing only over the main body color:

![Image of modified Spinda compiled from the pokeemerald ROM](pokeemerald.png)

## The solution in Pokémon Essentials (RPG Maker)

We jump to the world of classic fangames. In Pokémon Essentials (based on Ruby and RPG Maker), the solution is much rougher because the engine isn't built for this. Let's analyze the code contained in [001_FormHandlers.rb#L41-L140](https://github.com/Maruno17/pokemon-essentials/blob/master/Data/Scripts/014_Pokemon/001_Pokemon-related/001_FormHandlers.rb#L41-L140).

Instead of touching memory directly, they have two-dimensional arrays in code that draw the spots using the engine's `set_pixel` function, pixel by pixel, via software. They have to multiply it by 2 because of how RPG Maker XP works.

```rb
def drawSpot(bitmap, spotpattern, x, y, red, green, blue)
  height = spotpattern.length
  width  = spotpattern[0].length
  height.times do |yy|
    spot = spotpattern[yy]
    width.times do |xx|
      next if spot[xx] != 1
      xOrg = (x + xx) * 2
      yOrg = (y + yy) * 2
      color = bitmap.get_pixel(xOrg, yOrg)
      r = color.red + red
      g = color.green + green
      b = color.blue + blue
      color.red   = [[r, 0].max, 255].min
      color.green = [[g, 0].max, 255].min
      color.blue  = [[b, 0].max, 255].min
      bitmap.set_pixel(xOrg, yOrg, color)
      bitmap.set_pixel(xOrg + 1, yOrg, color)
      bitmap.set_pixel(xOrg, yOrg + 1, color)
      bitmap.set_pixel(xOrg + 1, yOrg + 1, color)
    end
  end
end

def pbSpindaSpots(pkmn, bitmap)
  # NOTE: These spots are doubled in size when drawing them.
  spot1 = [
    [0, 0, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 0, 0]
  ]
  spot2 = [
    [0, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 0, 0]
  ]
  spot3 = [
    [0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0]
  ]
  spot4 = [
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0]
  ]
  id = pkmn.personalID
  h = (id >> 28) & 15
  g = (id >> 24) & 15
  f = (id >> 20) & 15
  e = (id >> 16) & 15
  d = (id >> 12) & 15
  c = (id >> 8) & 15
  b = (id >> 4) & 15
  a = (id) & 15
  # NOTE: The coordinates below (b + 33, a + 25 and so on) are doubled when
  #       drawing the spot.
  if pkmn.shiny?
    drawSpot(bitmap, spot1, b + 33, a + 25, -75, -10, -150)
    drawSpot(bitmap, spot2, d + 21, c + 24, -75, -10, -150)
    drawSpot(bitmap, spot3, f + 39, e + 7, -75, -10, -150)
    drawSpot(bitmap, spot4, h + 15, g + 6, -75, -10, -150)
  else
    drawSpot(bitmap, spot1, b + 33, a + 25, 0, -115, -75)
    drawSpot(bitmap, spot2, d + 21, c + 24, 0, -115, -75)
    drawSpot(bitmap, spot3, f + 39, e + 7, 0, -115, -75)
    drawSpot(bitmap, spot4, h + 15, g + 6, 0, -115, -75)
  end
end
```

![Base Spinda sprite in Pokémon Essentials (empty)](spinda_essentials_front.png)
![Image of Spinda in Pokémon Essentials](spinda_essentials.png)

It works well for static images, but it's terribly inefficient. The big problem arrives when you try to animate the sprite. If Spinda moves its head, the spots remain floating in place because they are painted over static coordinates.

## Deluxe Battle Kit to the rescue (Essentials)

To solve this animation problem within the Essentials engine itself, the Deluxe Battle Kit plugin uses a rather ingenious approach, although not very optimal.

The code scans the sprite at runtime frame by frame, looking for the exact color of Spinda's mouth `(230, 99, 115)`. It measures how many pixels the mouth has moved horizontally and vertically since the previous frame and applies that difference to the spots' coordinates. Very smart to anchor the spots to the face, but constantly doing pixel scanning on the CPU isn't the best for performance. To avoid making this post too long and complex, I'm going to omit the code for this section, it's a bit messy.

![Spinda sprites in Deluxe Battle Kit](spinda_deluxe_battle_kit.png)

![Animated Spinda with the Deluxe Battle Kit](https://i.imgur.com/4rX0dud.gif)

## YAPU (Unity)

[YAPU (Yet Another Pokémon Unity)](https://github.com/varguiniano/YAPU) introduces a giant paradigm shift, as it works in Unity and uses shaders on the GPU. Furthermore, the animations here are 52-frame sequences where the head rotates and changes perspective, so a static displacement would quickly look completely wrong.

To solve this, YAPU's developer created an external C# tool that pre-calculates a huge data texture (Data Texture or LUT). This image isn't meant to be seen; rather, it stores mathematical data in its colors. Curiously enough, this is the same technique I use in [Elit3D](/projects/elit3d/) to send tile data for each layer within an image so the GPU can process it rapidly.

In YAPU's case, the image is 52x4 pixels (52 frames and 4 spots). In the red and green channels of each pixel, it stores the exact base coordinate where each spot should be anchored in that specific frame. Then, Unity's Shader Graph simply reads those colors, adds the PID's random offset, and draws the spot. Super fast to run, but very complex and rigid to maintain if you decide to change an animation frame.

![Spinda LUT in YAPU](spinda_yapu_lut.png)
> Getting YAPU up and running is somewhat complex because it requires non-public assets and several paid plugins that I don't own. I've done all the analysis without being able to verify it, and I generated the LUT with a script that mimics it but isn't quite the same.
## How I did it in Godosters (Godot 4)

After analyzing all this, I had to figure out how to do it in my project. I wanted an intermediate path: run away from the Battle Kit's CPU scanning and avoid the complexity of YAPU's external data tool.

Luckily, Godot 4 is incredible with shaders. They are very similar to glsl, easy to make, I like them a lot. My current solution is a hybrid approach:

1. I use the Essentials arrays in GDScript code, but instead of drawing on screen with `set_pixel`, I convert them once into an `ImageTexture` in memory (creating a mask that I pass to the GPU).
2. The GDScript script calculates the PID math (the offsets) and passes them as parameters (`uniforms`) to the shader.
3. The Fragment Shader handles everything else. It checks if the current pixel falls within the spot's mask and applies the mathematical color tinting. 

Let's go step by step. First the script:

To implement this in my project, I opted for a hybrid system that takes the best of both worlds: the ease of use of the Essentials arrays and the extremely high performance of shaders.

I created a `SpindaAppearanceModifier` class that inherits from our base visual modifiers system. This class has a main function, `apply()`, which receives the Pokémon instance and the sprite to be rendered.

The strategy is as follows:
1. **Define the patterns**: I reuse the same binary arrays from Essentials to shape the spots.
2. **Create efficient masks**: Instead of drawing the spot pixel by pixel on the CPU, I convert those arrays into a texture (`ImageTexture`) using a `PackedByteArray`. This is a highly optimized technique in Godot that allows building the image all at once, avoiding slow iterations.
3. **Accurate colors**: I extracted the exact colors from the original sprite (both for light and shadow). The script assigns normal colors by default and replaces them only if the Pokémon is shiny, keeping the code very clean.
4. **Calculate coordinates**: Using the PID, we read 4-bit groups to extract the offset of each spot (between 0 and 15 pixels), mimicking the GBA math exactly.
5. **Send to Shader**: Lastly, we create a unique instance of the material (to prevent different Spindas from sharing the same positions) and pass all these variables to the shader.

```gd
class_name SpindaAppearanceModifier

extends AppearanceModifier

const SPOT1: Array = [ # Bottom-Right
	[0, 0, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 0, 0],
]
const SPOT2: Array = [ # Bottom-Left
	[0, 0, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 0, 0],
]
const SPOT3: Array = [ # Top-Right
	[0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
	[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
]
const SPOT4: Array = [ # Top-Left
	[0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
]

static var _masks: Array[ImageTexture]

@export var shader: Shader = preload("uid://ck1uhn0oiwgaa")

@export var spot1_base := Vector2(38, 34)
@export var spot2_base := Vector2(26, 33)
@export var spot3_base := Vector2(45, 14)
@export var spot4_base := Vector2(21, 14)

@export var debug_mode: bool = false
@export_group("Colors")
@export var spot_color_normal := Color(238.0 / 255.0, 82.0 / 255.0, 74.0 / 255.0)
@export var spot_shade_color_normal := Color(189.0 / 255.0, 74.0 / 255.0, 49.0 / 255.0)
@export var body_color_normal := Color(230.0 / 255.0, 213.0 / 255.0, 164.0 / 255.0)
@export var body_shade_color_normal := Color(205.0 / 255.0, 164.0 / 255.0, 115.0 / 255.0)

@export var spot_color_shiny := Color(164.0 / 255.0, 205.0 / 255.0, 16.0 / 255.0)
@export var spot_shade_color_shiny := Color(130.0 / 255.0, 170.0 / 255.0, 10.0 / 255.0)
@export var body_color_shiny := Color(184.0 / 255.0, 216.0 / 255.0, 168.0 / 255.0)
@export var body_shade_color_shiny := Color(128.0 / 255.0, 184.0 / 255.0, 112.0 / 255.0)


func apply(monster: Monster, sprite: CanvasItem, context: AppearanceModifier.SpriteContext) -> void:
	# Spots only make sense on the front-facing art.
	if context != AppearanceModifier.SpriteContext.FRONT:
		return

	var id := monster.pid._get_id()
	var x4 := (id) & 15
	var y4 := (id >> 4) & 15
	var x3 := (id >> 8) & 15
	var y3 := (id >> 12) & 15
	var x2 := (id >> 16) & 15
	var y2 := (id >> 20) & 15
	var x1 := (id >> 24) & 15
	var y1 := (id >> 28) & 15

	var masks := _get_masks()
	var mat := ShaderMaterial.new()
	mat.shader = shader

	mat.set_shader_parameter("spot1_tex", masks[0])
	mat.set_shader_parameter("spot2_tex", masks[1])
	mat.set_shader_parameter("spot3_tex", masks[2])
	mat.set_shader_parameter("spot4_tex", masks[3])

	mat.set_shader_parameter("spot1_offset", (spot1_base + Vector2(x1, y1)))
	mat.set_shader_parameter("spot2_offset", (spot2_base + Vector2(x2, y2)))
	mat.set_shader_parameter("spot3_offset", (spot3_base + Vector2(x3, y3)))
	mat.set_shader_parameter("spot4_offset", (spot4_base + Vector2(x4, y4)))

	var spot_color := spot_color_normal
	var spot_shade_color := spot_shade_color_normal
	var body_color := body_color_normal
	var body_shade_color := body_shade_color_normal
	
	if monster.is_shiny:
		spot_color = spot_color_shiny
		spot_shade_color = spot_shade_color_shiny
		body_color = body_color_shiny
		body_shade_color = body_shade_color_shiny
	
	var delta := Vector3(
		spot_color.r - body_color.r,
		spot_color.g - body_color.g,
		spot_color.b - body_color.b
	)
	var shade_delta := Vector3(
		spot_shade_color.r - body_shade_color.r,
		spot_shade_color.g - body_shade_color.g,
		spot_shade_color.b - body_shade_color.b
	)
		
	mat.set_shader_parameter("color_delta", delta)
	mat.set_shader_parameter("shade_delta", shade_delta)
	mat.set_shader_parameter("body_color", Vector3(body_color.r, body_color.g, body_color.b))
	mat.set_shader_parameter("body_shade_color", Vector3(body_shade_color.r, body_shade_color.g, body_shade_color.b))
	mat.set_shader_parameter("debug_mode", debug_mode)

	sprite.material = mat


static func _get_masks() -> Array[ImageTexture]:
	if _masks.is_empty():
		_masks.resize(4)
		_masks[0] = _make_mask(SPOT1)
		_masks[1] = _make_mask(SPOT2)
		_masks[2] = _make_mask(SPOT3)
		_masks[3] = _make_mask(SPOT4)
	return _masks


static func _make_mask(pattern: Array) -> ImageTexture:
	var height := pattern.size()
	var width: int = pattern[0].size()
	
	var data := PackedByteArray()
	data.resize(width * height)
	
	var i := 0
	for y in height:
		for x in width:
			data[i] = pattern[y][x] * 255
			i += 1
			
	var img := Image.create_from_data(width, height, false, Image.FORMAT_L8, data)
	return ImageTexture.create_from_image(img)
```

Now onto the shader. The shader receives all the data and only modifies the `fragment`. First it reads the pixel color from Spinda's texture and checks that it isn't transparent. If it's not, it evaluates each of the four spots. For each spot, it checks that the coordinate falls within its corresponding area and, immediately after, it reads the exact value from that mask to know if it's supposed to draw there.

If it's a spot, the shader doesn't just paint it brutally. First it compares the original pixel color with Spinda's cream skin tones. Using a smart mathematical blend, it decides what to do: if the pixel is skin, it tints it 100% red, perfectly respecting whether it was lit or in shadow. But if the pixel is part of a facial feature, like the dark lines of the eyes or the mouth, it leaves it intact. This way we ensure the spots integrate with perfect anti-aliasing over the body without erasing the Pokémon's face.
```glsl
shader_type canvas_item;

uniform sampler2D spot1_tex : filter_nearest, repeat_disable;
uniform sampler2D spot2_tex : filter_nearest, repeat_disable;
uniform sampler2D spot3_tex : filter_nearest, repeat_disable;
uniform sampler2D spot4_tex : filter_nearest, repeat_disable;

uniform vec2 spot1_offset = vec2(0.0);
uniform vec2 spot2_offset = vec2(0.0);
uniform vec2 spot3_offset = vec2(0.0);
uniform vec2 spot4_offset = vec2(0.0);

uniform vec3 color_delta = vec3(0.0);
uniform vec3 shade_delta = vec3(0.0);
uniform vec3 body_color = vec3(0.878, 0.815, 0.627);
uniform vec3 body_shade_color = vec3(0.784, 0.690, 0.501);
uniform float color_tolerance = 0.2;
uniform bool debug_mode = false;


vec3 apply_spot(vec3 col, sampler2D mask, vec2 px, vec2 offset) {
	vec2 rel = px - offset;
	if (rel.x < 0.0 || rel.y < 0.0) {
		return col;
	}
	ivec2 idx = ivec2(rel);
	ivec2 size = textureSize(mask, 0);
	if (idx.x >= size.x || idx.y >= size.y) {
		return col;
	}
	if (texelFetch(mask, idx, 0).r > 0.5) {
		if (debug_mode) {
			col = clamp(col + color_delta, vec3(0.0), vec3(1.0));
		} else {
			float dist_base = distance(col, body_color);
			float dist_shade = distance(col, body_shade_color);
			
			float blend_base = 1.0 - smoothstep(color_tolerance * 0.5, color_tolerance, dist_base);
			float blend_shade = 1.0 - smoothstep(color_tolerance * 0.5, color_tolerance, dist_shade);
			
			if (blend_base > 0.0 || blend_shade > 0.0) {
				if (blend_base > blend_shade) {
					col = mix(col, clamp(col + color_delta, vec3(0.0), vec3(1.0)), blend_base);
				} else {
					col = mix(col, clamp(col + shade_delta, vec3(0.0), vec3(1.0)), blend_shade);
				}
			}
		}
	}
	return col;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a != 0.0 || debug_mode) {	
		if (debug_mode && COLOR.a == 0.0) {
			COLOR = vec4(0.2, 0.2, 0.2, 0.3);
		}
		vec2 px = floor(UV / TEXTURE_PIXEL_SIZE);
		COLOR.rgb = apply_spot(COLOR.rgb, spot1_tex, px, spot1_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot2_tex, px, spot2_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot3_tex, px, spot3_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot4_tex, px, spot4_offset);
	}
}

```

It's super fast because the heavy lifting is executed in parallel on the graphics card and it solves the root problem of static painting.
![Image of the empty Godosters base sprite (PokeAPI)](spinda_godosters.png)

I created a scene in Godot where I could visualize each of the monsters in the database. I made a special case where if the Pokémon had the `AppearanceModifiers` array, it would add some controls to edit the origin of the spots. This way I could see the exact position of the spots to check the changes I was making.
![Screenshot of a Godosters scene to visualize all monsters](spinda_godosters_editor.png)

### The future: Native Animations in Godot

Truth be told, I'm quite happy with the current solution, but it still inherits one problem: if I add an animated sprite, the spots will stay fixed just like they did in Essentials.

I'm no expert, but thinking about it, I believe the best possible solution is to take advantage of Godot's own architecture and the `AnimationPlayer` node. My idea for the future is to divide the offset into two parts within the shader:
* `spot1_base`: The original position of the spot on Spinda's body.
* `spot1_pid_offset`: The random displacement generated by the PID.

The script will only calculate the `pid_offset` once when instantiating the Pokémon. For the animation, I'll simply use Godot's `AnimationPlayer` to create a track that moves the `spot1_base` value frame by frame directly from the editor's timeline. Thus, the spots will move with the head natively, all on the GPU and without weird external tools.

I could even write a script that scans the mouth colors (like the Deluxe Battle Kit does) inside the editor, and automatically generates the `AnimationPlayer` keyframes for me so I don't have to do it by hand, frame by frame. The best of both worlds with perfect performance in the final game.

Another technically flawless option would be to ditch spritesheets altogether and animate by parts using 2D skeletons (like they did in Gen 5). This way, Spinda's head would be an independent Godot node and the shader would apply only to that piece. As you animate and rotate the head, the spots would rotate perfectly anchored to it natively. But honestly, animating, slicing, and rigging almost a thousand critters by hand is absolute madness. So I'll stick with frame-by-frame animation; even if it requires programming workarounds, it's infinitely faster on a production level since the assets are already all set on the internet.

### What about current 3D games?

Although 3D is totally *out of scope* for Godosters (not for the maps, that's why Elit3D was born), it's curious to think about how Game Freak solved this very problem starting with Pokémon X & Y. With 3D models, the problem simply vanishes: Spinda has a 3D mesh attached to a skeleton. The spots are calculated by passing the PID to the material's shader, which draws the spots directly on the head's UVs. When the 3D skeleton moves in any animation, the texture and UVs move with the model 100% natively.

![Gif of Spinda in a 3D Pokémon game](spinda_3d_game.gif)

### The curious case of Pokémon Brilliant Diamond and Shining Pearl (ILCA)

To wrap up, it's worth mentioning the disaster that happened with Spinda in the Diamond and Pearl remakes developed by ILCA. 

When replicating this mechanic in Unity, the studio made an *Endianness* (byte order) error when reading the PID. Since the rest of the series uses *Little Endian* and they assumed *Big Endian*, they ended up reading the 32 bits literally backwards. For example, a hexadecimal PID value like `12 34 56 78` was read as `78 56 34 12`.

The visual result was catastrophic: the spot pattern generated in BDSP was completely different from what that same number would produce in any other game. This caused a critical clash with *Pokémon HOME* (curiously also developed by ILCA), which did read the PID correctly. If you transferred a Spinda from one game to another, its spots would magically rearrange themselves.

Since fixing the bug after the fact would have altered the Spindas players already had in their save files, the solution was drastic: **they completely banned transferring Spinda**. Today, any Spinda caught in BDSP is trapped in that game forever just because 4 bytes were read in the wrong order.

In the following image (courtesy of @Atrius97) you can see the demonstration: they generated two Spindas with their PID bytes intentionally swapped to see how the versions generated in Pokémon Emerald (correct) clash with BDSP (read error).

![Comparison of the Spinda read error in BDSP](spinda-bdsp.png)

---

By the way, if your curiosity is piqued and you want to play around with Spinda's spots without having to touch code, I highly recommend taking a look at [Spinda Painter](https://wokann.github.io/Tool/Spinda_Painter/Spinda%20Painter%201.3.2.htm). It's an awesome web tool that lets you paint and visualize the pattern of any Spinda knowing its PID and vice versa. It was really helpful throughout this whole investigation to check things on the fly.

![Split screen with Spinda Painter to verify spots were painted the same with the same PID](spinda_godosters_editor_0.png)
![Split screen with Spinda Painter to verify spots were painted the same with the same PID with debug mode on](spinda_godosters_editor_1.png)

And that's all for today. It's been a slightly denser post than usual, but I really wanted to document all this research because I find it fascinating how the community has solved this design problem over the years.

Changing the subject a bit, the truth is I've been working quite a lot on Godosters lately and I've made a ton of progress. That being said, the project is still very unstable under the hood and I want to make sure it's solid before publishing and officially showing it. I'll soon show you in detail the new systems I've integrated and what the current landscape of everything looks like.

I hope you found it useful. Dropping a like, an emoji, or a comment down below is greatly appreciated.

See you next time!