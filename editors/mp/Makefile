# Created by: Mark Pulford <mark@kyne.com.au>
# $FreeBSD$

PORTNAME=	mp
DISTVERSION=	5.2.11
CATEGORIES=	editors
MASTER_SITES=	http://triptico.com/download/mp/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Programming text editor

LICENSE=	GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

BROKEN_aarch64=		fails to compile: conflicting types for __wcwidth
BROKEN_armv6=		fails to compile: conflicting types for __wcwidth
BROKEN_armv7=		fails to compile: conflicting types for __wcwidth

USES=		iconv ncurses
HAS_CONFIGURE=	yes
CONFIGURE_SCRIPT=	config.sh
CONFIGURE_ARGS=	--prefix=${PREFIX} --without-win32 --without-kde4

DATADIR=	${PREFIX}/share/mp-5

OPTIONS_DEFINE=		DOCS NLS PCRE
OPTIONS_RADIO=		GUI
OPTIONS_RADIO_GUI=	GTK2 GTK3 QT4
OPTIONS_DEFAULT=	PCRE
OPTIONS_SUB=		yes

NLS_USES=		gettext
NLS_CONFIGURE_WITH=	gettext
GTK2_USE=		gnome=cairo,gdkpixbuf2,gtk20
GTK2_LIB_DEPENDS=	libfontconfig.so:x11-fonts/fontconfig \
			libfreetype.so:print/freetype2
GTK3_USE=		gnome=cairo,gdkpixbuf2,gtk30
PCRE_LIB_DEPENDS=	libpcre.so:devel/pcre
PCRE_CONFIGURE_WITH=	pcre
QT4_USE=		qt4=corelib,gui,moc_build
QT4_CONFIGURE_ENV=	CPP="${CXX}" CCLINK="${CXX}"
QT4_CONFIGURE_WITH=	qt4

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MGTK2} || ${PORT_OPTIONS:MGTK3} || ${PORT_OPTIONS:MQT4}
USES+=		pkgconfig
PLIST_SUB+=	GUI=""
.else
PLIST_SUB+=	GUI="@comment "
.endif

.if ${PORT_OPTIONS:MGTK2} || ${PORT_OPTIONS:MGTK3}
DESKTOP_ENTRIES="Minimum Profit" "" "mp-5" "mp" "Develpment;TextEditor;GTK;" ""
.else
CONFIGURE_ARGS+=	--without-gtk
CONFOPT_GTK=	0
.endif

.if ${PORT_OPTIONS:MGTK2}
CONFOPT_GTK=	2
.endif

.if ${PORT_OPTIONS:MGTK3}
CONFOPT_GTK=	3
.endif

.if ${PORT_OPTIONS:MQT4}
DESKTOP_ENTRIES="Minimum Profit" "" "mp-5" "mp" "Development;TextEditor;Qt;" ""
QT_NONSTANDARD=	yes
.endif

post-patch:
	@${REINPLACE_CMD} -e \
		's|<ncursesw/|<| ; \
		 s|-I/usr/local/include|| ; \
		 s|-L/usr/local/lib|| ; \
		 s|-lncursesw|${LDFLAGS} -lncursesw| ; \
		 /gtk+/s|3.0|${CONFOPT_GTK}.0| ; \
		 /OK/s|3.0|${CONFOPT_GTK}.0| ; \
		 /CONFOPT_GTK/s|3|${CONFOPT_GTK}|' ${WRKSRC}/config.sh
	@${REINPLACE_CMD} -e \
		's|<ncursesw/|<|g' ${WRKSRC}/mpv_curses.c
	@${REINPLACE_CMD} -e \
		's|%%LOCALBASE%%|${LOCALBASE}| ; \
		 s|%%ICONV_PREFIX%%|${ICONV_PREFIX}| ; \
		 s|%%ICONV_LIB%%|${ICONV_LIB}|g' ${WRKSRC}/mpdm/config.sh
.for i in mpdm/mpdm.h mpdm/mpdm_s.c mpsl/mpsl_d.c
	@${REINPLACE_CMD} -e \
		's|<malloc\.h>|<stdlib.h>|g' ${WRKSRC}/${i}
.endfor

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/mp-5 ${STAGEDIR}${PREFIX}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/mpsl/mpsl ${STAGEDIR}${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/mp-5.1 ${STAGEDIR}${MANPREFIX}/man/man1
	@${MKDIR} ${STAGEDIR}${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/mp_*.mpsl ${STAGEDIR}${DATADIR}
	@${MKDIR} ${STAGEDIR}${DATADIR}/lang
	${INSTALL_DATA} ${WRKSRC}/lang/*.mpsl ${STAGEDIR}${DATADIR}/lang
.if ${PORT_OPTIONS:MGTK2} || ${PORT_OPTIONS:MGTK3} || ${PORT_OPTIONS:MQT4}
	${INSTALL_DATA} ${WRKSRC}/mp.png ${STAGEDIR}${PREFIX}/share/pixmaps
.endif

do-install-NLS-on:
.for lang in de es it nl ru sv
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/locale/${lang}/LC_MESSAGES
	${INSTALL_DATA} ${WRKSRC}/po/${lang}.mo \
		${STAGEDIR}${PREFIX}/share/locale/${lang}/LC_MESSAGES/minimum-profit.mo
.endfor

do-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for doc in AUTHORS README RELEASE_NOTES mp_templates.sample doc/*.*
	${INSTALL_DATA} ${WRKSRC}/${doc} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
