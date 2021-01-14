Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262D2F61E5
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbhANNYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 08:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbhANNYO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 08:24:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8F5923A05;
        Thu, 14 Jan 2021 13:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610630612;
        bh=N4MLOcaBrg+ObtW8saTWFTIwry4CM2IZkHEMOlfdUBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+NvHe0OMhIhxGZRoLH3VviN3uYMqqteXIlzhRhOHJnEZvYSuZ7Y6encH1ZUWYMAD
         coxOX1wuKEmfzBiY/Z0aNGdPIr0exq130aoFm3FTBd81APc8Yrs1Y2am7rXFKZ7CNr
         LfQtavxrV7gKDpAxYI+oOXmctLAaw6Vv2hPhXIGr1gH+Kv2RcdOOmgeRvXKkzL/u8V
         iNjhcLSF8LObyOL8P62i0/HbGqhBH6Vt58eRxfU7lhh0hh5kFhVLAbWc23qwthKXks
         2R4f3Kr14WAbHRMzV8hcGKrPO/IqcTHX7EbmYG1OjlplbYlsXNVzli5yMRItxsMgGd
         3HlSoc7iXPkkw==
Date:   Thu, 14 Jan 2021 13:22:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04
 ("spi: fix client driver breakages when using GPIO descriptors")
Message-ID: <20210114132258.GD4854@sirena.org.uk>
References: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
 <20210113123345.GD4641@sirena.org.uk>
 <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
 <20210114115958.GB4854@sirena.org.uk>
 <006d1594-8eec-3aad-1651-919071e89f3b@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <006d1594-8eec-3aad-1651-919071e89f3b@csgroup.eu>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 01:33:50PM +0100, Christophe Leroy wrote:
> Le 14/01/2021 =E0 12:59, Mark Brown a =E9crit=A0:
> > On Thu, Jan 14, 2021 at 12:27:42PM +0100, Christophe Leroy wrote:

> > > Today I have in the DTS the CS GPIOs declared as ACTIVE_LOW.

> > > If I declare them as ACTIVE_HIGH instead, then I also have to set
> > > spi-cs-high property, otherwise of_gpio_flags_quirks() is not happy a=
nd
> > > forces the GPIO ACTIVE LOW.

> > > When I set spi-cs-high property, it sets the SPI_CS_HIGH bit in spi->=
mode.

> > OK, so it sounds like you want SPI_CS_HIGH and that is being set
> > correctly?

> > > In fsl_spi_chipselect(), we have
> > >=20
> > > 	bool pol =3D spi->mode & SPI_CS_HIGH
> > >=20
> > > Then
> > > 	pdata->cs_control(spi, pol);

> > > So changing the board config is compensated by the above, and at the =
end it still doesn't work.

> > This is a driver bug, the driver set_cs() operation should not be
> > modifying the value it is told to set.

> A driver bug ? Or maybe a change forgotten in commit  766c6b63aa04 ("spi:
> fix client driver breakages when using GPIO descriptors") ?

The expectation that the driver will be using the chip select exactly as
passed in and not attempting to implement SPI_CS_HIGH itself when it has
set_cs() has been there for a considerable time now, that's not new with
the cleanup.  Drivers should only be paying attention to SPI_CS_HIGH in
cases where the hardware controls the chip select autonomously and so
set_cs() can't be provided.

> I'm almost sure it was not a bug, it is in line which what is said in
> the comment removed by the above mentionned commit.

Please take a look at the list archive discussions around this - there's
been a lot of confusion with GPIO descriptors in particular due to there
being multiple places where you can set the inversion.  Note that the
situation you describe above is that you end up with all the various
places other than your driver agreeing that the chip select is active
high as it (AFAICT from what you're saying) actually is. =20

For GPIO chipselects you should really fix the driver to just hand the
GPIO off to the core rather than trying to implement this itself, that
will avoid driver specific differences like this.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAARbEACgkQJNaLcl1U
h9APTgf/aLwStecUVq1BEe96Q18/NhiIwRQPg/47gbkg+FKp4HlYPvBaXHWBArpP
1fUIEScYwM6Fw4n+mrL3+fxvQUaYacXxD37oQcBV6R+WlTPPSLofypBXy44k45vj
oMB3QWLUcLIC+K7AFAAbo9RA6QnSRT719RYo9NHF4qzcgGfweVckj7AkbIkcAbqN
Vte+RnwqZkY3iLTviZyfCMdIGtDy3+9pNHO9La9/LaLULemKMcMf2sdgHH2j7Ult
SnihJ2d39fxoNHSw+BgurYZ9APuiiHLL7Hq8sYbCkAZvdpFHR2TD8uovZeMbXZrs
42Uykbf8X9XIV9EtnwEkNN5ulcQnKw==
=oOhx
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
