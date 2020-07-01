Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C721083A
	for <lists+linux-spi@lfdr.de>; Wed,  1 Jul 2020 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgGAJdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 05:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGAJdT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 05:33:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E30D20722;
        Wed,  1 Jul 2020 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593595998;
        bh=Q7gpEoPkh6bA0z/x1q2X8NK5Oy7GN6NSJUFo0hDV3Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrJBBnhirtBPQWA1S4Fe5yOp4m1YwcWuw+kJWJzQeh8DmWBMvOrftcVAB2jzQZq3I
         Yv6fql3efRC0U3g4T0nYdGG3FEh4PMtNJnglU76jgyiBCfdDHIblP4PpGtEo+0SdT2
         T/oapkBtbN3MvbHxUtzPFCToKaXzGJzI/uSncBY4=
Date:   Wed, 1 Jul 2020 10:33:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "dianders@chromium.org" <dianders@chromium.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH] spi: Avoid setting the chip select if we don't need to
Message-ID: <20200701093316.GA5385@sirena.org.uk>
References: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
 <522b1d9297604a1cfa93fdc54a3cd0773cf7580a.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <522b1d9297604a1cfa93fdc54a3cd0773cf7580a.camel@analog.com>
X-Cookie: marriage, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 06:26:24AM +0000, Ardelean, Alexandru wrote:
> On Mon, 2020-06-29 at 16:41 -0700, Douglas Anderson wrote:

> > +	spi->controller->last_cs_enable = enable;
> > +	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;

> I don't feel like this is the best approach for the SPI CS handling,
> because it's pretty difficult to guess the last CS state, and whether this
> return would cause other weirder issues [like not toggling CS when it
> should].

There's no guesswork involved here - the only thing that should be
setting the chip select is the SPI core so other than at startup we
always know the state of the chip select.

> Maybe a question is: when should this CS be toggled [or not]?
> Is it between 2 calls of spi_transfer_one_message() or between 2
> spi_transfers?
> Or, is "xfer->cs_change == 1" where it shouldn't be?

This is well documented, it's asserted while a message is being
transferred unless changed by cs_change in which case we do whatever the
opposite of the default action is.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl78WFgACgkQJNaLcl1U
h9CK7gf+Mr0ecVOXY5ISDr+Ey9IaXHmxgN6V0Z8Clkb7HJ6BM3T1BaHq9IoB8Sag
ZluyKjIzXpzKgUwXHwWuwVAB+N4TNMsNn8tvDsEDtqw+Bdt0TSrDCp8jHsNIkq4g
vDCqDsjiVNe67ouQLATkV1hMfn4GN72hNvjLR7waEnztE0e0GbIkVjq5Qa+zcXta
6fUl9EKYcoTUFqeFgp8b1WuIuvi4zLW7ryiQLYDEIKVJOrmdYrE5t7PWbmLfeivJ
uGCFHgUCdHRhc1wOGVd+7DZZo404A+AobO+/gBj7mzx8sDnbr6vCtEOt2iUA3rFZ
C+6N6Xh4an71mefmNEqWH2YJ08kHVw==
=KyJ9
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
