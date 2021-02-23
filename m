Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E323072
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBWSQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 13:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233899AbhBWSQG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Feb 2021 13:16:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9BC664E7A;
        Tue, 23 Feb 2021 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614104126;
        bh=mQU4Br63J2BOUGthrBwhXAnfS4h7IIh12XPwgj5+I3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4O/tfdzgyeQqqxC4kOzeMZ83RSqsKmFgZ/+Ltd8apHxa+NCNMbXzR/MX2Pftamzb
         WbiLBjbWAJuT2yXptuqnfaoca1rx4teegyXNO3G1gjhtvS4RS8Kghf/h9wxXNoBV/d
         Vh/LlmXZfygUxA8U9njMACIuTBUxfoafzdId9bbKjGCpr79SycnERhQW8IvOypfLUc
         884B7IVkgTOq67qA4CgTdOB58H2Lt0PzDqEtw36Gblsv10sH7NFqRxVUYOVER2w+8u
         QWsHSuUpwxsXWUva7BAWCFpBbL40F3RqzvNcaqKwIgkafoTt+5H/LZEJkC8xoR4oEH
         9qNjTgIgaE1ww==
Date:   Tue, 23 Feb 2021 18:14:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, "R, Vignesh" <vigneshr@ti.com>,
        juliensu@mxic.com.tw, ycllin@mxic.com.tw,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        zhengxunli <zhengxunli@mxic.com.tw>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210223181424.GJ5116@sirena.org.uk>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210205104736.2771074c@xps13>
 <20210205133404.esqqeokhlp4askpq@ti.com>
 <20210223141344.7ad25831@xps13>
 <20210223133649.GD5116@sirena.org.uk>
 <20210223152504.jtq4uxfepz7bdxhl@ti.com>
 <CAMuHMdVQUCaiBwdU=KdFOu=D71kYbGqoqp9V3pLsXXE0AAdCog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVQUCaiBwdU=KdFOu=D71kYbGqoqp9V3pLsXXE0AAdCog@mail.gmail.com>
X-Cookie: Kilroe hic erat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2021 at 07:07:37PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 23, 2021 at 4:25 PM Pratyush Yadav <p.yadav@ti.com> wrote:

> > To select the optimal number of dummy cycles we need to know what speed
> > the controller is running at, not the other way around. The flash would
> > always set the top speed to its maximum (say 200 MHz). But if the
> > controller is only capable of running at 50 MHz, you will end up wasting
> > dummy cycles. I don't see any API to communicate speed from controller
> > to flash.

> spi_transfer.effective_speed_hz?

> If the driver has filled this in (after the first transfer), you can optimize
> dummy cycles before doing the next transfer.  Note that effective_speed_hz
> might not always be the same, if e.g. the SPI controller shares its parent
> clock with another component.

Yes, that's what that's for, or just go with the speed set by the client
on the basis that it should be safe even if potentially wasteful.  You'd
need to fall back to that anyway in the cases where the controller
doesn't or can't report the effective speed.

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA1Rf8ACgkQJNaLcl1U
h9AotAgAgu7zrgF6PvPVwZZ3i4SuicE9EJ+mDfYe6EInpy/JuglPDAsXllpIh6vD
RCWCQlct36+Q/sXY3apGjSF0r4xUKAVv85VaXhNXEAO0m18j4vyZjjqJgS5veeNn
Sjh3/CML2DBK+dsH94tFD09axQRKIG1Cn9yUlOwI0lHBs7swVJ9fjacQivUho1te
GHNf/cuuVL8ebCzA/i9RGZjJ2HpTuInuv1cjgruyZrtrb+edMa5FnWg+PYjJpZQZ
+krYjh8vQUrYfeU4PMApzuFqOywoLRR+2MwDkC+dI7NHyfsyRKmppWLbQUCNw3hV
rKhWCGqS6KQsJ6M7nwc2e8W5q/7dog==
=eX44
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
