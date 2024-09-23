Return-Path: <linux-spi+bounces-4934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C097EBC0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC4C1C20F2D
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40A197A83;
	Mon, 23 Sep 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W757MVxQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682280C0C;
	Mon, 23 Sep 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096109; cv=none; b=arvquLPGXw9HqL1nXUR0EeeuX9rqV5zTSaFOlY9mHd6Q6wOsLDH/qiYpJoAbCqNCvRo1n81TXOo+hFr7ktBxHUZeEL4Ii40CVq2ropLDWY1hdNZQLhw3ABRJd6UVCRcq4qre5JQjof01eIesI68wZBJJv/pCAcssCBYhayA6V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096109; c=relaxed/simple;
	bh=stxE/HbW5j3jdKRXUgQjsB2pi5emT4JWJ9kgNd1Prw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibEFA0Vw2OZL4j35IGzoQA2mMK+mM4bjhdFneTVHx6yl8kqPLBsWSJ86/B4vnlgXTnS9KKfyCTwvu+nWpmuT1/LsrejlpMo0LwaMiBY2mdJbZUZdCnsTCkpyeAFSgJf6x/2P9aLBHNes5kpqA42+LTm2G0YJzjIydiYhzyU8F5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W757MVxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FD8C4CEC4;
	Mon, 23 Sep 2024 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727096109;
	bh=stxE/HbW5j3jdKRXUgQjsB2pi5emT4JWJ9kgNd1Prw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W757MVxQWWduu37LuiMGTYCMw2XVeL7ITdzX8D8dKHvolKAAXj3L/kCxVKUX30syk
	 S7GublWXnFrAunfPt5Y3BV7Q5IflP5vA0CRedPKsZhIHHV+Qtrg5OyIEt1bFSdU3Lv
	 cH6NlDRgmhepdSizKVFmZg/SQFswa8/0J0wX2u5rZiJcxj3pnfzA2+NqjzvxCkrDPv
	 4F+bwoVh6Am3BD301DahLQJftbUPXhqhsPdEbVAHfS9Oie1fhusIZa35+BNPF2F76u
	 XfoDlcp0I8qHaYtiXt7M42i3Lk6Ub3wVitwUIOwd/vRs4pIB/l2TCEi+EY0KGfKmpA
	 omAHbd5OjnNMg==
Date: Mon, 23 Sep 2024 14:55:05 +0200
From: Mark Brown <broonie@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: heiko@sntech.de, kernel@esmil.dk, jon.lin@rock-chips.com,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip: Fix excessive check for get_fifo_len()
Message-ID: <ZvFlKdSG7GgGPFnJ@finisterre.sirena.org.uk>
References: <20240923115516.3563029-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aA8hsKxhlaHzP4GS"
Content-Disposition: inline
In-Reply-To: <20240923115516.3563029-1-ruanjinjie@huawei.com>
X-Cookie: Editing is a rewording activity.


--aA8hsKxhlaHzP4GS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 07:55:16PM +0800, Jinjie Ruan wrote:
> Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep
> FIFOs"), get_fifo_len() return 64 or 32, never return 0, so remove
> the excessive check in rockchip_spi_probe().
>=20
> Fixes: 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs")

This is clearly not a bug fix, it's at most a code cleanup but...

> @@ -819,11 +819,6 @@ static int rockchip_spi_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	rs->fifo_len =3D get_fifo_len(rs);
> -	if (!rs->fifo_len) {
> -		dev_err(&pdev->dev, "Failed to get fifo length\n");
> -		ret =3D -EINVAL;
> -		goto err_put_ctlr;
> -	}

=2E..given that the probe() path isn't exactly a hot path is there really
any benefit from this, if someone does add the option of returning 0
it'll silently break.

--aA8hsKxhlaHzP4GS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxZSgACgkQJNaLcl1U
h9DDkgf/WcHFCAGsIGgzc1AiyDQCp1vChe7c/eZuaQrPEok5JmjaxqBWw5DmjxZe
vVicx3ZKweVxzci6vd91hdnibwz7+dyIZChULC2Y1BG7O2USkaJod1rOdfcqcF0W
6j2TA9+AERRq3gdza62TVBou/44fUwZA7o8zFugX35nZUA4P3rySk7GYXvvFl4C/
LlVbGNLnXzVF99Ahf8CbWyNelznABWv2BUSMCkM7vDClgPLMaqwCv/j6yRbuw5ZT
u3eSTCJjLoW/+YPrY7il9kzgi7G2ZJpgBb8m3PDhfoMxeEQI1P+PrCNgR6dCnBfQ
lY72oLNXPcCM0ijvN1MX+BYzAZ92pQ==
=A88S
-----END PGP SIGNATURE-----

--aA8hsKxhlaHzP4GS--

