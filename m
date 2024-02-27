Return-Path: <linux-spi+bounces-1521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F79868E30
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 11:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E889D1F237B0
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2C1386B0;
	Tue, 27 Feb 2024 10:59:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90F2A8C1
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031556; cv=none; b=WOiCAZ4oAjtTOdArjymAHLnjTOjCME/C8JN1QmmBTiccQU83aOo9PiUZG1SWQwwdv++mP+brquTeq5oOe1DDuIQnD9G1UTAEl+eGunQFg/TyN5GIo+xFgSlPS7/CBEzhBOYqCWeVEEpEAdfu4u9g1xcSEyHOc6oY2nKgDYNjbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031556; c=relaxed/simple;
	bh=K6LokbucwNC6FDB7DwD5gvu0NGczOpMTWLNNiBLddyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRPMu2EUk491RrjsJ8K4o7C9VCoZaHARl7fmwPTvUt+DIKTPGbZebCJslzhEEDS6gvuoDviobwbXyGa2NY2IwzIRtElIbyE4rZPFhivg1ceAAL75xKm4JyQDQQCgr7lIW1mUC9uekDnDufmR2iyO7LscdotQdK+57lpaEm2ygHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1revAp-0004dH-Tz; Tue, 27 Feb 2024 11:58:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1revAn-003B8F-P3; Tue, 27 Feb 2024 11:58:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1revAn-00COJY-2E;
	Tue, 27 Feb 2024 11:58:57 +0100
Date: Tue, 27 Feb 2024 11:58:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: Increasing build coverage for drivers/spi/spi-ppc4xx.c
Message-ID: <7ah7rzijbwkvr3hmtqfjh7syxave756usevumrypqspn27wgyv@ln42tyqxo5ai>
References: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
 <6fab09e0-1f21-4ada-b5ae-472bf71a1225@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nizoxx5p7q3r2rkw"
Content-Disposition: inline
In-Reply-To: <6fab09e0-1f21-4ada-b5ae-472bf71a1225@csgroup.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--nizoxx5p7q3r2rkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christophe,

On Tue, Feb 27, 2024 at 10:25:15AM +0000, Christophe Leroy wrote:
> Le 27/02/2024 =E0 09:46, Uwe Kleine-K=F6nig a =E9crit=A0:
> > recently the spi-ppc4xx.c driver suffered from build errors and warnings
> > that were undetected for longer than I expected. I think it would be
> > very beneficial if this driver was enabled in (at least) a powerpc
> > allmodconfig build.
> >=20
> > The challenge to do so is that spi-ppc4xx.c uses dcri_clrset() which is
> > only defined for 4xx (as these select PPC_DCR_NATIVE).
> >=20
> > I wonder if dcri_clrset() could be defined for the PPC_DCR_MMIO case,
> > too. I tried and failed. The best I came up without extensive doc
> > reading is:
> >=20
> > diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/inclu=
de/asm/dcr-native.h
> > index a92059964579..159ab7abfe46 100644
> > --- a/arch/powerpc/include/asm/dcr-native.h
> > +++ b/arch/powerpc/include/asm/dcr-native.h
> > @@ -115,15 +115,11 @@ static inline void __dcri_clrset(int base_addr, i=
nt base_data, int reg,
> >   	unsigned int val;
> >  =20
> >   	spin_lock_irqsave(&dcr_ind_lock, flags);
> > -	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
> > -		mtdcrx(base_addr, reg);
> > -		val =3D (mfdcrx(base_data) & ~clr) | set;
> > -		mtdcrx(base_data, val);
> > -	} else {
> > -		__mtdcr(base_addr, reg);
> > -		val =3D (__mfdcr(base_data) & ~clr) | set;
> > -		__mtdcr(base_data, val);
> > -	}
> > +
> > +	mtdcr(base_addr, reg);
> > +	val =3D (mfdcr(base_data) & ~clr) | set;
> > +	mtdcr(base_data, val);
> > +
> >   	spin_unlock_irqrestore(&dcr_ind_lock, flags);
> >   }
> >  =20
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index bc7021da2fe9..9a0a5e8c70c8 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -810,7 +810,8 @@ config SPI_PL022
> >  =20
> >   config SPI_PPC4xx
> >   	tristate "PPC4xx SPI Controller"
> > -	depends on PPC32 && 4xx
> > +	depends on 4xx || COMPILE_TEST
> > +	depends on PPC32 || PPC64
> >   	select SPI_BITBANG
> >   	help
> >   	  This selects a driver for the PPC4xx SPI Controller.
> >=20
> > While this is a step in the right direction (I think) it's not enough to
> > make the driver build (but maybe make it easier to define
> > dcri_clrset()?)
> >=20
> > Could someone with more powerpc knowledge jump in and help (for the
> > benefit of better compile coverage of the spi driver and so less
> > breakage)? (If you do so based on my changes above, you don't need to
> > credit me for my effort, claim it as your's. I'm happy enough if the
> > situation improves.)
>=20
> What about this ?
>=20
> diff --git a/arch/powerpc/include/asm/dcr-mmio.h=20
> b/arch/powerpc/include/asm/dcr-mmio.h
> index fc6d93ef4a13..38b515afbffc 100644
> --- a/arch/powerpc/include/asm/dcr-mmio.h
> +++ b/arch/powerpc/include/asm/dcr-mmio.h
> @@ -38,6 +38,11 @@ static inline void dcr_write_mmio(dcr_host_mmio_t host,
>   	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
>   }
>=20
> +static inline void __dcri_clrset(int base_addr, int base_data, int reg,
> +				 unsigned clr, unsigned set)
> +{
> +}
> +

