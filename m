Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0637A584
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEKLPR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 07:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhEKLPQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 07:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F33D26162B;
        Tue, 11 May 2021 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620731650;
        bh=2BDtz4VLzK2pxVtJLxrKEWcEDyk1Rm5cs5IGjo1f+jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psdFOoOgSnmieSVMlCCsG4B1GATrzRdeeerxvXXQRFv60cryGtuHJkpIwbjxkzkyi
         E1DZzq5yZazlDk2f5jUEq+75oxEQQyscfJy8wcr/49861TIluVyydpcH/TklAzVFXM
         9g691KoPE6/TiaFT4jLS5aR2P0hNMRARAi7VFSNIKY/lvFY75JmNf+L1nG7r8sBMjF
         Be40qNw6JxQZaGZ3/tdaisMVDVRXCTg0uBguYCjAaO+cV6VCJWMSJwK5Wtz6gpLX/c
         bPSwUbpRfgLVMV9CKFEpK1t7G6Wz/adcjBRLaVoJlr0vvXUDBOoWSCu1wCdB14BMlz
         BwQQk1nW5P/6w==
Date:   Tue, 11 May 2021 12:13:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Xin Hao <xhao@linux.alibaba.com>
Subject: Re: [PATCH v1 1/1] spi: Assume GPIO CS active high in ACPI case
Message-ID: <20210511111330.GH4496@sirena.org.uk>
References: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 10, 2021 at 05:10:22PM +0300, Andy Shevchenko wrote:

> +			bool value = has_acpi_companion(&spi->dev) ? !enable : activate;

Please write normal conditional statements to improve legibility.

>  			if (spi->cs_gpiod)
> -				/* polarity handled by gpiolib */
> -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> +				/* Polarity handled by GPIO library */
> +				gpiod_set_value_cansleep(spi->cs_gpiod, value);
>  			else
>  				/*
> -				 * invert the enable line, as active low is
> +				 * Invert the enable line, as active low is
>  				 * default for SPI.

The change would be clearer with the documentation formatting changes
split out from the rest of it.

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCaZtkACgkQJNaLcl1U
h9DKKwf9Hbn3hZ1NYkTyuwgwd/k2/ixjylBMeZAU9id53GP+c4yTF+pvLm1lCZVw
Q61Wq5JdkEWR6fb0UHaNUpXWzDS18oV0kUrSnzr14z7dVvxomDNMQ9vA+7Q4Bysl
feLOyEEu2ursmp4k6m7AxULCsk7SmrjDHp77kEKnKAVFCOTlfzDBv4gQ8UpuPS7f
rbiLXjwKZU1Nkh3Zo+VI6kr4CB/Eq8YWTPK8+p+IGRObLn1JOqhrqmtGmYVuDtzb
R1kHccbSmrYvZwl8leMGTSOTW2InG2Ixzo5zFli79/yZ9z/Ng+f7EftGcnhLat5S
xYb/mqGALnJmxTF2ojObBu61tw76Mw==
=7yhv
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
