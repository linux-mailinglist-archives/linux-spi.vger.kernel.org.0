Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9843406DE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 14:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCRN2q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 09:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRN20 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 09:28:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC9B64E05;
        Thu, 18 Mar 2021 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616074105;
        bh=pMEKBsZEBhyuThuHoXapktTCfemd4akWjrM8vqQdfR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4uFMd/zUCPnpqhRDmLK2XVyQbUpJ2W0g920A6QihGicQtS8aT7tqn37Vj1j0Hca7
         DvooNxyNIANwuQtXM2GRSa6ohU3mkuJpquyFVzKFdQoqtH2ImGJTnCqjEwDTqKbZH8
         2CgXDBK3rj1N8+98mKsqpwnz1dcLMc0uH4QpZyxshnWGRalmX9bLgwbmPltrsXNSDe
         7pwYbVIoGLlw533h31/ySykWDtPclvcXpOSw6Yo/XE5mRc6vtsN61D9Ueggdw83+Q4
         b71kYpxsxJOODNF3yLvE9mreh5oZpGAXGe8vJ9l4hB5tYWz1GjWPgMZT/wACYDPEZW
         V/+8TFAeLHFyg==
Date:   Thu, 18 Mar 2021 13:28:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, huangdaode@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V2] spi: Add HiSilicon SPI Controller Driver for Kunpeng
 SoCs
Message-ID: <20210318132821.GH5469@sirena.org.uk>
References: <1616061024-57818-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline
In-Reply-To: <1616061024-57818-1-git-send-email-f.fangjian@huawei.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 05:50:24PM +0800, Jay Fang wrote:

> Changes in v2:
> - Use a more specific name (Kunpeng SoCs) for this driver.

>  drivers/spi/spi-hisi.c | 505 +++++++++++++++++++++++++++++++++++++++++++++++++

> +config SPI_HISI
> +	tristate "HiSilicon SPI Controller for Kunpeng SoCs"

You've changed the display name for the driver but the Kconfig symbol
and filename are still very generic - can you update them as well
please?

Otherwise this looks good.

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTVXQACgkQJNaLcl1U
h9CTKwf+JYGktH7+p7zyA6fmaeTiI+Y5pu1SEfzQU8FF/Uh8I/nHow44N2DQ9fGu
LWJDFjFeENWas7Ew9rx93Mc/1u1dMF2AYfx7VlxZPKPYGbShLOthp1AZuNNE6eUA
s1So0/XCLtXIT8I2WNdKta5XX/KjTFyWXmWbW+NLvnNlLlylDJanH/Ihi8NaWzuP
7W87vIR2x/Q3avnHpVyuNgzeNcOqMAPO5GwTMki+RGm4Keyzgz949VM7ctmo1olQ
KiBInZqcYRlMHky5hwCAy+mQEYTS8GFaVIuoGL6D38eClrVd2uWFpPSVAX8bL5iJ
mY3IYxT6jTAx7/Y5M+nxcOi/V/rUvA==
=QtxL
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--
