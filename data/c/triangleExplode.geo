#version 120
#extension GL_EXT_geometry_shader4: enable

uniform float Time;

varying in vec3 vertexNormal[3];
varying in vec4 vertexColor[3];

varying out vec3 eyePosition;
varying out vec3 eyeNormal;
varying out vec4 fragmentColor;

vec4 vertices[3];

void createVertex( int i ){
	vec3 faceNormal = normalize(cross(vertices[2].xyz - vertices[0].xyz,
                                          vertices[1].xyz - vertices[0].xyz));			

	vec4 newestPosition = vertices[i] + vec4(Time * faceNormal,0.);

	eyeNormal = gl_NormalMatrix * faceNormal;
	eyePosition = (gl_ModelViewMatrix * newestPosition ).xyz;
        fragmentColor = vertexColor[i];  

        gl_Position = gl_ModelViewProjectionMatrix *newestPosition ;
        EmitVertex();
}

void main()
{
	vertices[0] = gl_PositionIn[0];
	vertices[1] = gl_PositionIn[1];
	vertices[2] = gl_PositionIn[2];

	createVertex(0);
	createVertex(1);
	createVertex(2);

	EndPrimitive();
}

