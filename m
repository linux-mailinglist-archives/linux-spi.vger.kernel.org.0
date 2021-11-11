Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2F44D766
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhKKNog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 08:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKNoe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 08:44:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A778F60E54;
        Thu, 11 Nov 2021 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636638104;
        bh=sqkxx2F9izR8cpE/fARCX9a3Bd3IAf/rb6U8tEEs7R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWmidjO+J9YVN/ig0b4/bbh69v3Lt8yZDLo2mPxWIZn9sGWaazAs5E/2dMc0EYZN2
         ADgVLu2r8KXXXm0Uza0aOtDIU0y+Que57a+u6VOqk0bp3OmZFAT9snQ5BJGVq4pssV
         kSxybjNXfPL5zx7YzPmnmSDUedhdW6GR1TKINMrymJjWGHqmMjLyXT21B0N8U0MlKS
         vGcM3cM6HpnEH4zVVGce4aqaOu7ubEZSYuGtbNS68sVQUyA4W4v3zKy0ohKs/UyLst
         oaXhE0x6iQ+fVdbeHcjljAMhX1maCbmc//0SNeB7bul3Hoje5MqRg6YhfRtDFiSxOw
         qzoW5lQbt9/Ug==
Date:   Thu, 11 Nov 2021 13:41:39 +0000
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
Message-ID: <YY0dk26NqoOi2QEH@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
 <YYqMLPB6VX9k5LUK@sirena.org.uk>
 <f98b5548cf564093af1d10ba1239507d@sphcmbx02.sunplus.com.tw>
 <YYvx4LtKiSPBIgCN@sirena.org.uk>
 <70a9c10ef34e46c2a51f134829abdd08@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pck+/FIWitogOn/m"
Content-Disposition: inline
In-Reply-To: <70a9c10ef34e46c2a51f134829abdd08@sphcmbx02.sunplus.com.tw>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pck+/FIWitogOn/m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2021 at 08:32:39AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> #define SPI_CS_HIGH   0x04 /* chipselect active high? */
> Is it mean?
> CASE1 : standby, CS high =3D> start transfer CS become low =3D> transfer =
end CS become high and standby
> CASE2 : standby, CS low =3D> start transfer CS become high =3D> transfer =
end CS become low and standby

> I think SPI_CS_HIGH means CASE2, But it is strange that more chipset work=
 in CASE1 but drivers set SPI_CS_HIGH as defined.

SPI_CS_HIGH is case 2.

> 2. And in the CASE1 I should set=20
> cs_gpios =3D 	<gpio 3 2 GPIO_ACTIVE_LOW>,
> or
> cs_gpios =3D 	<gpio 3 2 GPIO_ACTIVE_HIGH>,

_ACTIVE_HIGH if _CS_HIGH is specified, though the binding will try to
sort things out either way.

> 3. If I did not set the max_transfer_size of spi_control
> And use transfer_one set max_transfer_size and use_gpio_descriptors
> Can it transmit data that exceeds FIFO max bytes (even exceed HW's one-ti=
me transfer) in one transmission activity?

Yes, if you don't set a maximum transfer size the driver might get any
transfer size.  If you set a maximum transfer size then the driver will
not see any transfers that exceed the maximum transfer size.

> This is my concern, so I use Transfer_One_message

I can't understand how that would follow on.  If there's a limit on the
size of an individual transfer then tell the framework about that limit,
that's all that needs doing.  Why would it be preferable to not tell the
core about the limit and instead open code things?

*Please* think about the lengthy explanation I provided in my last
message about putting things that are not device specific in the
framework not the driver.

> Ex : Need to transmit 4000 bytes.=20
>   Then I set Ctlr->transfer_one and use_gpio_descriptors
>     ctlr->max_transfer_size =3D 255;
>     The CS of device is low active

>    When the transmission starts, I can see the signal gpio-CS changes fro=
m high to low
> Ctlr->transfer_one will be triggered to execute 16 times, and transfer en=
d gpio-CS changes from low to high.

This is exactly what will happen if you do as has been repeatedly
suggested.  Set a maximum *transfer* (not message) size, let the core
handle the chip select GPIO and implement transfer_one().

--pck+/FIWitogOn/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNHZIACgkQJNaLcl1U
h9BhxQf/dNb3QGDghgy0gCEBIz77vsh2QBE4ak32dP/7LIaFPqHKjg8F5QSrVhKM
gBdHwkLceWkCRzOFDiWGZmHBPaD3502B5XwsrErdMrkIGRRTDTOhbRniCPa2s5Ts
EKpT8RWNmKGNzMqywvGTgRREknWidEGRjURTGJOO1L57L+qoosr55b2aJQRbSUUC
sD9XtWVYOj//TBB4msjA56nZMo9y/YMC99dokmeWG5OaU3nlvDyWB2AONG1CndF4
uzFIF9ByZgh03G/byuluOWpBqFNaIReVZC+lDi3DsEKtZQIhh2Q2OPsXOm8/iaEg
gA+vmVbkTK75FlpLsHJnpO7qT42D+A==
=6rJr
-----END PGP SIGNATURE-----

--pck+/FIWitogOn/m--
