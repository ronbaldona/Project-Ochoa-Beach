#version 330 core
// NOTE: Do NOT use any version older than 330! Bad things will happen!

// This is an example vertex shader. GLSL is very similar to C.
// You can define extra functions if needed, and the main() function is
// called when the vertex shader gets run.
// The vertex shader gets called once per vertex.

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;

// Uniform variables can be updated by fetching their location and passing values to that location
uniform mat4 projection;
uniform mat4 model;
uniform mat4 view;
uniform int mode;
uniform mat4 modelview;
uniform vec3 camPos;
uniform vec4 plane;

// Outputs of the vertex shader are the inputs of the same name of the fragment shader.
// The default output, gl_Position, should be assigned something. You can define as many
// extra outputs as you need.
out vec3 FragPos;
out vec3 Normal;
out vec3 Eye;
out vec3 TexCoords;

void main()
{
    vec4 pos = modelview * vec4(position.x, position.y, position.z, 1.0);

	if (mode == 2)
	{
		//Skybox Shading Code
		gl_Position = projection * view * vec4(position.x, position.y, position.z, 1.0);
	}
	else
	{
		//Non-Skybox Shading Code
		gl_Position = projection * modelview * vec4(position.x, position.y, position.z, 1.0);
	}
    FragPos = vec3(model * vec4(position.x, position.y, position.z, 1.0));
    Normal = mat3(transpose(inverse(model))) * normal;
	TexCoords = position;

	vec4 worldPos = model * vec4(position, 1.0);
	gl_ClipDistance[0] = dot(worldPos, plane);
}
