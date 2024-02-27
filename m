Return-Path: <linux-spi+bounces-1527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6BA869565
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 15:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A769B24D3F
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70B1419B3;
	Tue, 27 Feb 2024 14:00:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF954BD4
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042455; cv=none; b=SchgsS5X/1zpuxh8q0L1vmZ6yKpXlNLVNvYbPCkdYqsn+hZ5eYzK4Wz0Ls6+iXFyKrveUvs0xzO8ioHFKlFhvBDXAqJ2NcV9ipYdVAQDcQy0Q7/LVsg0I2njSEP1J5qpvV6KlbspiEITbvpbtezTT8jMWiVejBDSdw7m8sfIp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042455; c=relaxed/simple;
	bh=iSTH3SKfKBiE8Ytma+D6vAYq76jex9lHkMZBe5mmnZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFrWqBuZeco/aFSxygrBC8DmOwlAPld3x0aBnqUK+SYbVxfUZnfffkiQ+KNtWUh3hEdV6fcw28oTWiWxPuC+tPxOIju+j8d//A048dJXf+lOEC+MW+9XToKsLwgwQcSUzoAgBvnDbHtwekIKI92BKq5kA9mWy1W/XgywBKdYvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rey0V-0008Gl-Vq; Tue, 27 Feb 2024 15:00:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rey0U-003DCm-J2; Tue, 27 Feb 2024 15:00:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rey0U-00CUXz-1d;
	Tue, 27 Feb 2024 15:00:30 +0100
Date: Tue, 27 Feb 2024 15:00:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: Increasing build coverage for drivers/spi/spi-ppc4xx.c
Message-ID: <645ngchmigftlvbvquprqqjcn2frogkihdplbmngnz6hvywefo@rvthwy2epwg3>
References: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
 <6fab09e0-1f21-4ada-b5ae-472bf71a1225@csgroup.eu>
 <7ah7rzijbwkvr3hmtqfjh7syxave756usevumrypqspn27wgyv@ln42tyqxo5ai>
 <2fe58bc5-2f1b-4f51-8f01-fa397a1c9291@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yofmhws4bjeessoi"
Content-Disposition: inline
In-Reply-To: <2fe58bc5-2f1b-4f51-8f01-fa397a1c9291@csgroup.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--yofmhws4bjeessoi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:52:07PM +0000, Christophe Leroy wrote:
>=20
>=20
> Le 27/02/2024 =E0 11:58, Uwe Kleine-K=F6nig a =E9crit=A0:
> > Hello Christophe,
> >=20
> > On Tue, Feb 27, 2024 at 10:25:15AM +0000, Christophe Leroy wrote:
> >> Le 27/02/2024 =E0 09:46, Uwe Kleine-K=F6nig a =E9crit=A0:
> >>> recently the spi-ppc4xx.c driver suffered from build errors and warni=
ngs
> >>> that were undetected for longer than I expected. I think it would be
> >>> very beneficial if this driver was enabled in (at least) a powerpc
> >>> allmodconfig build.
> >>>
> >>> The challenge to do so is that spi-ppc4xx.c uses dcri_clrset() which =
is
> >>> only defined for 4xx (as these select PPC_DCR_NATIVE).
> >>>
> >>> I wonder if dcri_clrset() could be defined for the PPC_DCR_MMIO case,
> >>> too. I tried and failed. The best I came up without extensive doc
> >>> reading is:
> >>>
> >>> diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/inc=
lude/asm/dcr-native.h
> >>> index a92059964579..159ab7abfe46 100644
> >>> --- a/arch/powerpc/include/asm/dcr-native.h
> >>> +++ b/arch/powerpc/include/asm/dcr-native.h
> >>> @@ -115,15 +115,11 @@ static inline void __dcri_clrset(int base_addr,=
 int base_data, int reg,
> >>>    	unsigned int val;
> >>>   =20
> >>>    	spin_lock_irqsave(&dcr_ind_lock, flags);
> >>> -	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
> >>> -		mtdcrx(base_addr, reg);
> >>> -		val =3D (mfdcrx(base_data) & ~clr) | set;
> >>> -		mtdcrx(base_data, val);
> >>> -	} else {
> >>> -		__mtdcr(base_addr, reg);
> >>> -		val =3D (__mfdcr(base_data) & ~clr) | set;
> >>> -		__mtdcr(base_data, val);
> >>> -	}
> >>> +
> >>> +	mtdcr(base_addr, reg);
> >>> +	val =3D (mfdcr(base_data) & ~clr) | set;
> >>> +	mtdcr(base_data, val);
> >>> +
> >>>    	spin_unlock_irqrestore(&dcr_ind_lock, flags);
> >>>    }
> >>>   =20
> >>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> >>> index bc7021da2fe9..9a0a5e8c70c8 100644
> >>> --- a/drivers/spi/Kconfig
> >>> +++ b/drivers/spi/Kconfig
> >>> @@ -810,7 +810,8 @@ config SPI_PL022
> >>>   =20
> >>>    config SPI_PPC4xx
> >>>    	tristate "PPC4xx SPI Controller"
> >>> -	depends on PPC32 && 4xx
> >>> +	depends on 4xx || COMPILE_TEST
> >>> +	depends on PPC32 || PPC64
> >>>    	select SPI_BITBANG
> >>>    	help
> >>>    	  This selects a driver for the PPC4xx SPI Controller.
> >>>
> >>> While this is a step in the right direction (I think) it's not enough=
 to
