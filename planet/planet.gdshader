shader_type spatial;
uniform vec2 u_lod_fade;
uniform mat4 u_block_local_transform;
// This is recognized and assigned automatically by the voxel node
uniform vec4 A: source_color = vec4(0.1, 0.7, 0.1, 0.0);
uniform vec4 B: source_color = vec4(0.3, 0.3, 0.9, 0.0);

varying vec4 pos;

varying float index;
varying float tint;

vec4 decode_8bit_vec4(float v) {
    uint i = floatBitsToUint(v);
    return vec4(
        float(i & uint(0xff)),
        float((i >> uint(8)) & uint(0xff)),
        float((i >> uint(16)) & uint(0xff)),
        float((i >> uint(24)) & uint(0xff)));
}

float get_hash(vec2 c) {
    return fract(sin(dot(c.xy, vec2(12.9898,78.233))) * 43758.5453);
}

void vertex() {
	pos = u_block_local_transform*vec4(VERTEX, 1.0);
	index = decode_8bit_vec4(CUSTOM1.y).r;
}

void fragment() {
	NORMAL = normalize(cross(dFdy(VERTEX), dFdx(VERTEX)));
	float alt = length(pos);
	
	ALBEDO = index > 0.01 ? A.rgb : B.rgb;
	SPECULAR = index > 0.01 ? 0.0 : 0.7;
	ROUGHNESS = index > 0.01 ? 0.0 : 0.7;
	float h = get_hash(SCREEN_UV);
	if (u_lod_fade.y > 0.5) {
	    // Fade in
	    if (u_lod_fade.x < h) {
	        discard;
	    }
	} else {
    	// Fade out
	    if (u_lod_fade.x > h) {
	        discard;
	    }
	}
}
