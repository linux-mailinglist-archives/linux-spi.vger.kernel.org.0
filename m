Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A145A5BF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 15:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhKWOjQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 09:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhKWOjP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 09:39:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADAD360FA0;
        Tue, 23 Nov 2021 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637678167;
        bh=m4P9JkoC3K8B57wmT+eoRn28ephU3YfVJRGyLvXZ/Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cujsitl0Rc5kYpwPjer8WXdeWVU6Nc2nahAozwPS47/0iQuT7jd9ooUU3553IsNgV
         Ck1t0SQn9Z4ShGHYj9iIouhAveug+HKcAanaNwovgVyLTxPavOU46jyj1V74gV5U0t
         nM0yye/6W6LyzzFqvP6II83xU4kSwDPST+SHx6v1Aj8TO0BMJznx19pb6ZSqexBIfF
         k4W13fpIwxdFhGKQ4uoB/dLW0vGsxIrWbap1v3c8whLfx+PbrwX3euXuTbnho8IKlt
         PHFbWO6Dvmx38l008q5tgC2sFM5oLdKEkpHY7soakjkX502qi/9iQ462bxaK28zmFB
         hBTufiO5td3PQ==
Date:   Tue, 23 Nov 2021 14:36:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v3 0/2] Add SPI control driver for Sunplus SP7021 SoC
Message-ID: <YZz8UuqtekI103i4@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0xFm47TvXhXeY2/U"
Content-Disposition: inline
In-Reply-To: <cover.1637547799.git.lh.kuo@sunplus.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0xFm47TvXhXeY2/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 22, 2021 at 10:33:31AM +0800, LH.Kuo wrote:
> This is a patch series for SPI driver for Sunplus SP7021 SoC.
>=20
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.

The structure of the driver now looks good, but there are some smaller
issues remaining - I don't think I saw anything that Andy and Lukas
didn't already raise.

--0xFm47TvXhXeY2/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGc/FEACgkQJNaLcl1U
h9DyzQf9F128u+NblHPkaGwhrC+dTZxz5lebMLdzTD6sPpXyO1wJozTMdsEs1xc1
7nQ3Mvbp9BVpGg5KmOfg9c3Ofol2zvTscDqaPoMgJcjaveirTVKlJyRba8pfpHrU
9fTF+5romUKv9uhCCzGNj10QeOtesyReF7DUCl51izswBHusBIAbvmcBj7oKsvKd
sj+d429SWvIFGlj/ZcP+mmvrtrBbm8bWKyqM7Sf7sqesLgZ4c4lQKhhWyAcIObBJ
SScxOL+uStzOU4GYdauSIoIpvygaBYlyFYDYmzGG8yjOlKS9bXMEsIMWTNAdgUOT
DINKUmZY1f1ZCA0P71mtbuvEvJ3mvw==
=XdF0
-----END PGP SIGNATURE-----

--0xFm47TvXhXeY2/U--
