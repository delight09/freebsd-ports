# Created by: Emil Smolenski <am@raisa.eu.org>
# $FreeBSD$

PORTNAME=	FusionInventory-Agent-Task-NetDiscovery
PORTVERSION=	2.1
PORTREVISION=	1
CATEGORIES=	net-mgmt
MASTER_SITES=	CPAN
MASTER_SITE_SUBDIR=	CPAN:FUSINV
PKGNAMEPREFIX=	p5-

MAINTAINER=	bofh@FreeBSD.org
COMMENT=	Network discovery support for FusionInventory Agent

LICENSE=	GPLv2

BUILD_DEPENDS=	p5-FusionInventory-Agent>=2.2.0:net-mgmt/p5-FusionInventory-Agent \
		p5-Net-IP>=0:net-mgmt/p5-Net-IP \
		p5-Net-NBName>=0:net/p5-Net-NBName \
		p5-Net-SNMP>=0:net-mgmt/p5-Net-SNMP \
		p5-XML-TreePP>=0.26:textproc/p5-XML-TreePP
RUN_DEPENDS:=	${BUILD_DEPENDS}

USES=		perl5
USE_PERL5=	configure

post-patch:
	@${REINPLACE_CMD} -e '40,$$ d' ${WRKSRC}/Makefile.PL

.include <bsd.port.mk>
