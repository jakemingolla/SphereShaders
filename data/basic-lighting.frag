varying vec3 eyePosition;
varying vec3 eyeNormal;
varying vec4 fragmentColor;

void main(void) {
        vec3 l = normalize(gl_LightSource[0].position.xyz - eyePosition);

        float eyeDiff = max(dot(eyeNormal, l), 0.0);

        gl_FragColor = vec4(fragmentColor.rgb * eyeDiff, fragmentColor.a);
}
