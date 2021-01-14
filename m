Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4942F60AE
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhANMBN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 07:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhANMBM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 07:01:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B40E23A50;
        Thu, 14 Jan 2021 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610625632;
        bh=INY4CE7CQQYCVvJ4IYFg/6ov+XHogEimL9aQ46Ij89A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCh3t3cG7vJakYHnKh2vXr9Pa1B4Z0VarzqUlXT7j2G0IHFN+F5Y9sVKUrrnAS6f8
         DhlAGKQTJGBF2uHENRH4CvKxCLr/CQCRAgBBYAKag823xi6TXXcFaFkhJGOfGqRBgY
         RQRCl65zhaNc0aKdANkzlyhiwkePoxbmotXyhc4bGaHezy9NRkJSuTyWJsvGvpueq7
         rGNQbDGpkirQOxXkFj+kGJPjDq8s+sxvflsn+vaeYJYu2As95vzO1fmEqAkQoDFUbX
         U40RKLMQVpaEa7FVI+gzwdYD5vVOD8/VjRrNDF34BITy5kjlADB3xNgWDq4to9ZBT7
         2O2dqPiLbHFXQ==
Date:   Thu, 14 Jan 2021 11:59:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04
 ("spi: fix client driver breakages when using GPIO descriptors")
Message-ID: <20210114115958.GB4854@sirena.org.uk>
References: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
 <20210113123345.GD4641@sirena.org.uk>
 <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 12:27:42PM +0100, Christophe Leroy wrote:

> Today I have in the DTS the CS GPIOs declared as ACTIVE_LOW.

> If I declare them as ACTIVE_HIGH instead, then I also have to set
> spi-cs-high property, otherwise of_gpio_flags_quirks() is not happy and
> forces the GPIO ACTIVE LOW.

> When I set spi-cs-high property, it sets the SPI_CS_HIGH bit in spi->mode.

OK, so it sounds like you want SPI_CS_HIGH and that is being set
correctly?

> In fsl_spi_chipselect(), we have
>=20
> 	bool pol =3D spi->mode & SPI_CS_HIGH
>=20
> Then
> 	pdata->cs_control(spi, pol);

> So changing the board config is compensated by the above, and at the end =
it still doesn't work.

This is a driver bug, the driver set_cs() operation should not be
modifying the value it is told to set.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAMj0ACgkQJNaLcl1U
h9D6Bwf+JW4953RUClZPcFMDyoQMw5ksSpnT2TroqZ+JObAHxKT85Ale61GgiGrG
P8kiuahjvzc1lwsafI5fa63OKy+tRJ+5eqxKpQRAvsOzaT642r8WE1rUJSNtGDLI
56v4ikNB3DquUiJLujiQsry1ab5+du7BVFiLMlD5DgGuL+By5lEXjnFbyifJSTbH
UTti5kDJaI4VTOXIqbtCvfL8CWPmaP+EdKL1Hi/llLFVrZEefuf7qJMn+defX+cw
2tXhtzLECfYIOf8qR34VanbwoGQhhXCefIBa0OQN2gRpiP5oYaZjhVigXWhDSPUZ
PS5J2+pqej3DON95T4rCm9lKGqunWA==
=aods
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
