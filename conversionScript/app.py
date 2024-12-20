from PIL import Image
import numpy as np

vga_palette = [(0, 0, 0), (0, 0, 170), (0, 170, 0), (0, 170, 170), (170, 0, 0), (170, 0, 170), (170, 85, 0), (170, 170, 170), (85, 85, 85), (85, 85, 255), (85, 255, 85), (85, 255, 255), (255, 85, 85), (255, 85, 255), (255, 255, 85), (255, 255, 255), (0, 0, 0), (16, 16, 16), (32, 32, 32), (53, 53, 53), (69, 69, 69), (85, 85, 85), (101, 101, 101), (117, 117, 117), (138, 138, 138), (154, 154, 154), (170, 170, 170), (186, 186, 186), (202, 202, 202), (223, 223, 223), (239, 239, 239), (255, 255, 255), (0, 0, 255), (65, 0, 255), (130, 0, 255), (190, 0, 255), (255, 0, 255), (255, 0, 190), (255, 0, 130), (255, 0, 65), (255, 0, 0), (255, 65, 0), (255, 130, 0), (255, 190, 0), (255, 255, 0), (190, 255, 0), (130, 255, 0), (65, 255, 0), (0, 255, 0), (0, 255, 65), (0, 255, 130), (0, 255, 190), (0, 255, 255), (0, 190, 255), (0, 130, 255), (0, 65, 255), (130, 130, 255), (158, 130, 255), (190, 130, 255), (223, 130, 255), (255, 130, 255), (255, 130, 223), (255, 130, 190), (255, 130, 158), (255, 130, 130), (255, 158, 130), (255, 190, 130), (255, 223, 130), (255, 255, 130), (223, 255, 130), (190, 255, 130), (158, 255, 130), (130, 255, 130), (130, 255, 158), (130, 255, 190), (130, 255, 223), (130, 255, 255), (130, 223, 255), (130, 190, 255), (130, 158, 255), (186, 186, 255), (202, 186, 255), (223, 186, 255), (239, 186, 255), (255, 186, 255), (255, 186, 239), (255, 186, 223), (255, 186, 202), (255, 186, 186), (255, 202, 186), (255, 223, 186), (255, 239, 186), (255, 255, 186), (239, 255, 186), (223, 255, 186), (202, 255, 186), (186, 255, 186), (186, 255, 202), (186, 255, 223), (186, 255, 239), (186, 255, 255), (186, 239, 255), (186, 223, 255), (186, 202, 255), (0, 0, 113), (28, 0, 113), (57, 0, 113), (85, 0, 113), (113, 0, 113), (113, 0, 85), (113, 0, 57), (113, 0, 28), (113, 0, 0), (113, 28, 0), (113, 57, 0), (113, 85, 0), (113, 113, 0), (85, 113, 0), (57, 113, 0), (28, 113, 0), (0, 113, 0), (0, 113, 28), (0, 113, 57), (0, 113, 85), (0, 113, 113), (0, 85, 113), (0, 57, 113), (0, 28, 113), (57, 57, 113), (69, 57, 113), (85, 57, 113), (97, 57, 113), (113, 57, 113), (113, 57, 97), (113, 57, 85), (113, 57, 69), (113, 57, 57), (113, 69, 57), (113, 85, 57), (113, 97, 57), (113, 113, 57), (97, 113, 57), (85, 113, 57), (69, 113, 57), (57, 113, 57), (57, 113, 69), (57, 113, 85), (57, 113, 97), (57, 113, 113), (57, 97, 113), (57, 85, 113), (57, 69, 113), (81, 81, 113), (89, 81, 113), (97, 81, 113), (105, 81, 113), (113, 81, 113), (113, 81, 105), (113, 81, 97), (113, 81, 89), (113, 81, 81), (113, 89, 81), (113, 97, 81), (113, 105, 81), (113, 113, 81), (105, 113, 81), (97, 113, 81), (89, 113, 81), (81, 113, 81), (81, 113, 89), (81, 113, 97), (81, 113, 105), (81, 113, 113), (81, 105, 113), (81, 97, 113), (81, 89, 113), (0, 0, 65), (16, 0, 65), (32, 0, 65), (49, 0, 65), (65, 0, 65), (65, 0, 49), (65, 0, 32), (65, 0, 16), (65, 0, 0), (65, 16, 0), (65, 32, 0), (65, 49, 0), (65, 65, 0), (49, 65, 0), (32, 65, 0), (16, 65, 0), (0, 65, 0), (0, 65, 16), (0, 65, 32), (0, 65, 49), (0, 65, 65), (0, 49, 65), (0, 32, 65), (0, 16, 65), (32, 32, 65), (40, 32, 65), (49, 32, 65), (57, 32, 65), (65, 32, 65), (65, 32, 57), (65, 32, 49), (65, 32, 40), (65, 32, 32), (65, 40, 32), (65, 49, 32), (65, 57, 32), (65, 65, 32), (57, 65, 32), (49, 65, 32), (40, 65, 32), (32, 65, 32), (32, 65, 40), (32, 65, 49), (32, 65, 57), (32, 65, 65), (32, 57, 65), (32, 49, 65), (32, 40, 65), (45, 45, 65), (49, 45, 65), (53, 45, 65), (61, 45, 65), (65, 45, 65), (65, 45, 61), (65, 45, 53), (65, 45, 49), (65, 45, 45), (65, 49, 45), (65, 53, 45), (65, 61, 45), (65, 65, 45), (61, 65, 45), (53, 65, 45), (49, 65, 45), (45, 65, 45), (45, 65, 49), (45, 65, 53), (45, 65, 61), (45, 65, 65), (45, 61, 65), (45, 53, 65), (45, 49, 65), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)]

def closest_color(rgb, palette):
    r, g, b = rgb
    min_dist = float("inf")
    closest = None
    for i, (pr, pg, pb) in enumerate(palette):
        dist = (r - pr) ** 2 + (g - pg) ** 2 + (b - pb) ** 2
        if dist < min_dist:
            min_dist = dist
            closest = i
    return closest

image_path = "car.png"
image = Image.open(image_path)

image = image.convert("RGB")

indexed_data = np.array(image)
indexed_palette = []

for i in range(indexed_data.shape[0]):
    for j in range(indexed_data.shape[1]):
        rgb = tuple(indexed_data[i, j])
        index = closest_color(rgb, vga_palette)
        indexed_palette.append(index)

array_name = "carData"
line_length = 20
lines = []
for i in range(0, len(indexed_palette), line_length):
    line = indexed_palette[i:i+line_length]
    lines.append("db " + ", ".join(map(str, line)))

tasm_array = f"{array_name} " + "\n".join(lines)

output_path = "car.asm"
with open(output_path, "w") as file:
    file.write(tasm_array)

print(f"Assembly array saved to {output_path}")
