shader_type canvas_item;

uniform float tileSize = 64;
uniform float dot_size = 0.1;
uniform vec2 offset;
uniform sampler2D gradient: hint_default_black;

float square(vec2 uv, float width) {
	vec2 mappedUV = abs(uv * 2.0 - 1.0);
	
	return step(width, max(mappedUV.x, mappedUV.y));
}

float circle(vec2 uv, float radius, float feather) {
	return smoothstep(radius, radius + feather, length(uv - vec2(0.5)));
}

void fragment() {
	vec2 tiledUV = fract(SCREEN_UV.xy * vec2(1, SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y) * vec2(tileSize));
	//vec2 tiledUV = fract(UV.xy * vec2(1.77, 1) * vec2(tileSize));
	
	//float color = smoothstep(0, 0.3, distance(mappedUV, vec2(0.5)));
	//float color = circle(tiledUV, 0.4, 0.04);
	float color = square(tiledUV - vec2(0.1), dot_size);
	
	//float sphere = distance(UV, vec2(0.0));
	
	//COLOR = vec4(color);
	COLOR = texture(gradient, vec2(color));
	//COLOR = vec4(SCREEN_UV.x);
}