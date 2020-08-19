Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B611B24A698
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHSTNA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 15:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgHSTM7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 15:12:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2B2207BB;
        Wed, 19 Aug 2020 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597864378;
        bh=voSL+lWqcnfjcy4h1Q6c2nLbMzJXxHUzKbBfLNzsfzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9m3ROd13cymoWNcFmiOdWCsIdtgyR3zURjHnW2LQBMxuy+CNg6CP/98MyNRXY7vs
         U3NtBlNa6h4tQ6Uw8SbZ0xsJKmEPnEC6POk7Fde5gp9nSmG1N/qw7gm4Zg62fhY3rQ
         CPbbWExy+EqaqKZY1DgV/g29d7RxeulK19mDlOWg=
Date:   Wed, 19 Aug 2020 20:12:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Message-ID: <20200819191227.GG5441@sirena.org.uk>
References: <20200819131635.GD5441@sirena.org.uk>
 <CGME20200819140203eucas1p2818858289f2394b32f3c647e47705cd2@eucas1p2.samsung.com>
 <dleftj4koy20q7.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
In-Reply-To: <dleftj4koy20q7.fsf%l.stelmach@samsung.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 04:01:52PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 =C5=9Bro 14:16>, when Mark Brown wrote:
> > On Wed, Aug 19, 2020 at 02:58:22PM +0200, Krzysztof Kozlowski wrote:
> >> On Wed, Aug 19, 2020 at 02:51:27PM +0200, Lukasz Stelmach wrote:

> >> >     0732a9d2a155 spi/s3c64xx: Use core message handling

> >> Then describe at least this... maybe Mark knows why he brough back old
> >> code after refactoring?

> > I'm not sure what's being referred to as being lost in the second commit
> > TBH.

> Order of enable_cs() and enable_datapath(). The order 0f5a sets makes
> (for a reaseon I don't know) my devices work. In the latter commit,
> which rewrites "everything", enable_datapath() is called before what
> later (in aa4964c4eb3e) became s3c64xx_spi_set_cs().

That's doesn't look like what the changes do.  Note that the enable_cs()
function that got moved in 0f5a751ace250097 (spi/s3c64xx: Enable GPIO
/CS prior to starting hardware) does not touch the chip registers at
all, it only manipulates GPIOs, code that was subsequently factored out
into the core.  The write to the _SLAVE_SEL register has so far as I can
see always been after enable_datapath() right back to the initial
commit, it just got made more complex for the Exynos7 controller (I'm
guessing your new one might be an ancestor of that?) in bf77cba95f8c06
(spi: s3c64xx: add support for exynos7 SPI controller) and then factored
out in the commit you mention above.

Are you sure your new ordering works for all controller revisions?
According to the comment the _set_cs() is what's actually kicking off
the transfer which suggests that the data/DMA needed to be ready
beforehand to avoid an underflow or something (and nobody reported
issues before, I know people have done things like downloaded firmwares
using this controller...), this could be something that got changed
between revisions.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.

> > The first commit is simple code motion rather than a correctness
> > thing, and more related to the handling of GPIO controlled chip
> > selects according to the description (which people should be using
> > with that controller anyway where possible IIRC, the native chip
> > select has too many assumptions about what it's doing).

> Funny, but without the automatic CS control (see the next patch in this
> series) my stuff does not work.

There's two things, there's changing the controller registers and there
is the use of the signal coming out of the controller as the chip select
that the device on the SPI bus sees.  Most systems have pinmuxing which
allows the internal chip select to just not be connected to anything
which is what I'm talking about in the above text, IIRC all versions of
the controller have unfortunate assumptions about how chip selects
should work which make GPIO controlled chip selects much better.

> > I don't know that I ever actually used a system that used the native
> > chip select as the actual chip select.  Perhaps some quirk was
> > introduced where the chip select signal does something?

> > The commit is also lacking a description of what the issues that are
> > being fixed are.

> On Exynos3250 DMA transfers from SPI longer than 512 fail.

Could you expand on "fail" please?

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89eZoACgkQJNaLcl1U
h9BwZwgAgLyMhDbuvcsndqZiqJpOqaOMWwtUanWbPlI1mWRQOocopn6pWYcaerCp
KiqYol0vX1AkJbxGnIFMx9Tr0HPbEsBi5rnuePo/5h+siW8A+cHeNieB1SMV8LdP
h9Kw7yRUaLAZXjg5FvFqIiZeV0o5hVI4jX7qgmgnDc7cLhjlAvz7NFxXiDUWDphJ
5ynpg5iQ2VjlSSi9emiWXGZCBPelkoLCUEFh9Nhydur4jKek0NaqyrY9k4YTn03I
V/ncmgOlEtR6UjFFdedlaMB4LNPDWm+Gyj/m2FRvPwTYNpkqkSTk6MboQsCFhUlc
o4K4LnbfTa1bzvPZ6aXn5R6cPx/cfQ==
=i5Ty
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--
