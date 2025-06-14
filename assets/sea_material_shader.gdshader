shader_type spatial;

uniform sampler2D noise;
uniform sampler2D noise2;
/*
*/

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//ALBEDO = vec3(0.5,0.5,0.5);
	ALBEDO = vec3(0.4);
	NORMAL_MAP =  mix(
		texture(noise, vec2(UV*8.0+TIME/100.0)).rgb,
		texture(noise2, vec2(UV*8.0-TIME/300.0)).rgb, 0.5
		);

	METALLIC = 1.0;
	ROUGHNESS = 0.0;
	//NORMAL_MAP = (texture(noise, vec2(UV+TIME/1000.0)).rgb + texture(noise2, vec2(UV-TIME/2000.0)).rgb)*0.5;
	NORMAL_MAP_DEPTH = 2.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
