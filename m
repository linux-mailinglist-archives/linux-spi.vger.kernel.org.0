Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA033B76A5
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhF2Qu3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 12:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhF2Qu2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 12:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D12B861DDF;
        Tue, 29 Jun 2021 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624985281;
        bh=Jl8J6QixYT0QGbyHoh2fD4BXpQo3XvIYPXOblLqNw+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCMEgITY6aXXBV6pUj9buIY75Xl9ykzVp/Ct5iJlgA4HN7c37MHFxp8DWYIMh2i/r
         CriQNO8uGZ84ucLWsiTTQDCzpzyf2bUp7JWLPguMcbepIZM9J+YG6Bs7ntdFZfyJgX
         Ey4x3IbrE07X741Oif7s0d2ZMmIlNiFoHOu/CTzVBThO/oN2w+r8Dw7AdWCjPm5nxk
         AWRdwbFl2HIyrl+Ixyi7BHlwhn19CXFTu7Xw8q8L6EG0bCXJwdVqKIcrRdFfUo6eKW
         Rfj6Xb/9d6iTXo/fHZuSL81hJMgbgcyXOOMpSIKyM4RWSFQDRiUgOJS2QM8lMn0I6t
         uY+TPGhDcW8wQ==
Date:   Tue, 29 Jun 2021 17:47:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Sneddon <dan.sneddon@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] spi: atmel: Fix CS and initialization bug
Message-ID: <20210629164733.GE4613@sirena.org.uk>
References: <20210629162914.23286-1-dan.sneddon@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <20210629162914.23286-1-dan.sneddon@microchip.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 09:29:14AM -0700, Dan Sneddon wrote:

> spi_setup won't get programmed into the hardware.  This patch makes
> sure the cs_activate call is made even with a gpio controlled chip
> select.

In what way does it do that?  I can't tell what the patch is supposed to
do.

> -	enable =3D (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable);
> =20
> -	if (enable) {
> +	if ((enable && (spi->mode & SPI_CS_HIGH))
> +			|| (!enable && !(spi->mode & SPI_CS_HIGH))) {

This looks especially suspicious.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDbTqQACgkQJNaLcl1U
h9BN5gf+Pm6DMsgO/YsJGrz7jXmNW/56VqpC35uRtHR82xH4vfY1/JRrIgY7+4Qz
EjZcYWpAqaEWybRZIvsB2BAlcqGe1ACpCaIfITPpLOv8+tNyZyke4ATyAMtkWDXc
q7o2sG+2HqriF1VUAIAoIHvtAEifVOmO9s5tuB+lvaZaws1MisfWifEKKpAvOqpi
TdVZlm3+46aRRBLOWCYsKDa8mABe/Z8LPNuIGfZYisVtuqF8uXfowgZ+qpTkhKqA
KIlovuKsf+jgNnlN7zowJrYdkcG3l6RR/aw2l/J83ud4ZSJeJn4/s+QYfEJZi3M3
UK5yQuVk/JlscHVR4LdWX+Yh8MLB9A==
=G/4+
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