The downside of that one is that if we find a matching device where
dcr-mmio is used, the driver claims to work but silently fails. Is this
good enough?

>   #endif /* __KERNEL__ */
>   #endif /* _ASM_POWERPC_DCR_MMIO_H */
>=20
> diff --git a/arch/powerpc/include/asm/dcr-native.h=20
> b/arch/powerpc/include/asm/dcr-native.h
> index a92059964579..2f6221bf5406 100644
> --- a/arch/powerpc/include/asm/dcr-native.h
> +++ b/arch/powerpc/include/asm/dcr-native.h
> @@ -135,10 +135,6 @@ static inline void __dcri_clrset(int base_addr, int=
=20
> base_data, int reg,
>   					 DCRN_ ## base ## _CONFIG_DATA,	\
>   					 reg, data)
>=20
> -#define dcri_clrset(base, reg, clr, set)	__dcri_clrset(DCRN_ ## base ##=
=20
> _CONFIG_ADDR,	\
> -							      DCRN_ ## base ## _CONFIG_DATA,	\
> -							      reg, clr, set)
> -
>   #endif /* __ASSEMBLY__ */
>   #endif /* __KERNEL__ */
>   #endif /* _ASM_POWERPC_DCR_NATIVE_H */
> diff --git a/arch/powerpc/include/asm/dcr.h b/arch/powerpc/include/asm/dc=
r.h
> index 64030e3a1f30..15c123ae38a1 100644
> --- a/arch/powerpc/include/asm/dcr.h
> +++ b/arch/powerpc/include/asm/dcr.h
> @@ -18,6 +18,9 @@
>   #include <asm/dcr-mmio.h>
>   #endif
>=20
> +#define dcri_clrset(base, reg, clr, set)	__dcri_clrset(DCRN_ ## base ##=
=20
> _CONFIG_ADDR,	\
> +							      DCRN_ ## base ## _CONFIG_DATA,	\
> +							      reg, clr, set)
>=20
>   /* Indirection layer for providing both NATIVE and MMIO support. */
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ddae0fde798e..7b003c5dd613 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -810,7 +810,7 @@ config SPI_PL022
>=20
>   config SPI_PPC4xx
>   	tristate "PPC4xx SPI Controller"
> -	depends on PPC32 && 4xx
> +	depends on PPC && (4xx || COMPILE_TEST)

Ah, I wondered about not finding a global powerpc symbol. Just missed it
because I expected it at the top of arch/powerpc/Kconfig.

I would have split the depends line into

	depends on PPC
	depends on 4xx || COMPILE_TEST

but apart from that I like it. Maybe split the change into the powerpc
stuff and then a separate patch changing SPI_PPC4xx?

Another thing I wondered is: Should SPI_PPC4xx better depend on
PPC_DCR_NATIVE instead of 4xx? This is an orthogonal change however.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nizoxx5p7q3r2rkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXdwHAACgkQj4D7WH0S
/k6hHggAniXJFL90Boot/yk3MayYNuoBC/iVLbE4SulIYxRM91agAvcJA4WgpgC6
oT7Jy+oMtqTno11bfBe2EF4HeBcJSMXx/c64nx5mk1Lw0Y2ihtI3sj+aL/mc32y+
rw+pXT7IT+7lMbVJoHsGmOmlHxQzDv5r/W0felBEbJ4JCP1L+y0GpUHMKxbS54fO
ub4zcD+2IuNaUA6Ih1VAC6V3YZ6N6y+i6pI49qJ593JbpF0jCG0A4bA1+B18sEUu
1ixyzOlkPOiALkGN1tkP2b13STkrU5m2cm8NEZKKf6eoafHRsJrPKDxcemAsZeze
LN/GYd0ztYwXYy0Yhne77un91ff9zQ==
=oemm
-----END PGP SIGNATURE-----

--nizoxx5p7q3r2rkw--

