Return-Path: <linux-spi+bounces-5972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08A9E95D2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0971880137
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F761E9B09;
	Mon,  9 Dec 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjihT74r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB251E9B02;
	Mon,  9 Dec 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749413; cv=none; b=Y6ySRP+bKqST3U9/zGatzMIKO6FujZf1ILpiZn2oPFOWBdecmAn0wIIFTNtsFczXX3OuQvhpY6GSeGsBGUIByVm6za3QEsxkWlhRnOJLZxDWNcJJrwZv8aceD9Zm8pfY+Of/BEataPpc5cJmsb5a1esNTNFHp75le07FzWT1lL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749413; c=relaxed/simple;
	bh=GOus2+hZs7XtN9YP0qY5o/FcJXf4t5wbIasocZMxuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj86KB8Ewg2rlpyp6TGU6jAli436hgXsijPiH4s/mOs1YvMz5ZBtHlRzJhHhNcNgLabsPMARJF3QLzhfPaF7Sw/aJGdEDxuUMOl2kF7qj3GZx0Bb6TW0jkFWz1OPX0R01JvTDZmcmBjC7FxweyqypcTJdztCmJlg6tJ9JLCX1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjihT74r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A552C4CED1;
	Mon,  9 Dec 2024 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749412;
	bh=GOus2+hZs7XtN9YP0qY5o/FcJXf4t5wbIasocZMxuaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjihT74rmbNEnbG0iPBC1XNWour06JbfXDWnWY9OZ49miIg6eDFqTI6b0AUqz4ToW
	 hhnpMHbOVEMCSwT2uOEfVkfaQkKBm+XWBJZ6xnYF73IwCYkeSQi4+ocbQ6lOtY0und
	 uIQNH313bQRpAN2yMAShNx8VFkBlQckJUuzbWOgGVhHVULjdT7exDW00BE69m+ii41
	 I4YotO7viSF0NVb7FwWMSYSafD4V/MFB16+7Zdz6xHuLMW9tofd7ND5XhxiQ2lYVSZ
	 vt0qqdjJYR0dtkxvYbvKgg46356tnL+hYqO6NwLBHTEeAP3a/Th31GEdFuq+UMPBmW
	 qTHtbylFOMSyQ==
Date: Mon, 9 Dec 2024 13:03:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: michal.simek@amd.com, linus.walleij@linaro.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] spi: zynq-qspi: Add check for clk_enable()
Message-ID: <8332ff0f-5727-4a6c-b40b-f6da7fd1c0f6@sirena.org.uk>
References: <20241207014727.3674388-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gb01w0EsSRULSS0k"
Content-Disposition: inline
In-Reply-To: <20241207014727.3674388-1-zmw12306@gmail.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--gb01w0EsSRULSS0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2024 at 08:47:27PM -0500, Mingwei Zheng wrote:

> -	clk_enable(qspi->refclk);
> -	clk_enable(qspi->pclk);
> +	ret = clk_enable(qspi->refclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(qspi->pclk);
> +	if (ret)
> +		return ret;

This second check leaks the first enable that was done.

--gb01w0EsSRULSS0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW6p8ACgkQJNaLcl1U
h9CVTQf+ILoXRvv95joxTJinGaz8opCOy0BMXfL5lSrk1SIDsmArV0bwjDw+TQc4
BpjRhgwuu8QrUHUQuHc7UEq8AjFeuUvzTee6RIFoy89LPvYXBbat3rWkSzRvx+3V
DXt1SEjxRcyvY/KMgvqtJEqw11vEbaPYLlMdqVjTjairhDOXK/oXjyuce1UaOZcD
O1KOB9UXE2+TZp6892afhbkmnwvH0ylskpopHPeK+0dqfvYV+cPnVajIEZyH4y88
amEYaG9hOfecLDUIDg6dZwgj1rE4HaNKYeGiLp/KHeT1oRZz+KuVkMSp9aj5ET0t
/qazrC6B/OjvRMfF3+JiVgk0+8/7hw==
=V+Hb
-----END PGP SIGNATURE-----

--gb01w0EsSRULSS0k--

