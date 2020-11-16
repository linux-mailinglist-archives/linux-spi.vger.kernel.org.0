Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295042B536A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgKPVGx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 16:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgKPVGw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 16:06:52 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D86D20825;
        Mon, 16 Nov 2020 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605560811;
        bh=fuNTyBy/idm3OAiNlwROP8Ya2ltDw2L98K9AwZjlfiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+XRRmiG0cyq9ttuJ5EUSJyf8LmEfbDq5FfzkPsP+VzZWEMRKHOYDYYbxdAOVYLHc
         Bj/B/xayrnZF8ikobwvQbnYv/Rh2RIKSqnadCEEqS2e619XdOVrDxaVZvhErxtNfUk
         d6QkejfhVYkVG76CulfvkINgpgSDaFgiTk7KRKiM=
Date:   Mon, 16 Nov 2020 21:06:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201116210632.GJ4739@sirena.org.uk>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk>
 <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2020 at 02:36:07PM +0100, Linus Walleij wrote:
> On Wed, Nov 11, 2020 at 1:33 PM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Nov 11, 2020 at 02:05:19AM +0100, Linus Walleij wrote:

> > This is not clear to me, most of these settings are things that are
> > constant for the device so it's not clear that they should be being set
> > by the device tree in the first place.

> This was added initially with some two properties
> in drivers/of/of_spi.c in 2008:
> commit 284b01897340974000bcc84de87a4e1becc8a83d
> "spi: Add OF binding support for SPI busses"

> This was around the time ARM was first starting to migrate
> to device tree, so I suppose it made sense to them/us back
> then.

That's from PowerPC days, not ARM, and frankly a lot of DT conversions
were just fairly mechanical conversions of what was in platform data to
DT so they may not have been especially considered.

> compatible-string. It was later that especially Rob pointed out that
> random properties on device nodes was overused and that simply
> knowing the compatible is often enough.

I've been pushing this since forever as well, as far as I remember it's
been a thing since we started doing this.

> I don't know if we ever formalized it, there is nowadays a rule akin to

> "if a property can be determined from the compatible-string, and if the
>  compatible-string is identifying the variant of the electronic component,
>  then do not add this property to the device tree description. Just
>  deduce it from the compatible-string, assign it with code to the device
>  model of the operating system and handle it inside the operating system."

> I think this, while clear and intuitive, wasn't at all clear and intuitive in
> the recent past.

I think the main push in the other direction has always been people who
want to not have to write a driver at all and put absolutely everything
into DT which has scaling issues :/

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+y6dcACgkQJNaLcl1U
h9C8Fwf+JPWQKo+85ISelGvSFPu9Ppf21g+ZXLvJ1rWuVL0tbja42GJZz2uPE4XY
zm3Lkdxroj0NK0NmeuWszPG+mW0DoGkyYHoiXADe1yjzETfXhZT+EJnIryth2QIs
z6kUfHxZpwdoa+QaA0iSmh/oxysjUHilo6TnzTPNQwnNV9T23712BVlT02O+JOli
/dlc2CG6K/geaSIuP53EpHUgTO9kIp/NFs+OGueDo/3dMIzeJ20jb8+XYKCTKT0f
9nLE44FlL62h0DqB0ixoF9f5yQu/Y5n8A37ac0R72K8S0fUDsKxEX5RF4+efrN2I
+UPmhAFR2pnmvnCbhwRpjUJlN+c7+Q==
=+rYT
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
