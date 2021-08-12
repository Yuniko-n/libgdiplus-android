#include "glib.h"

typedef struct _GStaticPrivateNode GStaticPrivateNode;

struct _GStaticPrivateNode
{
  gpointer       data;
  GDestroyNotify destroy;
};

static void g_static_private_free_data (gpointer data);
static void g_thread_fail (void);

/* Global variables */

gboolean g_thread_use_default_impl = TRUE;
gboolean g_threads_got_initialized = FALSE;

GThreadFunctions g_thread_functions_for_glib_use = {
  (GMutex*(*)())g_thread_fail,                 /* mutex_new */
  NULL,                                        /* mutex_lock */
  NULL,                                        /* mutex_trylock */
  NULL,                                        /* mutex_unlock */
  NULL,                                        /* mutex_free */
  (GCond*(*)())g_thread_fail,                  /* cond_new */
  NULL,                                        /* cond_signal */
  NULL,                                        /* cond_broadcast */
  NULL,                                        /* cond_wait */
  NULL,                                        /* cond_timed_wait  */
  NULL,                                        /* cond_free */
  (GPrivate*(*)(GDestroyNotify))g_thread_fail, /* private_new */
  NULL,                                        /* private_get */
  NULL,                                        /* private_set */
}; 

/* Local data */

static GMutex   *g_mutex_protect_static_mutex_allocation = NULL;
static GMutex   *g_thread_specific_mutex = NULL;
static GPrivate *g_thread_specific_private = NULL;

/* This must be called only once, before any threads are created.
 * It will only be called from g_thread_init() in -lgthread.
 */
void
g_mutex_init (void)
{
  /* We let the main thread (the one that calls g_thread_init) inherit
   * the data, that it set before calling g_thread_init
   */
  gpointer private_old = g_thread_specific_private;

  g_thread_specific_private = g_private_new (g_static_private_free_data);

  /* we can not use g_private_set here, as g_threads_got_initialized is not
   * yet set TRUE, whereas the private_set function is already set.
   */
  g_thread_functions_for_glib_use.private_set (g_thread_specific_private, 
					       private_old);

  g_mutex_protect_static_mutex_allocation = g_mutex_new();
  g_thread_specific_mutex = g_mutex_new();
}

GMutex *
g_static_mutex_get_mutex_impl (GMutex** mutex)
{
  if (!g_thread_supported ())
    return NULL;

  g_assert (g_mutex_protect_static_mutex_allocation);

  g_mutex_lock (g_mutex_protect_static_mutex_allocation);

  if (!(*mutex)) 
    *mutex = g_mutex_new(); 

  g_mutex_unlock (g_mutex_protect_static_mutex_allocation);
  
  return *mutex;
}

gpointer
g_static_private_get (GStaticPrivate *private_key)
{
  GArray *array;

  array = g_private_get (g_thread_specific_private);
  if (!array)
    return NULL;

  if (!private_key->index)
    return NULL;
  else if (private_key->index <= array->len)
    return g_array_index_gmutex (array, GStaticPrivateNode, private_key->index - 1).data;
  else
    return NULL;
}

void
g_static_private_set (GStaticPrivate *private_key, gpointer data, GDestroyNotify notify)
{
  GArray *array;
  static guint next_index = 0;
  GStaticPrivateNode *node;
  
  array = g_private_get (g_thread_specific_private);
  if (!array)
    {
      array = g_array_new (FALSE, TRUE, sizeof (GStaticPrivateNode));
      g_private_set (g_thread_specific_private, array);
    }

  if (!private_key->index)
    {
      g_mutex_lock (g_thread_specific_mutex);

      if (!private_key->index)
	private_key->index = ++next_index;

      g_mutex_unlock (g_thread_specific_mutex);
    }

  if (private_key->index > array->len)
    g_array_set_size (array, private_key->index);

  node = &g_array_index_gmutex (array, GStaticPrivateNode, private_key->index - 1);
  if (node->destroy)
    {
      gpointer ddata = node->data;
      GDestroyNotify ddestroy = node->destroy;

      node->data = data;
      node->destroy = notify;

      ddestroy (ddata);
    }
  else
    {
      node->data = data;
      node->destroy = notify;
    }
}

static void
g_static_private_free_data (gpointer data)
{
  if (data)
    {
      GArray* array = data;
      guint i;
      
      for (i = 0; i < array->len; i++ )
	{
	  GStaticPrivateNode *node = &g_array_index_gmutex (array, GStaticPrivateNode, i);
	  if (node->destroy)
	    node->destroy (node->data);
	}
    }
}

