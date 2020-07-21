Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C485228BF0
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 00:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGUWad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 18:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGUWad (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jul 2020 18:30:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E7E2064C;
        Tue, 21 Jul 2020 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595370632;
        bh=xFFSij1Tvo5a8FZcCLmFL1s046LYalCTyT1TMQt3DmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUeo2rK+zwevmzkMZxRMKP+LlbLxTIAkBYeLrQ0GFv+UxwlVfl78+L3Uw24DRa6IC
         G9cy2+BX3BsfdS2bImdTajk5UI2FwqDLYR3IpZVaYvI6128BRjtuGXlBGa6RDsb0Ey
         eztN/5Bc08oBOD7q20DN+uJbmp+KJj59xhXcgs28=
Date:   Tue, 21 Jul 2020 23:30:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-spi@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        nicolas.ferre@microchip.com
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200721223018.GE4845@sirena.org.uk>
References: <20200519163353.20c03286@windsurf.home>
 <20200519152449.GM4611@sirena.org.uk>
 <20200520121819.0f816ec0@windsurf.home>
 <20200520112659.GB4823@sirena.org.uk>
 <20200721153944.3c331415@windsurf.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <20200721153944.3c331415@windsurf.home>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 03:39:44PM +0200, Thomas Petazzoni wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > I'm not sure what you mean by "it might want to consider error
> > > checking". Could you explain? =20

> > It wasn't checking the return values of SPI API calls.

> Right, but this is unlikely to be the source of the CPU consumption
> issue we're seeing.

Indeed, that was just something I noticed while reviewing.

> > Actually looking at the code in __spi_pump_messages() again I think that
> > in the case where we don't have any cleanup to do we should be able to
> > avoid kicking the thread for that which should help a bit for spi-atmel.
> > Can you give the patch below a go (compile tested only, not even tried
> > to boot)?

> I gave it a try, and unfortunately there is no difference. But it is
> not too surprising, as top shows something like this:

>    80     2 root     SW       0   0%  24% [irq/50-spi1.3]
>    57     2 root     IW       0   0%   2% [kworker/0:1-eve]

> So it's not the kthread of the SPI subsystem that is consuming most of
> the CPU time, but really the threaded handler of the MAX14830 driver.
> What your patch does is avoid offloading to the SPI subsystem kthread
> some cleanup work when it can be done in the current context, if I
> understand correctly.

It does, yes.  Depending on the particular performance characteristics
of the system it can sometimes help noticably to cut out those context
thrashes if just the context switching ends up being a noticable
overhead, regardless of how much work each thread does when it does get
control.  In any case that's now merged in -next, I got some testing on
other boards, so hopefully it'll help someone.

> > You can generally get a good idea of what's going on with regard to
> > context switching at the SPI level from the SPI tracepoints, and about
> > any latencies in there too.

> I'll have a look there, but I don't really have any latency issue,
> rather a CPU consumption issue, which is quite different.

Yeah, that's basically where the overhead in the SPI subsystem itself
(rather than the specific driver) tends to be unfortunately.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8XbHoACgkQJNaLcl1U
h9CqtAf/dzvXgG8/59g/lErs4M4bbXd7rkZE8h3H2iZ5i8wrMAmCphreuyHl1Pj3
1iQHcR/x/glb/sZ4z3wnwgwH1tHZId7ZU58ftSQeyVYsaXi8/Ll/4pjzwNTZgi16
3MJy1VT6Skm2c5xLBLgjkpsYJU7Dq7gzytEu/7OuGlemHMsiASVnYeqXqy5bRwRs
cHSF/ETIQgNyd5MYCpIBiizn5EEFHfWwtqcn6ywOLVnT2R+JXq87u0xIdOpFrHyv
uoudZipEudzB5elku8/QGD7DAzYaDWEzqU6ABV40HwZlcuGGQPTcVLTjmgwLskCa
csXP+UW/mVwK/5c7/a5jg0rak5zd0Q==
=PH6f
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
