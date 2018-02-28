# $FreeBSD$

PORTNAME=	v2ray
PORTVERSION=	3.10
DISTVERSIONPREFIX=	v
CATEGORIES=	net
MASTER_SITES=	https://github.com/v2ray/v2ray-core/releases/download/${DISTVERSIONPREFIX}${PORTVERSION}/
PKGNAMESUFFIX=	-bin
DISTNAME=	v2ray-freebsd-64

MAINTAINER=	me@djh.im
COMMENT=	Platform for building proxies to bypass network restrictions

LICENSE=	MIT

# extract configure spec
USES=		zip
HAS_CONFIGURE=	yes
CONFIGURE_SCRIPT=	../../scripts/verify_binaries.sh
CONFIGURE_FAIL_MESSAGE=	The binary signature verification failed, giving up...
EXTRACT_BEFORE_ARGS=	-j
EXTRACT_AFTER_ARGS=	-d ${EXTRACT_WRKDIR}/${DISTNAME}

# build spec
NO_BUILD=	yes
STRIP=

# stage spec
USE_RC_SUBR=	v2ray
SUB_FILES+=	pkg-message

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/v2ctl ${STAGEDIR}${PREFIX}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/v2ray ${STAGEDIR}${PREFIX}/bin
	${MKDIR} ${STAGEDIR}${ETCDIR}
	${INSTALL_DATA} ${WRKSRC}/geosite.dat ${STAGEDIR}${ETCDIR}
	${INSTALL_DATA} ${WRKSRC}/geoip.dat ${STAGEDIR}${ETCDIR}
	${CP} ${WRKSRC}/vpoint_socks_vmess.json ${STAGEDIR}${ETCDIR}/vpoint_socks_vmess.json.sample
	${CP} ${WRKSRC}/vpoint_vmess_freedom.json ${STAGEDIR}${ETCDIR}/vpoint_vmess_freedom.json.sample

.include <bsd.port.mk>
