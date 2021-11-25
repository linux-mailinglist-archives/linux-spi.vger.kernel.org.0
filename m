Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACD45DAA1
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 14:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355107AbhKYNEY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 08:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355041AbhKYNCX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Nov 2021 08:02:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64DE460FDA;
        Thu, 25 Nov 2021 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637845152;
        bh=GN/QemKl8WQxik3fKssLCxp8R+dmbYdNVBK2d22vV2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcYAoxrN8GVfqamOvj0rjliGSGgCuNer5RzuuejV24NUSMwORht3ATviviJawXkek
         zmiI6RzjQzKv2cl+01T3tOlVbBluPRbQsfN4xd94hXjfrT7o+hHvpQVK8/obLNVT7l
         GKvX71YzOy8NaDXH7pVHQypikvNPsMgO4a+6PP3y4gUj5tIm7tL2WPp48BiqEdDuP5
         uhBtUAsJGiH/WHPFAWqS+JO3+OHhUPGrb4TdypmsthTqDzk716wMjloLfqEs/wbT7z
         HBz+/GM1b7KAWNz9yMSxrPHe37S3aQe2md26sZ21YR+FL9DKNDlZGx0t/l0beHpioL
         bC4uq5awQZWqg==
Date:   Thu, 25 Nov 2021 12:59:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
Message-ID: <YZ+ImY1LrvB5a5iF@sirena.org.uk>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wYbJFy+iqilKIVSO"
Content-Disposition: inline
In-Reply-To: <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
X-Cookie: This bag is recyclable.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wYbJFy+iqilKIVSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 25, 2021 at 03:25:52PM +0530, Krishna Yarlagadda wrote:

> +#ifdef CONFIG_ACPI
> +	if (ACPI_FAILURE(acpi_evaluate_object(ACPI_HANDLE(tqspi->dev),
> +					      "_RST", NULL, NULL)))
> +		dev_err(tqspi->dev, "failed to reset device\n");
> +#endif

What happens when this runs on a DT system?

--wYbJFy+iqilKIVSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGfiJgACgkQJNaLcl1U
h9CdZgf/Wl+0SliPZI5T7h/w5woXgBdw9MoIfPZD5A9VyGgItquHqW7CSfp0an6n
7HwjhmkYj2fgk9prgwY0jOBaCN2WQMeqAPGPgxzHjsuAazdleeFeQI/lGiPazrEI
tJ5/2zWKHy5LJAGglYVaUYgYjiFoTq4vnPp/ddM95It83LRSSVUnL6beH9X9r4DZ
p4B+bI7EPoMgqWyA0X4zoKZi6mrz1HKJ8wSx+SGesVHkRfpJmIbSjn/csOr414Zb
1LLh0hsWEFx/qkJ8rUODpkKo9bcjEP2I4eUkjfdbeg3YnuQglPnLo5jEirNaW40w
SkN0K0hs2Xly8QOiPhmC2+haguIBYg==
=jjch
-----END PGP SIGNATURE-----

--wYbJFy+iqilKIVSO--
