# libxml.m4 serial 2 (gettext-0.16.1)
dnl Copyright (C) 2006 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Bruno Haible.

AC_DEFUN([gl_LIBXML],
[
  AC_REQUIRE([AM_ICONV_LINK])

  AC_MSG_CHECKING([whether included libxml is requested])
  AC_ARG_WITH([included-libxml],
    [  --with-included-libxml  use the libxml2 included here],
    [gl_cv_libxml_force_included=$withval],
    [gl_cv_libxml_force_included=no])
  AC_MSG_RESULT([$gl_cv_libxml_force_included])

  gl_cv_libxml_use_included="$gl_cv_libxml_force_included"
  LIBXML=
  LTLIBXML=
  INCXML=
  if test "$gl_cv_libxml_use_included" != yes; then
    dnl Figure out whether we can use a preinstalled libxml2, or have to use
    dnl the included one.
    AC_CACHE_VAL([gl_cv_libxml], [
      gl_cv_libxml=no
      gl_cv_LIBXML=
      gl_cv_LTLIBXML=
      gl_cv_INCXML=
      gl_save_LIBS="$LIBS"
      LIBS="$LIBS $LIBICONV"
      dnl Search for libxml2 and define LIBXML2, LTLIBXML2 and INCXML2
      dnl accordingly.
      dnl Don't use xml2-config nor pkg-config, since it doesn't work when
      dnl cross-compiling or when the C compiler in use is different from the
      dnl one that built the library.
      AC_LIB_LINKFLAGS_BODY([xml2])
      LIBS="$gl_save_LIBS $LIBXML2 $LIBICONV"
      AC_TRY_LINK([#include <libxml/xmlversion.h>],
        [xmlCheckVersion (0);],
        [gl_cv_libxml=yes
         gl_cv_LIBXML="$LIBXML2 $LIBICONV"
         gl_cv_LTLIBXML="$LTLIBXML2 $LTLIBICONV"
        ])
      if test "$gl_cv_libxml" != yes; then
        gl_save_CPPFLAGS="$CPPFLAGS"
        CPPFLAGS="$CPPFLAGS $INCXML2"
        AC_TRY_LINK([#include <libxml/xmlversion.h>],
          [xmlCheckVersion (0);],
          [gl_cv_libxml=yes
           gl_cv_LIBXML="$LIBXML2 $LIBICONV"
           gl_cv_LTLIBXML="$LTLIBXML2 $LTLIBICONV"
           gl_cv_INCXML="$INCXML2"
          ])
        if test "$gl_cv_libxml" != yes; then
          dnl Often the include files are installed in /usr/include/libxml2.
          AC_TRY_LINK([#include <libxml2/libxml/xmlversion.h>],
            [xmlCheckVersion (0);],
            [gl_ABSOLUTE_HEADER([libxml2/libxml/xmlversion.h])
             libxml2_include_dir=`echo "$gl_cv_absolute_libxml2_libxml_xmlversion_h" | sed -e 's,.libxml.xmlversion\.h$,,'`
             if test -d "$libxml2_include_dir"; then
               gl_cv_libxml=yes
               gl_cv_LIBXML="$LIBXML2 $LIBICONV"
               gl_cv_LTLIBXML="$LTLIBXML2 $LTLIBICONV"
               gl_cv_INCXML="-I$libxml2_include_dir"
             fi
            ])
        fi
        CPPFLAGS="$gl_save_CPPFLAGS"
      fi
      LIBS="$gl_save_LIBS"
    ])
    AC_MSG_CHECKING([for libxml])
    AC_MSG_RESULT([$gl_cv_libxml])
    if test $gl_cv_libxml = yes; then
      LIBXML="$gl_cv_LIBXML"
      LTLIBXML="$gl_cv_LTLIBXML"
      INCXML="$gl_cv_INCXML"
    else
      gl_cv_libxml_use_included=yes
    fi
  fi
  AC_SUBST([LIBXML])
  AC_SUBST([LTLIBXML])
  AC_SUBST([INCXML])
  AC_MSG_CHECKING([whether to use the included libxml])
  AC_MSG_RESULT([$gl_cv_libxml_use_included])

  if test "$gl_cv_libxml_use_included" = yes; then
    LIBXML_H=
    LIBXML_H="$LIBXML_H libxml/DOCBparser.h"
    LIBXML_H="$LIBXML_H libxml/HTMLparser.h"
    LIBXML_H="$LIBXML_H libxml/HTMLtree.h"
    LIBXML_H="$LIBXML_H libxml/SAX2.h"
    LIBXML_H="$LIBXML_H libxml/SAX.h"
    LIBXML_H="$LIBXML_H libxml/c14n.h"
    LIBXML_H="$LIBXML_H libxml/catalog.h"
    LIBXML_H="$LIBXML_H libxml/chvalid.h"
    LIBXML_H="$LIBXML_H libxml/debugXML.h"
    LIBXML_H="$LIBXML_H libxml/dict.h"
    LIBXML_H="$LIBXML_H libxml/encoding.h"
    LIBXML_H="$LIBXML_H libxml/entities.h"
    LIBXML_H="$LIBXML_H libxml/globals.h"
    LIBXML_H="$LIBXML_H libxml/hash.h"
    LIBXML_H="$LIBXML_H libxml/list.h"
    LIBXML_H="$LIBXML_H libxml/nanoftp.h"
    LIBXML_H="$LIBXML_H libxml/nanohttp.h"
    LIBXML_H="$LIBXML_H libxml/parser.h"
    LIBXML_H="$LIBXML_H libxml/parserInternals.h"
    LIBXML_H="$LIBXML_H libxml/pattern.h"
    LIBXML_H="$LIBXML_H libxml/relaxng.h"
    LIBXML_H="$LIBXML_H libxml/schemasInternals.h"
    LIBXML_H="$LIBXML_H libxml/schematron.h"
    LIBXML_H="$LIBXML_H libxml/threads.h"
    LIBXML_H="$LIBXML_H libxml/tree.h"
    LIBXML_H="$LIBXML_H libxml/uri.h"
    LIBXML_H="$LIBXML_H libxml/valid.h"
    LIBXML_H="$LIBXML_H libxml/xinclude.h"
    LIBXML_H="$LIBXML_H libxml/xlink.h"
    LIBXML_H="$LIBXML_H libxml/xmlIO.h"
    LIBXML_H="$LIBXML_H libxml/xmlautomata.h"
    LIBXML_H="$LIBXML_H libxml/xmlerror.h"
    LIBXML_H="$LIBXML_H libxml/xmlexports.h"
    LIBXML_H="$LIBXML_H libxml/xmlmemory.h"
    LIBXML_H="$LIBXML_H libxml/xmlmodule.h"
    LIBXML_H="$LIBXML_H libxml/xmlreader.h"
    LIBXML_H="$LIBXML_H libxml/xmlregexp.h"
    LIBXML_H="$LIBXML_H libxml/xmlsave.h"
    LIBXML_H="$LIBXML_H libxml/xmlschemas.h"
    LIBXML_H="$LIBXML_H libxml/xmlschemastypes.h"
    LIBXML_H="$LIBXML_H libxml/xmlstring.h"
    LIBXML_H="$LIBXML_H libxml/xmlunicode.h"
    LIBXML_H="$LIBXML_H libxml/xmlversion.h"
    LIBXML_H="$LIBXML_H libxml/xmlwriter.h"
    LIBXML_H="$LIBXML_H libxml/xpath.h"
    LIBXML_H="$LIBXML_H libxml/xpathInternals.h"
    LIBXML_H="$LIBXML_H libxml/xpointer.h"
    AC_CHECK_HEADERS([arpa/inet.h arpa/nameser.h ctype.h dlfcn.h dl.h errno.h \
                      fcntl.h float.h limits.h malloc.h math.h netdb.h \
                      netinet/in.h resolv.h signal.h stdlib.h string.h \
                      strings.h sys/select.h sys/socket.h sys/stat.h \
                      sys/time.h sys/types.h time.h unistd.h])
    AC_CHECK_FUNCS([dlopen getaddrinfo localtime shlload stat _stat strftime \
                    va_copy __va_copy])
    dnl Don't bother checking for pthread.h and other multithread facilities.
    dnl Don't bother checking for zlib.h and how to link with libz.
  else
    LIBXML_H=
  fi
  AC_SUBST([LIBXML_H])

  AM_CONDITIONAL([INCLUDED_LIBXML],
    [test "$gl_cv_libxml_use_included" = yes])
])