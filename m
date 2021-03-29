Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DB634D463
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2P7T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 11:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhC2P6y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4717B6148E;
        Mon, 29 Mar 2021 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617033533;
        bh=NnjETCPQpSIHF+fPiignvyEBk3xGcXLngA81Rv7A/3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpwP2d991M4o1SHyIp0bfBts73Vu1kWY5jw1JFxHh2cwKsDBbhJtodPxCYUO0gIAG
         iEBQcUphAXrNgM2jcCMB5vcMwxO46gd7BC6muPaG5EG3T2rYHMYwOMOWdvL1jcS+Rg
         IWOXvyJpjBtl1jyCSjl2vr0ZNIEK2QzFjS4bLY46PusaL+sTTDtw5b+Ljjy9UGGwCO
         sEY13lYr3Lpv8wXZK9tk1gYuLNreehI546NKSoba6Ur452JlliE6ILPDFCRDVZQ85H
         5DUFu2zueiaXUdzWx8Ca9HKvFTO3pPGzDP4NHQiBIJxpvj4hvzAjBTHg2O4Mm0oQVf
         3F2vo+2R90JXA==
Date:   Mon, 29 Mar 2021 16:58:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        fancer.lancer@gmail.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
Message-ID: <20210329155843.GD5166@sirena.org.uk>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-4-brad@pensando.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-4-brad@pensando.io>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 28, 2021 at 06:59:28PM -0700, Brad Larson wrote:

> @@ -56,7 +56,7 @@ struct dw_spi_mscc {
>  /*
>   * The Designware SPI controller (referred to as master in the documenta=
tion)
>   * automatically deasserts chip select when the tx fifo is empty. The ch=
ip
> - * selects then needs to be either driven as GPIOs or, for the first 4 u=
sing the
> + * selects then needs to be either driven as GPIOs or, for the first 4 u=
sing
>   * the SPI boot controller registers. the final chip select is an OR gate
>   * between the Designware SPI controller and the SPI boot controller.
>   */

This is an unrelated fix, please send as a separate patch as covered in
submitting-patches.rst.

> @@ -237,6 +237,31 @@ static int dw_spi_canaan_k210_init(struct platform_d=
evice *pdev,
>  	return 0;
>  }
> =20
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws =3D spi_master_get_devdata(spi->master);
> +
> +	if (!enable) {
> +		/*
> +		 * Using a GPIO-based chip-select, the DW SPI
> +		 * controller still needs its own CS bit selected
> +		 * to start the serial engine.  On Elba the specific
> +		 * CS doesn't matter to start the serial engine,
> +		 * so using CS0.
> +		 */

Why does this comment only apply to one branch of the conditional?

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBh+TIACgkQJNaLcl1U
h9AT8Af/XdN+n+l5mAqCUJXpWq/mDrkEBdZmfQE2koLvAsnVW0/Z9eaodG0TkxrP
bTvF8W1AUheE0TQ/szrur71ck/fldoZX2xnc6OKhwO18e5rr1sVnoqCIIyqlvdJ6
HPeGsJ9XWXWx/NZIV7Z3XaQxFV6c/L8ySwYbAy8iAkcr/WUYVThji4DddHgtSYkC
0WIxxF5HvRjz9TcGCvf7LdeX3k9kqgT2esVALZ+HMbRkB0iMQAkL53hziP/xVl45
5kyX5G+2mUE2bpxLX3Y9akKSvk5lj2fH2tBbLTjiFDiLVq4Kg8kMGvGscnQwqRL6
kDe1GVPDkT7ZxqfuUX7w1OAD1SZ5Og==
=vwts
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
