Return-Path: <linux-spi+bounces-956-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CA8456E8
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341721C247C9
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795F115D5D2;
	Thu,  1 Feb 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfwkO06D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493915DBA2
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789120; cv=none; b=IykO+snAZnJDT2AcV6h5EJuxpGNt1vH5LpaY400Sx42sbQQBSpRT1yRBdSr/LcVwiK2CwJEPyNiYVdW35/d62kmCZgiZNcqm/Kq3St7UaZy7kwOeEltvSDkeD42WrHpf50nL3F+BXPvc866nFRW05iX8To/sEzwQ0AlCaVs8IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789120; c=relaxed/simple;
	bh=JblNlADTGIUqGdf8F+iqM4tBd9N53xAW9CwEjFnpqp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSV9Oi+ISDpHmpVQwKGiN0TZ1hWQXYllAIzz/64/8sas6Y8R/s0tMtZu8Im/xGAg1st4Y7RTrfUmxMfOwfIe6cxAnXpz8PKXB9wRdc3epZtn9Yh0dM/P4O+pfdkM33TLARPbMwiw2HTeB7C7yUzA0z8pv+x5EnAvPhCU1HW7PmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfwkO06D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB0AC433F1;
	Thu,  1 Feb 2024 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789119;
	bh=JblNlADTGIUqGdf8F+iqM4tBd9N53xAW9CwEjFnpqp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfwkO06DYVAeN2U82y3W0uzC3jtu1NCFX/lpLfoKhuYt5lIunR2XPvdtUjv5av7yV
	 ZVg03T10OVl5DBGiVuKo7Q+4E8Lm5ObOxoLye855pmiyVg3WtwZ6L3j6UVGYUVPTYI
	 oLR7ZfACxRQ9MwyyawBBsUMoW/1nF6JkBecJ34lOXN10gX1xXIPnce4modNpTpAiDA
	 cKCQW7Wn+lnaQDEaBCwbxCEHt3fPZ5NHQj9KMrXu4s+OYxI0wVonHvR7wKsXOc9rW3
	 X4BcPunlPv85njhsigXZz8TnFCtnpASfldfqcCzcltVmfgHTmxNY0UxrgmiyK4Ah/9
	 iGh8CfbZOkPqg==
Date: Thu, 1 Feb 2024 12:05:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	leoyu@mxic.com.tw, jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 5/9] spi: mxic: Add support for swapping byte
Message-ID: <c81eb3b6-c9c1-499f-8868-0f6bed10b259@sirena.org.uk>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-6-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBg1v3E20fkE7FB1"
Content-Disposition: inline
In-Reply-To: <20240201094353.33281-6-jaimeliao.tw@gmail.com>
X-Cookie: You can't cheat the phone company.


--gBg1v3E20fkE7FB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 05:43:49PM +0800, Jaime Liao wrote:
> From: JaimeLiao <jaimeliao@mxic.com.tw>
>=20
> Some SPI-NOR flash swap the bytes on a 16-bit boundary when
> configured in Octal DTR mode. It means data format D0 D1 D2 D3
> would be swapped to D1 D0 D3 D2. So that whether controller
> support swapping bytes should be checked before enable Octal
> DTR mode. Add swap byte support on a 16-bit boundary when
> configured in Octal DTR mode for Macronix xSPI host controller
> dirver.

Acked-by: Mark Brown <broonie@kernel.org>

--gBg1v3E20fkE7FB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7iPkACgkQJNaLcl1U
h9DJlwf+Lmmsat/t2Ej8cR794ywlry2+IcRfBH4pN8fKO7aLvV1lUl9kCo7wqsQt
RxmBmbcsmiNVFPFtst57PyFbc5YWzQCm3D7ZRj2l+LsLUUepDrLlxXTuIVQCmErA
hZuD4xbzxRNb14s9nfkXMRHbwfGYZpmxQyJvEvCBd567Oo+akVJ9lp1jJZVXDusr
CBStw4y4wnwsl4qFJnSdl+AVjMHSpKfXqkpSwD5HcZO1ppU36FFYuqlUHH8V0J5u
u0JtpNKq92TQtZwyDAQyMlc9AE/cDtVHPvEKx+ja4b06P7xMzU4GwGxUV/4sKZlx
3pKoP0v637XaKQ4Rggm+c2fvi53fdQ==
=Dpq9
-----END PGP SIGNATURE-----

--gBg1v3E20fkE7FB1--

