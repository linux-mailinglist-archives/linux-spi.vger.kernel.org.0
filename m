Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29731265E6D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKLBK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 07:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKLBF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 07:01:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0198621D92;
        Fri, 11 Sep 2020 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599822064;
        bh=ehQxjP6qgh6QqxDf4qXY5xsJlT4gvmjuBu+idlfarq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkjtvdbifKEFGtAnw9fai0OvoX8AL+FGkq+qEICSWSED/mmauLOQYTtxTezhnq5gd
         WqzV6uYpGDFkbfOMyg7S/I3lxVxH7JQ/nNa/ye6ZNHCCRhc3tCIEEbdGncin/MxNh0
         GFddG/kmLoMaSVkllCEulCyKtkwSdnfbNNLeOklw=
Date:   Fri, 11 Sep 2020 12:00:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Subject: Re: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Message-ID: <20200911110018.GD4895@sirena.org.uk>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2020 at 01:58:06PM +0530, kuldip dwivedi wrote:

>  	/* find the resources - configuration register address space */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
> +#ifdef CONFIG_ACPI
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +#endif

This is buggy, it is equivalent to just removing the name based lookup
since we'll do the name based lookup then unconditionally overwrite the
results with an index based lookup.

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bWMEACgkQJNaLcl1U
h9AP3Qf9F5MBd+/yYgkOXPnvYDAXBr1i2AuuQMddO6Y8ZlWJ72PKuPXguf51tDc4
Q/6JW2iszIFliNxNRseaU6yee4gq2TaJiXLIw4TrM1KKbQu8k0RLYn8rBWBzP4vE
amVyHom7JC0haZNNR0xNRHxRv/7QJ/O24uG/7wDPKG6SMT5GuNABquh8AzSwDejM
rAEpxa+/flzZ8RaM/WvsIEo0C4okKla+MHjN5ozo3J6Y9/NnTYrzOy12Vy1qORuZ
7E6JsUEBEuWuy+IIFBhM3nbspLOxXwUBZZbo3uc6AEqpQwE+es/fOD7IlFCChDgv
9ndAqagEqrJBbrOGz0+rk+P0PS4Rfw==
=vHAM
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
