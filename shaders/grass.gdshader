shader_type spatial;
#include "res://$lib/funcs/transform.gdshaderinc"
uniform sampler2D _grass_albedo:source_color; 
uniform sampler2D _grass_normal:source_color; 
uniform sampler2D _dirt_albedo:source_color; 
uniform sampler2D _dirt_normal:source_color; 
uniform sampler2D _noise_grass; 
uniform sampler2D _noise_grass_dirt; 
uniform float normal_scale: hint_range(-16.0,16.0) = 1.0; 
void fragment() {
	// grass
	vec2 uv_resize = UV * 5.0; 
	vec2 uv_rotation = rotation(uv_resize,vec2(0.5),90.0); 
	vec3 grass1 = texture(_grass_albedo,uv_resize).rgb;
	vec3 grass2 = texture(_grass_albedo,uv_rotation).rgb; 
	vec3 grass_normal = texture(_grass_normal,uv_resize).rgb; 
	vec3 grass_normal2 = texture(_grass_normal,uv_rotation).rgb; 
	float noise_grass = texture(_noise_grass,UV).r;	
	//dirt mix
	vec3 mix_grass = mix(grass1,grass2,noise_grass); ; 
	vec3 mix_normal_grass = mix(grass_normal,grass_normal2,noise_grass); 
	vec3 dirt = texture(_dirt_albedo,uv_resize).rgb; 
	vec3 dirt_normal = texture(_dirt_normal,uv_resize).rgb;
	float noise_grass_dirt = texture(_noise_grass_dirt,UV).r;	
	vec3 out_albedo = mix(mix_grass,dirt,noise_grass_dirt);
	vec3 out_normal = mix(mix_normal_grass,dirt_normal,noise_grass_dirt);  
		 
	
	ALBEDO = out_albedo; 
	NORMAL_MAP = out_normal; 
	NORMAL_MAP_DEPTH = normal_scale; 
	ROUGHNESS = 0.9; 
//ALBEDO = out_normal; 
}
