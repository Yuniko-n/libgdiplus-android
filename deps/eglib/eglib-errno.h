#ifndef __EGLIB_ERRNO_H__
#define __EGLIB_ERRNO_H__

#include <errno.h>

// Enough indirection to do something else here, or log
inline static void
eglib_set_errno (int errno_val)
{
	errno = errno_val;
}

#endif
