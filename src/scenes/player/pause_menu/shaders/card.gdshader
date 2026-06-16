shader_type canvas_item;

uniform sampler2D gradient: hint_default_black;

float rect(vec2 uv, vec2 size) {
	float x = 1.0 - step((size.x * 5.0) / 10.0, distance(uv.x, 0.5));
	float y = 1.0 - step((size.y * 5.0) / 10.0, distance(uv.y, 0.5));
	return x * y;
}

float square(vec2 uv, float width) {
	vec2 mappedUV = abs(uv * 2.0 - 1.0);
	
	return step(width, max(mappedUV.x, mappedUV.y));
}

float square_stroke(vec2 uv, float width, float thickness) {
	vec2 mappedUV = abs(uv * 2.0 - 1.0);
	float dist = max(mappedUV.x, mappedUV.y);
	return (step(width, dist) - step(width + thickness, dist));
}

void fragment() {
	float color = square_stroke(UV, 0.95, 0.02);
	color = color - rect(UV, vec2(1.0, 0.9));
	color = color - rect(UV, vec2(0.9, 1.0));
	
	COLOR = texture(gradient, vec2(color));
}