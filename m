Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2727CFF9
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgI2Nxd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 09:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2Nxd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:53:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E017C207C4;
        Tue, 29 Sep 2020 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387612;
        bh=XMlJFSSuGLwN5k1WwBefP32bozx8G9mTS3B5NnSlArI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/bz7GDKIVERvmjP07DfF7CO+293Gz1UAt+rBmWu17V2qzF+0qTFiNpmREcXcVWVw
         IQanQVHjqxoBSg05IsapueT7Tcjrf+WJjD9qjUQCnc3Mse8jYI4A1x14LtQE2KgKeO
         /vlGWgnaiSN+1GrlOak46O+mPgTsHwU7ippWMze0=
Date:   Tue, 29 Sep 2020 14:52:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/30] spi: dw: Add DWC SSI capability
Message-ID: <20200929135233.GG4799@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-12-Sergey.Semin@baikalelectronics.ru>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2020 at 02:28:55PM +0300, Serge Semin wrote:

> -	/*
> -	 * SPI mode (SCPOL|SCPH)
> -	 * CTRLR0[ 8] Serial Clock Phase
> -	 * CTRLR0[ 9] Serial Clock Polarity
> -	 */
> -	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
> -	cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;

> +		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
> +		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
> +		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;

The new code seems less well commented than the old code here.

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zPCAACgkQJNaLcl1U
h9DKGgf8Dusx5FsYcQ5npzfLKiRdTmIprfoh+fIEbrMCruynt16OBQS/sX6tmoGe
SRj8t6pzB+q7LJ49Ct9MG0mDcCfTSXRp2B+bXCT8cOVmGR64fdYYprqdJw0P2iRL
rAm6idVXHqjHOM1PnJNlInPIEIQwFqqMXQ9tyn9dgOHDK80pHbZPtXxx/ouBRYi9
YldOhxizTwenaE0koaxF4blxjPOs2f10QRlKji9zCMqMTOInFjtffJ7YDl56MMDI
AXHvn8wTj0rDOkNXgmEN5kJrTTVG0ocZrJXTm5QLoGQD4eeAcrTuWhOg3+pRY8o7
p0Izj1+Tyj0LVHTejlwAq239vgPhMw==
=r+YB
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
