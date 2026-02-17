uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;

void main() {
	vec4 c = texture2D(tex, gl_TexCoord[0]);
	{
		// Change vec4(1.0, 1.0, 1.0, 1.0) to your desired color
		vec4 vdiff = abs(vec4(1.0, 1.0, 1.0, 1.0) - c);
		float diff = max(max(max(vdiff.r, vdiff.g), vdiff.b), vdiff.a);
		// Change 0.8 to your desired opacity
		if (diff < 0.001)
			c *= 0.8;
	}
	if (invert_color)
		c = vec4(vec3(c.a, c.a, c.a) - vec3(c), c.a);
	vec3 rgb = c.a > 0.0 ? c.rgb / c.a : c.rgb;
	ivec3 pixel_rgb8 = ivec3(round(clamp(rgb, 0.0, 1.0) * 255.0));
	float color_opacity = all(equal(pixel_rgb8, ivec3(255))) ? opacity : 1.0;
	c *= color_opacity;
	gl_FragColor = c;
}
