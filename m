Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281EE3B76E6
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhF2RKh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 13:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232398AbhF2RKh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 13:10:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5248661CA2;
        Tue, 29 Jun 2021 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624986489;
        bh=g/mppS63LinC/XGMDdSs70lnw5zZae5ZvS4wtptza28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHunzWU0kS4zfdoYSMe5QVEtKsjImjiQh8g+kN33WW5dy1YPvSeSVWs2F91GU3NrI
         z0/ZS1ob3QTHoR3F3++I36RmD6vSjAvH4Iya+EqB6DjOcFpIENOr7LJZfpsESqxfU+
         otIn17v/DpfVdSuyLevVubkqb8z15olvGex7E0g+8Lho/YJXbpATJnMQ1k3Uq0R0Rs
         RQUlLzqAcO9IqdLYLbbnnG5hZI1kHC4UQfgJX9//kYmENM1i5IfbNERmOIeqNaty3i
         +SaY445eH0uQxYnaI8Owj615zb8v26kDn7r5qByfPbIKvvqf2Cv4yJKiNDuVHqhkxr
         Ux/KuMBxsZorg==
Date:   Tue, 29 Jun 2021 18:07:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan.Sneddon@microchip.com
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tudor.Ambarus@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH] spi: atmel: Fix CS and initialization bug
Message-ID: <20210629170741.GF4613@sirena.org.uk>
References: <20210629162914.23286-1-dan.sneddon@microchip.com>
 <20210629164733.GE4613@sirena.org.uk>
 <c849eb7a-d019-b88e-583a-78e1eba7624c@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <c849eb7a-d019-b88e-583a-78e1eba7624c@microchip.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 05:01:57PM +0000, Dan.Sneddon@microchip.com wrote:
> On 6/29/21 9:47 AM, Mark Brown wrote:

>  >In what way does it do that?  I can't tell what the patch is supposed >=
to
>  >do.

> The SPI_MASTER_GPIO_SS flag has to be set so that the set_cs function=20
> gets called even when using gpio cs pins.

This all needs to be clear in the changelog.

>  >> -	enable =3D3D (!!(spi->mode & SPI_CS_HIGH) =3D3D=3D3D enable);
>  >> =3D20
>  >> -	if (enable) {
>  >> +	if ((enable && (spi->mode & SPI_CS_HIGH))
>  >> +			|| (!enable && !(spi->mode & SPI_CS_HIGH))) {

>  >This looks especially suspicious.

> It's due to the fact that the spi core tells set_cs if the cs should be=
=20
> high or low, not active or disabled.  This logic is to convert from=20
> high/low to active/disabled.

spi_set_cs() handles SPI_CS_HIGH...  this looks like a separate existing
driver bug, it should just be ignoring SPI_CS_HIGH if it's providing a
set_cs() operation and letting the core implement SPI_CS_HIGH for it.  I
only checked breifly but it looks like spi-atmel is trying to use the
core support for chipselect handling here.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDbU10ACgkQJNaLcl1U
h9ApfQf/UlWZOjyuLMxNZC/DdFCts0gN87q8qapmg8cYuOFDA+3LAnhouvdJ2nzX
TaUY7Rl7UUQ5WUX/PkTqfG3jHSZiY2pr3UsNr1aVf54qIxxF85VXvOkaWURzso3A
DVjJs1cQR/tQJ+VpWTofhQJniEMTKvk34ttKboxSh6wVpsy5Eo3VharE7YyyjBMr
0JKnvF2mwxnEvPwaeahreUCpoFZ/Akz9g67egUELEZCZEZIXdkkkcjevzGhsl6nU
rL/JmSauIcGfLQAGqu6Dyhi1AbvWOEntqXOidjvwOhRae2pDP5UvgRnt4Ro1hAdo
QD6njWzWK9x6lpiccEgTyGDy18IUEA==
=1igo
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
