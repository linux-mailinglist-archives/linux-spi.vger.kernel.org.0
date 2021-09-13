Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D614089EC
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhIMLNz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 07:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238383AbhIMLNy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 07:13:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDFA660F46;
        Mon, 13 Sep 2021 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531559;
        bh=irBxJIzmiNaODmEF43yC4HXVnVYmzMRm6KYesasJvOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESj2sOHsdmhoBytephZ0saAgQxkz345/DM+OKLcMB6Cs/QO8YPmjZh1JgLcUyEc/d
         M5G8vxHuKKHxyjoRw8kC4snOCBn9JOZ5iy3F1LOySGLs03kocBts1UgD/ol6Q6VXX1
         dWACxLcPfI/+Xb6CPpNXNYL7iPxmsxBkjihKLZc3yGHFhsbGAwWEQaeMvPMzzyaEsE
         HUtvpPGkSggqd1te3OcniXBKGvzd/SOqQ8CsAdKC0jBrAXXFMb0PNt8lLAwa3d4Jx0
         vJTPMZg6fgsNRaf2yAN2Q1ezvWOcL60LPBfNLvazi4Yg0xN+p/GdIfIu5bS0hcUxbr
         Y7trh+PSaX4Vw==
Date:   Mon, 13 Sep 2021 12:12:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: fix "defined but not used" if
 !CONFIG_PM
Message-ID: <20210913111200.GC4283@sirena.org.uk>
References: <20210912212519.11797-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20210912212519.11797-1-kilobyte@angband.pl>
X-Cookie: Above all else -- sky.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 12, 2021 at 11:25:19PM +0200, Adam Borowski wrote:

> +#ifdef CONFIG_PM
>  static int tegra_slink_runtime_suspend(struct device *dev);
>  static int tegra_slink_runtime_resume(struct device *dev);
> +#endif

ifdefs are not an idiomatic fix, use __maybe_unused if you have to.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE/Mf8ACgkQJNaLcl1U
h9CPSgf/a2nQENkOP9ZoeKFY8Jf4kU+EegzYYSHAmvq28sq4bKi43AZVprthoUnD
7AQpVc+/2RP3kYLDGRujc0aW2P84lmpyJ01HrXidt/CTx0uWjzpNvo/+VMbYiKsq
5tVpcpi3mNMF67IrbqWlEovuVAR99B7476Q0eA3eH/q6goahR63j+u9vGdZ0se02
twbjDgdBIva3NbczBm+HD7FW0ifadKo/eOX5i6fqxvcP9oNCaukA3wdaEcqy3t1Y
W8J8AFW2jaV8op2BK+1NsGxe6B0wv4TuC5vdsPm4/h7yx2n5UFg73E4Qbvvn9FjY
ioyVWY5cxPwk5IuPMZBrCnYD3P3W3A==
=XIqu
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
