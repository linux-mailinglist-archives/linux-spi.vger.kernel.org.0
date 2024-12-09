Return-Path: <linux-spi+bounces-5973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504329E95C6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 14:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C17E28205B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5A1E9B3D;
	Mon,  9 Dec 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8i6vWzz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F91E9B36;
	Mon,  9 Dec 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749438; cv=none; b=hDuonbaAQynbfV6dtuahqTcC4qIS3TyhqSWBHyJxcCsy2z+Zj80GKTv7FbQ8CXn4vdPlbrW8Z/r9+mpXEYbcAdlyhBG3n0g5qZQ2C2MXO36mjp3iJIQju2eLzNxQd03lKTk59xLI7WArVu3ZHs8hyZu6JfCN9sxVK6wvi16SU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749438; c=relaxed/simple;
	bh=m8g6oPwlnWjX3Qgb8hSOrPq/q1rrb2RT/SnscVgYYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYAmg5gRWYol9Uz2yqB5sdNztMeEBfIhCuwuRRauEXoKWU9rxQiL1Lk9+dsIeFKeL5XqdIYo3/0y7VmxSHtBDafaFODSXAZNUUHM8VZAFSkPiAo8JezFUK8CZDqYRBXWqvOUZ1XAWskp3TEg6vw4DkyRyKXxfEauCHdXlyqGhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8i6vWzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B12C4CEDE;
	Mon,  9 Dec 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749437;
	bh=m8g6oPwlnWjX3Qgb8hSOrPq/q1rrb2RT/SnscVgYYHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8i6vWzzgB2kDFHLJZNYdBBsA+6R+iOWZ8ZmF8bO7Q5lAJZ6Pwzwd52yJLkM+7ruv
	 KH7wvoIW+FTDkSRfuRuuqmr4iZp9cdbWIk77u1FymBXuCMtHgRd47xKP8poID4Kb4E
	 199+PjV9puroMSqntp4zed1cqAKsmkP1BCNS7f/0OVLm9v+82KgTc+jb9CO0xcBkIm
	 3qir6CO71O/SOOv0pW3c5EDfHpX20ygFER4jCPr6BEB6giCAeG5+JCG6C4StVAr1z9
	 9BIuRET6PcWXYi3jeEMDBIkkg1b/ggWHfrZx9jYbeIrkdU6TwgrnpzjduJHKCXrRGC
	 7HnMta2bkMPuQ==
Date: Mon, 9 Dec 2024 13:03:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: michal.simek@amd.com, linus.walleij@linaro.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] spi: zynq-qspi: Add check for clk_enable()
Message-ID: <9de6025d-2173-4b50-aa55-65a6a89d995b@sirena.org.uk>
References: <20241207013258.3615645-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1pEAN7gwTXLPOjp4"
Content-Disposition: inline
In-Reply-To: <20241207013258.3615645-1-zmw12306@gmail.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--1pEAN7gwTXLPOjp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2024 at 08:32:58PM -0500, Mingwei Zheng wrote:

> -	clk_enable(qspi->refclk);
> -	clk_enable(qspi->pclk);
> +	ret = clk_enable(qspi->refclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(qspi->pclk);
> +	if (ret)
> +		return ret;

The second check leaks the first enable.

--1pEAN7gwTXLPOjp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW6rgACgkQJNaLcl1U
h9A7Zwf9El8nVQB+8Knp7drMGS6apQGQA2eINQS1cHSx0oI03DWoPCPc2uR2MgQ5
xCcgGaOvdAWu3e1fwIaTx7AF/NrCXcgudVMIm7vLowaWk8Yu62aUSMfSWSE2yyqc
nWaSgoJR66BXbwxXPuV6epSXr7Ie847GnoRj8TiHtaXASZNHBD6hm7fqXd93RRe/
aMMRASYMgnHrQJ3Sxqv2B9pDCApVDGR3nOUJaim80VImz5YXu+SJ/hoLQpueBISz
nBm4FNc4hcz3t9kSsQtrUc6eFEkFshaiE2nTtTnO6qKjcgZxA7bF8SJ2MzKk6Ltz
Y1yQlIOyYs9/zYmzahE2bZTQhEQ9Ug==
=vgFH
-----END PGP SIGNATURE-----

--1pEAN7gwTXLPOjp4--

