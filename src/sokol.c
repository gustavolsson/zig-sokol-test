#define SOKOL_IMPL
#if defined(_WIN32)
#include <Windows.h>
#define SOKOL_LOG(s) OutputDebugStringA(s)
#endif
/* this is only needed for the debug-inspection headers */
#define SOKOL_TRACE_HOOKS
/* sokol 3D-API defines are provided by build options */
#define SOKOL_GLCORE33
#include "sokol_app.h"
#include "sokol_gfx.h"
//#include "sokol_time.h"
//#include "sokol_audio.h"
//#include "sokol_fetch.h"
