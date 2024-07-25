import json
import os
import sys

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i + 2], 16) for i in range(0, 6, 2))

def update_colorset(colorset_path, name, hex_color_any, hex_color_dark):
    rgb_any = hex_to_rgb(hex_color_any)
    rgb_dark = hex_to_rgb(hex_color_dark)
    new_data = {
        "colors": [
            {
                "idiom": "universal",
                "appearances": [{"appearance": "luminosity", "value": "light"}],
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "red": f"{rgb_any[0]/255.0:.3f}",
                        "green": f"{rgb_any[1]/255.0:.3f}",
                        "blue": f"{rgb_any[2]/255.0:.3f}",
                        "alpha": "1.000"
                    }
                }
            },
            {
                "idiom": "universal",
                "appearances": [{"appearance": "luminosity", "value": "dark"}],
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "red": f"{rgb_dark[0]/255.0:.3f}",
                        "green": f"{rgb_dark[1]/255.0:.3f}",
                        "blue": f"{rgb_dark[2]/255.0:.3f}",
                        "alpha": "1.000"
                    }
                }
            }
        ]
    }

    colorset_folder = os.path.join('Colors.xcassets', f'{name}.colorset')
    colorset_file = os.path.join(colorset_folder, 'Contents.json')
    
    if os.path.exists(colorset_file):
        with open(colorset_file, 'r') as file:
            existing_data = json.load(file)
        if existing_data == new_data:
            return  # Если данные не изменились, не перезаписываем файл.

    os.makedirs(colorset_folder, exist_ok=True)
    with open(colorset_file, 'w') as file:
        json.dump(new_data, file, indent=4)
    print(f"Updated color set for {name}")

def main():
    with open('colors_data.txt', 'r') as file:
        for line in file:
            name, hex_color_any, hex_color_dark = line.strip().split(',')
            update_colorset('Colors.xcassets', name, hex_color_any, hex_color_dark)

if __name__ == '__main__':
    main()
