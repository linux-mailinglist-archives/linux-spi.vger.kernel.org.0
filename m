Return-Path: <linux-spi+bounces-1517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A089F868B2B
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 09:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD5A283B13
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8307BAE7;
	Tue, 27 Feb 2024 08:47:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C812EBC8
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023625; cv=none; b=OQERJCunPBB/KFdP2Z0nwtsAJMqsc+Z6RGaZoaStcwhuGil8qOIZMcQCWGSEcMvTei/fJZm8+FXRaIr7D4XBva/0hScoXD6QZjQcl9Zgre5gcMN6szGmKbRVG4tdVukYcHIAxSiHnoD2GkVIhpROS/JbP29VomiFhRRoBS2XJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023625; c=relaxed/simple;
	bh=UhDeIhrmGwaQW6n0yRLGxohLCjw2fk86n5YVIzLim08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=swLPZfMBn3JfE6/OR5n98PDqEHMQ9IXNdKVGQln2JUCJj3rjLMtnHVoVIXZhoL4CpeMOgUVxWs91nbcDqF0ssoTDu2TPq17VOfqAnAuVT60mFZd6hEN5vGzSkkvauI5+jLNreouG7OcX+04qEY5aANMt6L6TGSoEo3wy+NNENa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ret6v-0003DI-OB; Tue, 27 Feb 2024 09:46:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ret6u-0039kQ-3P; Tue, 27 Feb 2024 09:46:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ret6u-00CL29-02;
	Tue, 27 Feb 2024 09:46:48 +0100
Date: Tue, 27 Feb 2024 09:46:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Subject: Increasing build coverage for drivers/spi/spi-ppc4xx.c
Message-ID: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pdqtf3l5nbfguqt3"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--pdqtf3l5nbfguqt3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

recently the spi-ppc4xx.c driver suffered from build errors and warnings
that were undetected for longer than I expected. I think it would be
very beneficial if this driver was enabled in (at least) a powerpc
allmodconfig build.

The challenge to do so is that spi-ppc4xx.c uses dcri_clrset() which is
only defined for 4xx (as these select PPC_DCR_NATIVE).

I wonder if dcri_clrset() could be defined for the PPC_DCR_MMIO case,
too. I tried and failed. The best I came up without extensive doc
reading is:

diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/a=
sm/dcr-native.h
index a92059964579..159ab7abfe46 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -115,15 +115,11 @@ static inline void __dcri_clrset(int base_addr, int b=
ase_data, int reg,
 	unsigned int val;
=20
 	spin_lock_irqsave(&dcr_ind_lock, flags);
-	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
-		mtdcrx(base_addr, reg);
-		val =3D (mfdcrx(base_data) & ~clr) | set;
-		mtdcrx(base_data, val);
-	} else {
-		__mtdcr(base_addr, reg);
-		val =3D (__mfdcr(base_data) & ~clr) | set;
-		__mtdcr(base_data, val);
-	}
+
+	mtdcr(base_addr, reg);
+	val =3D (mfdcr(base_data) & ~clr) | set;
+	mtdcr(base_data, val);
+
 	spin_unlock_irqrestore(&dcr_ind_lock, flags);
 }
=20
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bc7021da2fe9..9a0a5e8c70c8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -810,7 +810,8 @@ config SPI_PL022
=20
 config SPI_PPC4xx
 	tristate "PPC4xx SPI Controller"
-	depends on PPC32 && 4xx
+	depends on 4xx || COMPILE_TEST
+	depends on PPC32 || PPC64
 	select SPI_BITBANG
 	help
 	  This selects a driver for the PPC4xx SPI Controller.

While this is a step in the right direction (I think) it's not enough to
make the driver build (but maybe make it easier to define
dcri_clrset()?)

Could someone with more powerpc knowledge jump in and help (for the
benefit of better compile coverage of the spi driver and so less
breakage)? (If you do so based on my changes above, you don't need to
credit me for my effort, claim it as your's. I'm happy enough if the
situation improves.)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pdqtf3l5nbfguqt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXdoXcACgkQj4D7WH0S
/k7vXQf6AkXGI7iH3aBjJ9XLOaapu4lrYQh0OTChbwICyvaJm2IF4w5DxEcHrlkn
Eb99x993wMGR9NgL0unwgwsaMyFe4dwk244Syy6FYYDuhxime67J4XOIs3XXV9GL
rUxW5EAZFU3RWL1QkaVE81ZMsn3OCrKd5eCFtE5nwSneNRcFsbclXYe8qD2MSeKI
x9zhvaQYK3CcYQVUgyqW5NWyHFNXee7XiZHq16M/sthfzNlA2xYZwPY3A76DqVMB
ayFxhR0QJBpsjZwlsjAxU8OgY1lDd9KZ6LsSP0CyQ4f8WDLv9fQN+rxu2JRLAiOL
KLPe9WbnXfN9jS9m5PuCekpVBtIqyA==
=Ij2S
-----END PGP SIGNATURE-----

--pdqtf3l5nbfguqt3--

