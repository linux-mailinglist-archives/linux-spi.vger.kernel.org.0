Return-Path: <linux-spi+bounces-277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CD812DEA
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268CE1F217C0
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807D3D99E;
	Thu, 14 Dec 2023 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIA3oV97"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC03A8FB
	for <linux-spi@vger.kernel.org>; Thu, 14 Dec 2023 10:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8BC433C7;
	Thu, 14 Dec 2023 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702551539;
	bh=h2n9sJgI7iecPTEQJF6qBmcxxJPpJSZTHnxzEJ3wKwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIA3oV97KFWRFsEPwjeyn3J35QSEO6UN5RWwt/J0MR8rIRq9TXVhwNs7XiK/XlTOM
	 SAxhoDPSc/4clfeAXwme6dgXy0SYjx0Xjw/QArY5oEy4kspN9xcctNVqYQ3hmyKui8
	 PzrsChKQfy6/WuX/Q66xTO0RNQ46fSdny9B1uumqtrMcqKhA4tFYyTs4TQrgG7NExL
	 UlFyJMT4E4IEQJsyS4m/S9KREaarZKUwiaScxpUwTd8IdMW7z+3ZOA1FidIlHy2YEg
	 z4q1cNV3Ypdi7eL1hMvxtm90sUpvmTdn6BKbHGLaTPlV/a9+UGGVnZ2Z8wSixpU9AR
	 mSDui60YU0AMA==
Date: Thu, 14 Dec 2023 10:58:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: use runtime PM to enable/disable controller
Message-ID: <58897511-3187-4583-bf29-11871dd4d136@sirena.org.uk>
References: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DT9MugTfRVMgx60Z"
Content-Disposition: inline
In-Reply-To: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
X-Cookie: The Moral Majority is neither.


--DT9MugTfRVMgx60Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 03:20:55PM -0500, Ben Wolsieffer wrote:
> Instead of disabling the SPI controller between each message, do it
> as part of runtime PM.

This doesn't apply against current code, please check and resend.

--DT9MugTfRVMgx60Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV63+0ACgkQJNaLcl1U
h9AFDgf/ccmdPjsD5WeSY9MvAPkSdAwIv0/d3yGNyZY8qdHL+ljsOPGKyoF26FeU
DE5beBpTNPTh7y+JLF+Zb4UrC4a2hvEHpVJ99B7AZIde+tgNkPA3JIapbwh7ehoR
a100WtJV5+KG4bFtuw9CJRepYBqaaaLjrv7euCJHgmwsJNb1OiPV+RPe5qiWN3vJ
PPJwY9HUiY7svi9F0sgYPdISw2DJw3syj1KIC92TpFeBz6L9tWhdeD5tGxkC3mDt
4EOJ61cfkbwEm7xasmlAgQHz4/+VV0Lps/kS+hyeKvpOVnCaKQeotrm5QJFJ04ne
GsI1cdjsw1qc2v8sjwCr688sRVeJCw==
=HXyo
-----END PGP SIGNATURE-----

--DT9MugTfRVMgx60Z--

