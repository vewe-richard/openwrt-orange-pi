#include <stdio.h>
#include "hellomake.h"

#define GL_GLEXT_PROTOTYPES
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>

char vertex_shader_code[] =
 "attribute vec4 vPosition; \n"
 "void main() \n"
 "{ \n"
    " gl_Position = vPosition; \n"
 "}; \n";

char fragment_shader_code[] =
 "precision mediump float; \n"
 "void main() \n"
 "{ \n"
  " gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); \n"
 "} \n";

GLuint program;
GLuint buffer;

void init(void)
{
	glGenBuffers(1, &buffer);
	glBindBuffer(GL_ARRAY_BUFFER, buffer);
	glBufferData(GL_ARRAY_BUFFER, 4 * 2 * sizeof(GLfloat),
			  NULL, GL_STATIC_DRAW);

	GLfloat *data = (GLfloat *) glMapBufferOES(GL_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
	data[0] = -0.75f; data[1] = -0.75f;
	data[2] = -0.75f; data[3] =  0.75f;
	data[4] =  0.75f; data[5] =  0.75f;
	data[6] =  0.75f; data[7] = -0.75f;
	glUnmapBufferOES(GL_ARRAY_BUFFER);

	glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));

	GLuint vs = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vs, 1, (const char**) &vertex_shader_code, NULL);
	glCompileShader(vs);
	GLuint fs = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fs, 1, (const char**) &fragment_shader_code, NULL);
	glCompileShader(fs);
	program = glCreateProgram();
	glAttachShader(program, vs);
	glAttachShader(program, fs);
	glLinkProgram(program);

	glUseProgram(program);
}

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	SDL_GL_SwapBuffers();
}

void myPrintHelloMake(void) {

  printf("Hello makefiles jiangjqian!\n");

  return;
}