static void
g_thread_fail (void)
{
  g_error ("The thread system is not yet initialized.");
}

#define ISSPACE(c)              ((c) == ' ' || (c) == '\f' || (c) == '\n' || \
                                 (c) == '\r' || (c) == '\t' || (c) == '\v')
#define ISUPPER(c)              ((c) >= 'A' && (c) <= 'Z')
#define ISLOWER(c)              ((c) >= 'a' && (c) <= 'z')
#define ISALPHA(c)              (ISUPPER (c) || ISLOWER (c))
#define TOUPPER(c)              (ISLOWER (c) ? (c) - 'a' + 'A' : (c))
#define TOLOWER(c)              (ISUPPER (c) ? (c) - 'A' + 'a' : (c))

#ifndef USE_XLOCALE

static guint64
g_parse_long_long (const gchar *nptr, const gchar **endptr, guint base, gboolean *negative)
{
  /* this code is based on on the strtol(3) code from GNU libc released under
   * the GNU Lesser General Public License.
   *
   * Copyright (C) 1991,92,94,95,96,97,98,99,2000,01,02
   *        Free Software Foundation, Inc.
   */
  gboolean overflow;
  guint64 cutoff;
  guint64 cutlim;
  guint64 ui64;
  const gchar *s, *save;
  guchar c;

  g_return_val_if_fail (nptr != NULL, 0);

  *negative = FALSE;
  if (base == 1 || base > 36)
    {
      errno = EINVAL;
      if (endptr)
        *endptr = nptr;
      return 0;
    }

  save = s = nptr;

  /* Skip white space.  */
  while (ISSPACE (*s))
    ++s;

  if (G_UNLIKELY (!*s))
    goto noconv;

  /* Check for a sign.  */
  if (*s == '-')
    {
      *negative = TRUE;
      ++s;
    }
  else if (*s == '+')
    ++s;

  /* Recognize number prefix and if BASE is zero, figure it out ourselves.  */
  if (*s == '0')
    {
      if ((base == 0 || base == 16) && TOUPPER (s[1]) == 'X')
        {
          s += 2;
          base = 16;
        }
      else if (base == 0)
        base = 8;
    }
  else if (base == 0)
    base = 10;

  /* Save the pointer so we can check later if anything happened.  */
  save = s;
  cutoff = G_MAXUINT64 / base;
  cutlim = G_MAXUINT64 % base;

  overflow = FALSE;
  ui64 = 0;
  c = *s;
  for (; c; c = *++s)
    {
      if (c >= '0' && c <= '9')
        c -= '0';
      else if (ISALPHA (c))
        c = TOUPPER (c) - 'A' + 10;
      else
        break;
      if (c >= base)
        break;
      /* Check for overflow.  */
      if (ui64 > cutoff || (ui64 == cutoff && c > cutlim))
        overflow = TRUE;
      else
        {
          ui64 *= base;
          ui64 += c;
        }
    }

  /* Check if anything actually happened.  */
  if (s == save)
    goto noconv;

  /* Store in ENDPTR the address of one character
     past the last character we converted.  */
  if (endptr)
    *endptr = s;

  if (G_UNLIKELY (overflow))
    {
      errno = ERANGE;
      return G_MAXUINT64;
    }

  return ui64;

 noconv:
  /* We must handle a special case here: the base is 0 or 16 and the
     first two characters are '0' and 'x', but the rest are no
     hexadecimal digits.  This is no error case.  We return 0 and
     ENDPTR points to the `x`.  */
  if (endptr)
    {
      if (save - nptr >= 2 && TOUPPER (save[-1]) == 'X'
          && save[-2] == '0')
        *endptr = &save[-1];
      else
        /*  There was no number to convert.  */
        *endptr = nptr;
    }
  return 0;
}
#endif /* !USE_XLOCALE */

gint64
g_ascii_strtoll (const gchar *nptr, gchar **endptr, guint base)
{
#ifdef USE_XLOCALE
  return strtoll_l (nptr, endptr, base, get_C_locale ());
#else
  gboolean negative;
  guint64 result;

  result = g_parse_long_long (nptr, (const gchar **) endptr, base, &negative);

  if (negative && result > (guint64) G_MININT64)
    {
      errno = ERANGE;
      return G_MININT64;
    }
  else if (!negative && result > (guint64) G_MAXINT64)
    {
      errno = ERANGE;
      return G_MAXINT64;
    }
  else if (negative)
    return - (gint64) result;
  else
    return (gint64) result;
#endif
}
