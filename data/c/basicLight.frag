varying vec4 fragmentColor;
varying vec3 eyePosition;
varying vec3 eyeNormal;

void main(void)
{
    vec3 L = normalize(gl_LightSource[0].position.xyz - eyePosition);   
	float Idiff =  max(dot(eyeNormal,L), 0.0);     
	gl_FragColor = vec4( fragmentColor.rgb * Idiff, fragmentColor.a);
}

