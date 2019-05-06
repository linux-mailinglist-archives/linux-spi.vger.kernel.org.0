Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28A14562
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEFHiC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 03:38:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEFHhr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 03:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tHEGQ9oW3tTgBWCAOeQCOTnFuPn94mh9AkAln7vInY4=; b=l7fNRNLCq2MIuMeUy6SV4mr7n
        1qpPp/FUVJ51Os8GeDRVf7F5aguVa/b0irPfvM9G/cW6+FEzAtdo798HVEHAhauYXY8UsPSnZQSRL
        tJ1EDC287NTk/V18FW2MzFdOSlzo/2DhR2TkqiYxz8p9y7lM+asUSwmonZ5IO7jxu/sL8=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNYBx-0000rz-7U; Mon, 06 May 2019 07:37:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5653E44003B; Mon,  6 May 2019 05:44:25 +0100 (BST)
Date:   Mon, 6 May 2019 13:44:25 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Message-ID: <20190506044425.GN14916@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UIkw8Cc2/Xz5YwHB"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UIkw8Cc2/Xz5YwHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > > This patch exports spi_set_cs of the spi core to allow SPI masters to=
=20
> > > use when gpio based chip select is needed.

> > This isn't really what I meant when I said it'd be good to use the
> > core GPIO code - this function doesn't do a huge amount really and
> > the usage of it in your subsequent patch for the > driver isn't
> > exactly joined up with the little it does (which is mainly swapping
> > in the GPIO chip select instead of the hardware chip select) isn't
> > used in your driver usage of this as far as I can see.  The bulk of
> > the chip select handling code in the core is actually in
> > transfer_one_message() which your driver doesn't use as it's got
> > it's own implementation of that; I've not looked in enough detail to
> > figure out if it could use it.

> In SPI Tegra driver, we wanted to have GPIO based CS control when
> cs-gpios is specified in parallel to HW/SW CS. Having parallel GPIO
> based CS is to mimic some of the timing stuff that's needed for some
> spi devices by not actually using HW CS on platform but only for SPI
> HW design logic inside the chip.

> Tegra spi driver don't use set_cs callback so looking into spi_set_cs
> from spi core implementation when cs-gpios property is used it exactly
> the same that is needed for GPIO control CS. So used this in V3.=20

> Can you please provide more details on what you are suggesting?
> Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs
> and instead implement in tegra SPI driver using GPIO descriptors ?

You're probably best open coding in the driver if there's value in using
the hardware chip select.

--UIkw8Cc2/Xz5YwHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPu6YACgkQJNaLcl1U
h9DM0Qf7Bykvbj1t4ndVRPemN1ZjRrYC94F5FOwPPHuLYIIFawPR0xupsoIwdZPi
b9rbj7/L3dNBHHO+gjkDEQLYC++gMNJnL5bSo2AA8cz/qJhVqzMS0nu+F6Fgofup
jwo4IWbjxYPAJWqrjWFj6Y79h+cXTmu+lcOiEnHoEjuqjxNH5fWJXqLrDYe7irOJ
ST8QQXWtz2T1A9BfvWzZ56NFlieoOR+vKQFZZjwYzS7irq+F9LqT5Q/VKNQOvExL
SLu4ZnMlPuZQBkOxFqtr8yve31kkxhyFfUrvhKCBwAHKzg+dt3Aop+gkbwJCeEEJ
tuLSjnUOUENVdEKWAwHEj4DdEcXH7Q==
=C76I
-----END PGP SIGNATURE-----

--UIkw8Cc2/Xz5YwHB--
