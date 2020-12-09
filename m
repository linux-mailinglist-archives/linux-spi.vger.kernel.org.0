Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8D2D4BC0
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbgLIU0r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387565AbgLIU0j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 15:26:39 -0500
Date:   Wed, 9 Dec 2020 20:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607545559;
        bh=ZYSNXG5AQFg39oeP0clvgAIzYfnAL0H/fCfkFsC6C5I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+HezLalmGM6DJvKzVD0LVCgiUr29JwjXdLCvpJWctM09mQz2kgoQGVDKeDsEHqgD
         tgQhmZxga1JF8oHzTcilSkLl5cm6JIMRcjLxhQ25tCZlnnL3+n3XDbRi8mRgduIuP8
         gdeRwbVTWa/KuGy3MGpk6/VkNgrJMA7H4iHyK+8fAniO+8u9N8MKLeVehUyXDhyOLD
         alCDUSz2h7erxIDnAYvygRLydoVSF9kGtM2jDKgRU5Q6yf9L0F0q5sKXf6Xz8dgQ5L
         71BCNRlUekGQZ1v9xPGRsAMGYdNaySMF/82p0MdMTVD1y92440K82K81BwIUVMwvyP
         N77cAqwQa856g==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201209202552.GE4790@sirena.org.uk>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <20201209201535.32g4kwpzo45jiqr3@mobilestation>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2020 at 11:15:35PM +0300, Serge Semin wrote:
> On Wed, Dec 09, 2020 at 07:54:20PM +0000, Mark Brown wrote:

> > Right, in general we aim to do this sort of fixup on the transfers
> > and messages rather than the devices, I guess we might be missing
> > validation in some of the flash acceleration paths or was this an issue
> > seen through inspection?

> In case of DW SPI driver we just make sure the SPI-client device
> speed set in the max_speed_hz doesn't exceed the controller SPI-bus
> clock frequency and clamp it if it does. So the driver is safe in that
> matter.

Ideally the driver wouldn't have to check though (no harm in doing so of
course).

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/RMtAACgkQJNaLcl1U
h9B+zgf+IUZp8QINZ2CvCvfDgmJFD1aDYhm7lg0t0O3vHkaBCYjbSNR3RZ4Y1quv
2QeNRn57egUWrfq4GMFpVFX91SODxecTyetOmHgoOsWvq7/WoU1ZavqnHfnJHnbn
8AhPGyXpsqxR73UyeCesAP4A6uaWBczRkKiJrS25A4+ChoPTtTKEb2mnHjwU+k39
/ZcUxahCZpLk3j6xkDf6MGgq5SGheW2vYz53WsS4TXpviOBY5KHPmMzl9ZHmJkLG
eTmV2whvurV6jkms4ekrMeNJJiKdM+0EZ5qZNr2JcTOvWJ92XNahzg1qi+Y57wFV
R+veGS7JE5fYG0EApaMeWHPwUteS/Q==
=hGlK
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
