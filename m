Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169AE446425
	for <lists+linux-spi@lfdr.de>; Fri,  5 Nov 2021 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhKENcm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Nov 2021 09:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhKENcl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Nov 2021 09:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A91D61101;
        Fri,  5 Nov 2021 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636119002;
        bh=mWKgiLiqyBozrdDt2IL3sh1nM4cVgTMzzQcmq0TcnkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5OLpa3k4y1B934tTm2A7l322K2c0ySciU0R2kY8zf9+r/TvQIb106K3/ezP7K+RT
         tSR0qVhBtQjah2ssuXzVFgCCJDOAbDT3RjZH0FXf9r143lfkv9+T9+K/VKvmroDHE9
         rqiS0ig9Vr/o4wowieHcVp0gbtLX6NVAHAykxWnrieWnv3LzITNKTVjiuiHPTSywNe
         KQqy1t9x+Dev+af2Xf5B1FviyZwQ6RNbPjvZkSvLKxGH5UOD+oYysKETMlLQq08iGU
         ze4p7slLkS5Cqbu+bYkT//ODClGiseasb+9Hwc1RGLYlBrw0EG2Vn+JxWnAc1KJnQK
         MAhpRJZARmcHQ==
Date:   Fri, 5 Nov 2021 13:29:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YYUx1VxyvL5evRA6@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
 <YYAzrDuLYQt4U06J@sirena.org.uk>
 <1c5b8e435d614772a5c0af8d5c633941@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XjvkUaH+EetQzKru"
Content-Disposition: inline
In-Reply-To: <1c5b8e435d614772a5c0af8d5c633941@sphcmbx02.sunplus.com.tw>
X-Cookie: For recreational use only.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--XjvkUaH+EetQzKru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 05, 2021 at 03:12:32AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > > +++ b/drivers/spi/spi-sunplus-sp7021.c
> > > @@ -0,0 +1,1356 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Sunplus SPI controller driver
> > > + *
> > > + * Author: Sunplus Technology Co., Ltd.

> > Please make the entire comment a C++ one so things look more intentiona=
l.

> Sorry I don't understand. Is there a explanation?

Make the entire comment block C++ style - //

> > If the device has a GPIO chip select it should use the core support for=
 GPIO
> > chip selects rather than open coding.

> Sorry But I didn't find the core function support to use simply. The core=
 function is too complicated for me.

What did you try and in what way was it complicated?  There's lots of
other drivers using this and it's generally resulted in less code in the
drivers so it seems this should be soemthing we can solve.

> > > +	if (RW_phase =3D=3D SPI_SLAVE_WRITE) {

> > > +	} else if (RW_phase =3D=3D SPI_SLAVE_READ) {

> > These two cases share no code, they should probably be separate functio=
ns
> > (and what happens if it's an unknown phase?).

> The slave mode of SP7021 is only half duplex.

Not sure that really addresses the concern?

> > > +	if (pspim->tx_cur_len < data_len) {
> > > +		len_temp =3D min(pspim->data_unit, data_len);
> > > +		sp7021spi_wb(pspim, len_temp);
> > > +	}

> > What if there's more data?

> SP7021 only support 16bytes FIFO transfer.

It can transfer more than one FIFO's worth of data though can't it?

> > I find it difficult to convince myself that this isn't going to have an=
y overflow
> > issues, and it'll break operation with anything that does any manipulat=
ion of
> > chip select during the message.  Given that the device uses GPIO chip s=
elects
> > I'd expect it to just implement transfer_one() and not handle messages =
at all.
> > This would greatly simplify the code.

> More conditions will be checked in the spi-message function.
> In this case, only rx-date is allocated for each transfer of the  message.

Part of the issue with both this and the previous section is code
clarity - it's not just if the code is correct, it's if it's clear that
the code is correct.

> > So we are using transfer_one?  In that case I'm very confused why the d=
river
> > would be walking a transfer list...

> And the spi of SP7021 includes two working modes: spi-master and spi-slave
>=20
> SP7021 spi-master : full-duplex  FIFO-mode only.
> SP7021 spi-slave : helf-duplex  DMA-mode

> It seems that linux can contain these two modes in one drive. And this is=
 what I need.
> Because many registers are overlapped, if they are used in different driv=
es,=20
> they will crash if they are declared.

I think the driver needs to be restructured so it's clear which bits
apply to which mode, it's basically two completely separate code paths.
I have to say that it's really very surprising that the two different
modes use such completely different control mechanisms, normally the
differentiation would be more triggered by performance reasons.

--XjvkUaH+EetQzKru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGFMdQACgkQJNaLcl1U
h9Bqjwf+LNBPkZ4s2u6+i9R8vT+a3nNJiUhnlikJJTHPLmlE5gNOOXMs7JGYOtfj
3O2E7/DNGcuu7ad8cTUXmZ4dVGSHhbA8GS8FsK/JN3a3MVd21oogPoeJc0c1yooP
3AqEZDKXWdFXx61IZYzSTe0Ga3zhIe5Cn4b708uZ7EeCeav6dKJlRS9Ot0bWlOY+
G1Hmanv1oRMfqkETlCyBCuMk8OJ12XioOhTNnezeHgaEKIvgIOV/ZJ4b31OngH+o
XIv/rkP0vuuFGgqYyeTSwo1/DigsjjVs0AAAr3hvphrIIRdO3JEOjFZLNrdQxBsz
szmI5rwe5naM9OL9XuDMAhdVtFBcFA==
=F6B1
-----END PGP SIGNATURE-----

--XjvkUaH+EetQzKru--