> >>> make the driver build (but maybe make it easier to define
> >>> dcri_clrset()?)
> >>>
> >>> Could someone with more powerpc knowledge jump in and help (for the
> >>> benefit of better compile coverage of the spi driver and so less
> >>> breakage)? (If you do so based on my changes above, you don't need to
> >>> credit me for my effort, claim it as your's. I'm happy enough if the
> >>> situation improves.)
> >>
> >> What about this ?
> >>
> >> diff --git a/arch/powerpc/include/asm/dcr-mmio.h
> >> b/arch/powerpc/include/asm/dcr-mmio.h
> >> index fc6d93ef4a13..38b515afbffc 100644
> >> --- a/arch/powerpc/include/asm/dcr-mmio.h
> >> +++ b/arch/powerpc/include/asm/dcr-mmio.h
> >> @@ -38,6 +38,11 @@ static inline void dcr_write_mmio(dcr_host_mmio_t h=
ost,
> >>    	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
> >>    }
> >>
> >> +static inline void __dcri_clrset(int base_addr, int base_data, int re=
g,
> >> +				 unsigned clr, unsigned set)
> >> +{
> >> +}
> >> +
> >=20
> > The downside of that one is that if we find a matching device where
> > dcr-mmio is used, the driver claims to work but silently fails. Is this
> > good enough?
>=20
> I don't know the details of DCR, but it looks like this spi-ppc4xx=20
> driver is really specific to 4xx, which is PPC32.
>=20
> Do you really need/want it to be built with allmodconfig ?
>=20
> Maybe it would be easier to have it work with ppc32_allmodconfig ?
>=20
> Or even easier with ppc44x_defconfig ?

The reason I'd like to see it in allmodconfig is that testing
allmodconfig on several archs is the check I do for my patch series.
Also I assume I'm not the only one relying on allmodconfig for this
purpose. So in my eyes every driver that is built there is a net win.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yofmhws4bjeessoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXd6v0ACgkQj4D7WH0S
/k7yEgf/Tz157az3FVESUBdN2ilY0Teefm0nbWyCzS5sUxh2ppmaB6c9HQmu1nK/
zy4BS9L2c5chIbzOcwTE8anMvfVAVuqF3MuNSCa+Yau6OKL6pE8qyPMYTV6tWlKJ
WRP59kwZsQw+BVms96Oo336/knSmapitLLixbYXvNn13eC2FZVM8PR7WvJPSm86G
PFimEGz+sJoEfSs8yRTSP5a7CBgEGES90yxs3sxoj/WELpGER5xkTMU6axeZdpY5
tG4LfR3HbSuNiA5+/yY4INKOcPoFbe4nzmi4tjb41S3+clUYvEvKhrMahxPXrJ2P
2ajDfO+3zjz1dRKEs32WZaqb0GzhWw==
=bkOz
-----END PGP SIGNATURE-----

--yofmhws4bjeessoi--

