# $FreeBSD$

PORTNAME=	natapp
DISTVERSION=	2_3_8
CATEGORIES=	net
MASTER_SITES=	http://download.natapp.cn/assets/downloads/clients/${DISTVERSION}/
PKGNAMESUFFIX=	-bin
DISTNAME=	natapp_freebsd_amd64_${DISTVERSION}

MAINTAINER=	me@djh.im
COMMENT=	Ngrok-based high-speed intranet passthrough service in China

LICENSE=	MIT

# extract configure spec
USES=		zip
EXTRACT_BEFORE_ARGS=	-j
EXTRACT_AFTER_ARGS=	-d ${EXTRACT_WRKDIR}/${DISTNAME}

# build spec
NO_BUILD=	yes
STRIP=

# stage spec
USE_RC_SUBR=	natapp
USERS=	natapp
GROUPS=	natapp

SUB_FILES+=	pkg-message pkg-install

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/natapp ${STAGEDIR}${PREFIX}/bin
	${MKDIR} ${STAGEDIR}${ETCDIR}
	${INSTALL_DATA} ${WRKSRC}/config.ini.sample ${STAGEDIR}${ETCDIR}
	${MKDIR} ${STAGEDIR}/var/log/natapp

.include <bsd.port.mk>
