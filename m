Return-Path: <linux-spi+bounces-10895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895AC156AE
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1E74355128
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0C33EAE3;
	Tue, 28 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIGuZbSl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6ED15DBC1;
	Tue, 28 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665106; cv=none; b=UrzUtgPk6o/X3qgZb5xgVEVbHF6DKdOBjj8jaU9Zj0qICyqjO3WUpqTDv01aw4albkLtpuEQ1yriaRHPfZU4elhkM43BL6MCzIDuy6teSuDysM/FrRz69imbOhLrpf15JA5qfJbmVP2YN+O2t6Igg08eGogxTGEkEbYKTnPRwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665106; c=relaxed/simple;
	bh=9l560/UVvgJqBwAHOHwPNy/Obj7HxwUYM1W6RE13gd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rldIAJeuv8Jk60nxvMa25qjJPBacD4LOTm9cDRnW3mCklnv5w/qLT76JuG0OYuFPw9cNoRHw5jJwrpMYmsjTxLBLoPYwfclUCD0+dr3Ulofyzwy6RJFG/ClPFw7kW3T8wv9nv0ab0G9HtDr0hnDuvLkWalD4M1lb5xg4uqXcyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIGuZbSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3119C4CEF7;
	Tue, 28 Oct 2025 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665105;
	bh=9l560/UVvgJqBwAHOHwPNy/Obj7HxwUYM1W6RE13gd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIGuZbSl7mYJxY/yesPT9CVXE4BMEoTkJQHNJwoLcEJpnzHsI6R+4SXrajmVXJjpV
	 1ykSWYFnXMnBWk8GUEt94U+ZdcJnT1WApexmV2bLwbjDPAXyxWXIp1lIilj8SB/Kc5
	 SU3uBBAhSh9Q9d1aGvzkDx8OpKk7LDfGfRY2y7wNZJRGV9d40ap/tNUYSj2TaUGc9V
	 5oTjvq1K1k5o4wYximWbz63A23ULJS2cRZJ5hqb+IB8UehgA81lTzpv6D+69mQqszh
	 lnznhgYsbkpRVmDPt4nIuYdQ6rYvA2kfDkhNgJsISOuxPamyhEV1etCtxGMDDJAWrP
	 NDWu8yCbRkSVw==
Date: Tue, 28 Oct 2025 15:25:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com,
	kyarlagadda@nvidia.com, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: tegra210-quad: Refactor error handling into
 helper functions
Message-ID: <a714f4a8-d118-482e-8a40-ae35f90f8176@sirena.org.uk>
References: <20251028151515.4142618-1-va@nvidia.com>
 <20251028151515.4142618-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AzXAVbz+wfoPl8Ck"
Content-Disposition: inline
In-Reply-To: <20251028151515.4142618-3-va@nvidia.com>
X-Cookie: Your canceled check is your receipt.


--AzXAVbz+wfoPl8Ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 03:15:14PM +0000, Vishwaroop A wrote:

> Change-Id: Iab526e0c19d160a39919ad98079b97c2da2dba94

These should be dropped from upstream submissions (no need to repost,
just a note for future).

--AzXAVbz+wfoPl8Ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkA4EsACgkQJNaLcl1U
h9DDwgf8CMZyDkHaKhM8uhNhp66Cw5wtYbxtAjXnbImmdMjAa6/hIDKUfkziWb24
bCP2lBTNQArvH8zoIcNpmYXD/W8x32I2EXrfAz9Hj1X7GRLnodOwJIzS6sfdarrO
0WwlFCeH77OdL83U3RIMKhQtlLZPDSyOAlfR/5GTBDltLKaEkqFEls+BIrneJmje
9RqzoRU3xEegzHQuev3lBVXBdV7wohA8LUPHZBif5m2Q9cusZBQk1ulRTjGp4Tw+
l8mp1i2MBR133y00wzdmyS95NTS6XAQ0W0LvDoTlROzJChSbCvDQnLe+KFXaPjk6
DNSKlMh8pBPDqKt3S8W/iqiEcSiDOw==
=gHGb
-----END PGP SIGNATURE-----

--AzXAVbz+wfoPl8Ck--

