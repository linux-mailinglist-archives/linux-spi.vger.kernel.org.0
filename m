Return-Path: <linux-spi+bounces-3714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEE91E414
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B8A1F23073
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE52116C87D;
	Mon,  1 Jul 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmTZzJpf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFA16132E;
	Mon,  1 Jul 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847704; cv=none; b=ePXnp59zatSiSGB8tk4cBSmtZKwC9fdoVnwayChRr2n6qUZpwivREYqeroOkId3NEX0nLOjQtrKBnOatSQzkarGdW8KMIw2PROCPXuCzpCdUfU05SwkisLpJt4SWlL6UVo1taQxgJ3EKLhYOFdI1NKtLSGdgCMQIEcJ++x7o2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847704; c=relaxed/simple;
	bh=zJG+h1pN9ClIxA4MuEYTWu+UyZIRuLS9ujKuZBOeNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baE8zHJ7i6dJCF17sBei0rlszTLEBFvwgepZdmWoGMdaO6R649jsQXbWeiJYeS0pGJSnWGsoBceh/8vRLCUl9/S62I2tTI8y5PbPOGdHW02UcmeJboqLkwsX6rX7H1cPRCsIrBFmLpx+Ycc0cyV3xft27nqNmIY2e+FgwAMrXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmTZzJpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A173CC116B1;
	Mon,  1 Jul 2024 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847704;
	bh=zJG+h1pN9ClIxA4MuEYTWu+UyZIRuLS9ujKuZBOeNlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmTZzJpftcFzvBPlfk070+hDzb58S9IUzu/fAs68U8RPJUKbvD1R8JwSdu3rR12s6
	 TKwPTfeFSemq/cbW2Ch680yCs6/HFcG9KTSUW8qkVMgmesRLX6/tPkW57g5kbNA9Om
	 SPQ589hC20w0TJmaD+GDxhf2hEKlJLF64WZnf/TQ6Y1pCk+QQg6IItSYD4rhbdNmXF
	 piuqQyuJ7b9apv8H3IoZ/9toimB8AJ5TbXgI/D3LA5SJuu1Pm55cDmOdVqdwXCkcFj
	 9s6ZFxmCBT4ywetW+v7Tn9FUiEkXCJALg3NDRcUbMRSM/LnYzSZaNHs7uP4OW7RqDO
	 PmLMJvYNLgfDQ==
Date: Mon, 1 Jul 2024 16:28:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Kuldeep Singh <kuldeep.singh@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: (subset) [PATCH v4 0/3] spi: fsl-dspi: Convert to yaml format
 and use common SPI property
Message-ID: <4ebbd545-0371-49d8-a19d-56303cf5c67a@sirena.org.uk>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <171984553050.67981.12522537296340689285.b4-ty@kernel.org>
 <ZoLKN6a2qLXrR+oX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Uyv1VrnGHXBOUP3"
Content-Disposition: inline
In-Reply-To: <ZoLKN6a2qLXrR+oX@lizhi-Precision-Tower-5810>
X-Cookie: Microwaves frizz your heir.


--2Uyv1VrnGHXBOUP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2024 at 11:24:39AM -0400, Frank Li wrote:
> On Mon, Jul 01, 2024 at 03:52:10PM +0100, Mark Brown wrote:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> Thank you very much, I sent out incremental update before this patch
> applied since my one miss understand. Could you please check this?

> https://lore.kernel.org/imx/20240627203308.476437-1-Frank.Li@nxp.com/

As covered above please send an incremental patch with whatever changes
were in the new version.

--2Uyv1VrnGHXBOUP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaCyxIACgkQJNaLcl1U
h9B3Dgf/SIrxupQ7K4lT/QT3OpDmQBlJGu0P5Wy/9zYhW+weeAN2omnVKl6wBZ/Q
r8gGMiBouJwOI67jH9hK27m4ZaR9OOYzgxtvqcZ0BhTHHLIqBdy33KcGx0lU334c
rNCaMva+07MtNYVFLgjXST90eQHzzTW/JLJ0XLTAJSZjj4pQUTNjONGNn2C1Jsgh
xWFgU538ZLuXq+XetznQyY+MnmoiSBrCLdtUURHQcA1HVOjJ2pSzN00qJoXV/rXH
HGFcYi7b+YTgWshXkeS1AXppMvizWomoD2+rBMt/STttkQYjI3DggmkxONukE04J
L8ti3LknvPtCTlT6WW24CBuPKkD5xA==
=3LSH
-----END PGP SIGNATURE-----

--2Uyv1VrnGHXBOUP3--

