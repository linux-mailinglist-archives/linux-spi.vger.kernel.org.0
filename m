Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0558273EC5
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIVJpb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 05:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIVJpa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 05:45:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BDF207C3;
        Tue, 22 Sep 2020 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600767930;
        bh=cVNQbW1ygH4KoCmA09xSKYc/MVPqvNPF99YkUsElu9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReT7DSJPmF+fcQ1LVckcdx0oVHffW7k7/YHDko/tYY04/K3BTwFxFggsfGhO2XqTD
         A/eqySS53vnsi4Fn8/O5din/wgk+y3n/QUhSZ2TcMZSFFCO/RgI7LJm0YGLDGz3a5v
         JZXAqVZPGIi59GFYjWME1135hytCr9igarWGD5yw=
Date:   Tue, 22 Sep 2020 10:44:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de
Subject: Re: [PATCH 1/6] spi: fsl-dspi: Use devm_spi_register_controller()
Message-ID: <20200922094437.GL4792@sirena.org.uk>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
 <20200922093228.24917-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ms5iOKSBOB9YS8zC"
Content-Disposition: inline
In-Reply-To: <20200922093228.24917-2-s.hauer@pengutronix.de>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Ms5iOKSBOB9YS8zC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 11:32:23AM +0200, Sascha Hauer wrote:

> @@ -1440,9 +1440,6 @@ static int dspi_remove(struct platform_device *pdev)
>  	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
>  	struct fsl_dspi *dspi =3D spi_controller_get_devdata(ctlr);
> =20
> -	/* Disconnect from the SPI framework */
> -	spi_unregister_controller(dspi->ctlr);
> -
>  	/* Disable RX and TX */
>  	regmap_update_bits(dspi->regmap, SPI_MCR,
>  			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,

Is this fix safe - what happens if we start another transaction between
disabling RX/TX and the unregistration taking effect?  Similar concerns
apply to some of the other patches.

--Ms5iOKSBOB9YS8zC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9px4QACgkQJNaLcl1U
h9DEFwf+JQLOy3UHIe5GuEgxmBZ+eM/d5hken8RdhbZ7/EdQwNdkoPbXqrbn6da7
zVCGiqZIYKb5Gtp3dbC52rOLGawetghk7k1oO0+HpXUpog1ww8TR7Z4z78ucvK3B
/DRC9KWXGKXsr9lWFdL8NuBzwEHwuaOvBjUENhX/e7qqrFeIL2CwhotYXyhu84Zo
Zhg9NZpQdqDFPUmoEbRjGIiQAdzUWOHoqKN79+9xDwBeherh2E7/+PbXeG0B4iJ/
pNOd2b6zlQIVGGztvh8XTypUPxH7XoKWtzU2Qo0vEf1AB7+WFjZ+q8UEjQp9s/1w
g7+2gThl44XJZ4GBqth55R0sEuCH0A==
=ILM8
-----END PGP SIGNATURE-----

--Ms5iOKSBOB9YS8zC--
