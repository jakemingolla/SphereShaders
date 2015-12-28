varying vec3 vertexNormal;
varying vec4 vertexColor;

void main(void)
{
    vertexNormal = gl_Normal;
    vertexColor = gl_Color;
    gl_Position = gl_Vertex;
}
