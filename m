Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31472455CD8
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 14:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhKRNl2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 08:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhKRNl1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 08:41:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90673617E5;
        Thu, 18 Nov 2021 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637242707;
        bh=hLl7IjdRvqKdkE+mSKKqxPbm1kSkIRvdG0UJzw4TKwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jePfkbfF3EH7tLYMgp9uodBG445aeIc+BhDplVOr3iHfnGjN8+TgWg3FCiJ/SwRZH
         nsvn1DjOtfOoCm2WsufUZ7oxQ2YX/nqZXJ1c1IfVbMflOtEebjjAWcyv9kZjmzuJhi
         lLofh00MJGlYKM6YGmGfoKYOnNpOuoeqtC9xAdYdPcH4mIIIEFR4bK+MunSuHmplEH
         MAQxMEbKQ0sHaKmSppYnVx7pMptZFE6+LHL7pCKe4DDVXWk4Y5yGb4sAHLVShZJG9i
         hytUzKK4mHJDWpNWB5j5XoGsAfMDm/fQwOqxEL5xvAFlorJeidUsrTuQ3NtYnbtnoL
         u0cA9HdFALpJA==
Date:   Thu, 18 Nov 2021 13:38:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YZZXTokMn6+p7C3H@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
 <YYqMLPB6VX9k5LUK@sirena.org.uk>
 <f98b5548cf564093af1d10ba1239507d@sphcmbx02.sunplus.com.tw>
 <YYvx4LtKiSPBIgCN@sirena.org.uk>
 <70a9c10ef34e46c2a51f134829abdd08@sphcmbx02.sunplus.com.tw>
 <YY0dk26NqoOi2QEH@sirena.org.uk>
 <083dc70e20964ec8b74f71f6817be55e@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tplQcX+QKV56luWj"
Content-Disposition: inline
In-Reply-To: <083dc70e20964ec8b74f71f6817be55e@sphcmbx02.sunplus.com.tw>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tplQcX+QKV56luWj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 09:11:08AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

> The main function are as follows
>=20
> The sp7021_spi_mas_transfer_one is replace the transfer_one_message funct=
ion.
>=20
> static int sp7021_spi_mas_transfer_one(struct spi_controller *ctlr,
> 		struct spi_device *spi, struct spi_transfer *xfer)
> {
> 	struct sp7021_spi_ctlr *pspim =3D spi_master_get_devdata(ctlr);
> 	u32 reg_temp =3D 0;
> 	unsigned long timeout =3D msecs_to_jiffies(1000);

I'm still not clear why this needs to be transfer_one_message() and not
just transfer_one()?  The whole thing with copying everything into a
buffer is a bit confusing to me.

> The probe function is as follows.
>=20
> static int sp7021_spi_controller_probe(struct platform_device *pdev)
> {
> 	int ret;
> 	int mode;
> 	struct spi_controller *ctlr;
> 	struct sp7021_spi_ctlr *pspim;

This looks fine.

--tplQcX+QKV56luWj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWV00ACgkQJNaLcl1U
h9ACYAf/WN2ye9DzTP1BTyDED8vTdgtzpXVIRx5bvw8xz9/l8mluwdplMlwXRle+
zFLDiAqiRG9kysYPdE02/BewqGMPwTwgfT+3KwIbL7BQYXzI803MQuE4KJD3VQNL
BLnxmEgAhR1PWDIfBX1THd6E1Eccn9Wz6TJ2k39QB59C0amAw3earHEGFAkVG5aM
7MpC4A/PBwtsh2XGeEwDIJSNwnkYbE1vgmJjqvZuTgOoTT88g1hELG675UYQPfO3
3zdsLjHMNminXqFzIa3Rri9E8EkLJMjfGsOrstHKgyT9P/cft+MFMKwhSJNAUtPs
1Oh7gawY7IV3wyNBbZWTrzwQtBWEiQ==
=KTHo
-----END PGP SIGNATURE-----

--tplQcX+QKV56luWj--
