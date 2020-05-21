Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9A1DD3FE
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgEURMH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 13:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgEURMG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 13:12:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A34120759;
        Thu, 21 May 2020 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590081125;
        bh=rW1OQJ9kONu33RS1Y6taAoQ5q7H4pXzbsFxYySuwZgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myff6NoU1FdibjpS3WF5Y85IY+LmkklloSH/qkrpaWjBSKVG4b8qpIqvsidd7/ZzI
         RqWd3Wl+vHw7kzXjvgJf82vtHMWw47GD3xks71H2jqosnKmmkVqjIQvxU1WFt+EgFd
         +JI8wLcogE3u7N8115mO9v/++F9BJTSuTaaYsgZA=
Date:   Thu, 21 May 2020 18:12:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Liang Jin J <liang.j.jin@ericsson.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        fancer.lancer@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH 1/2] spi: dw: add reset control
Message-ID: <20200521171203.GH4770@sirena.org.uk>
References: <20200521170359.20430-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <20200521170359.20430-1-dinguyen@kernel.org>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 12:03:58PM -0500, Dinh Nguyen wrote:
> Add mechanism to get the reset control and deassert it in order to bring
> the IP out of reset.
>=20
> Signed-off-by: Liang Jin J <liang.j.jin@ericsson.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Is the From: correct here?

Also adding everyone else who's got patches in flight for this driver
right now.

> ---
>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 384a3ab6dc2d..5c813e15ed89 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -20,6 +20,7 @@
>  #include <linux/acpi.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
> =20
>  #include "spi-dw.h"
> =20
> @@ -30,6 +31,7 @@ struct dw_spi_mmio {
>  	struct clk     *clk;
>  	struct clk     *pclk;
>  	void           *priv;
> +	struct reset_control	*rstc;
>  };
> =20
>  #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
> @@ -145,6 +147,10 @@ static int dw_spi_mmio_probe(struct platform_device =
*pdev)
>  	if (!dwsmmio)
>  		return -ENOMEM;
> =20
> +	dwsmmio->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, "spi");
> +	if (!IS_ERR(dwsmmio->rstc))
> +		reset_control_deassert(dwsmmio->rstc);
> +
>  	dws =3D &dwsmmio->dws;
> =20
>  	/* Get basic io resource and map it */

Should we also undo the reset in error paths from probe()?  It's not the
end of the world if we don't but...

> @@ -220,6 +226,9 @@ static int dw_spi_mmio_remove(struct platform_device =
*pdev)
>  	clk_disable_unprepare(dwsmmio->pclk);
>  	clk_disable_unprepare(dwsmmio->clk);
> =20
> +	if (dwsmmio->rstc)
> +		reset_control_assert(dwsmmio->rstc);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.17.1
>=20

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7GtmIACgkQJNaLcl1U
h9DzPgf/Uvo3Z9oWHIPYFsZ1POopyoGd7nWERKDslHHTTSHihsLMnihLMYIrYk6z
ejevinR2pex+bUZmdOMF5VBbPAfJm6PTWzAKkU38/7XNL0Bha9mK8Cj3v6N4iL9O
c1IsB4UnVZaK5KvubgePlcjtZKsjFDCQ2d4vMpTvRgDXP7tp8E74ISWxG9MEEXbr
6pUZd8+dYvUjELveiXY5K+CMVTWvGttE60ajPPvrgoPnwa2U0GUgTKQZ1oYc8fu2
D1FBua7Pb8C0QWFIXzSo/wyqFcFV9xRS/sSSpkbTb+oiCIYYXRqKTLiDqx/VUWSF
ksOdMjPeAGLthpQpPMlQIEQOeMMSHg==
=wEuG
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--
