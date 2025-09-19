Return-Path: <linux-spi+bounces-10177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECCB8ACAB
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A461CC3E4F
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83F321F27;
	Fri, 19 Sep 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhwxqF+w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAF1DD543;
	Fri, 19 Sep 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303505; cv=none; b=Vt9Y2B74CR0RIRF5ZgQS6mf6xpsYqFmLCcl3kzzMOAVC0AIRRyxJqKY1N2wCM0WOsQtFszGZ+G7vA/GoD2I2UZ3T00D/uh5xsLurAbS+TCksWvRF8INJSvla3VCgIVuD+GkMltMTS1nX0LOGzLvou8h6lw7mAOgnoelMyuP7l/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303505; c=relaxed/simple;
	bh=JXalJEMcPKVI/FVEmtCWbAZklUCmyc26S6X4DiPHDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcdT7GZpaMBip3xADaUC/7HZHgupivBR4rF5nDZfo17/aH/ZDgtlJiDFReTaPe5JT/cFUyWcHSEQItmU3l02OGU8tuslMg1F2Airp63CdLMtVMEkyhWrAHHnJEVmYhtVbXvErLpD39STpf1bd+bDLWFbm9dGrdAQXwPwgWCr1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhwxqF+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A808FC4CEF0;
	Fri, 19 Sep 2025 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303504;
	bh=JXalJEMcPKVI/FVEmtCWbAZklUCmyc26S6X4DiPHDhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DhwxqF+wG8hXFFHVWDx5aJLsRFthdERZdrOA8ex0VML4B0kDewcxb5QOC5j0CHcsY
	 x83LLiayEZ4ako1S04jEKQPZucYCyEbqkOV1aI7a594i8wRkDwfgz7URxkh5gLVIwM
	 2EOdGu9/lZ8/gwNaRGMkcKRYuYKMjqbIVSNSYv0ezhGx8xmLAcV32f3tw47e+LC7th
	 rVrzdJmK5B8S3GIc/B4vUrbIxm9KDElfmQcPPtOIACkmLVcCE5OhtQZFNRr9ccXtrk
	 0Sj9+w9gwAjrkJ5XZv9zt/7biTS6ephQD1z9xVCZIoGbw69XS2ojE7sV+b52OcMlbk
	 p6CqafBRmTViQ==
Date: Fri, 19 Sep 2025 18:38:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, ziyao@disroot.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <20250919-serotonin-simple-ba6ff8cee16b@spud>
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txZUjU8dSxy0XkUh"
Content-Disposition: inline
In-Reply-To: <20250919155914.935608-2-elder@riscstar.com>


--txZUjU8dSxy0XkUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--txZUjU8dSxy0XkUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2VCwAKCRB4tDGHoIJi
0mCuAP96BDQRGtzFy5PJ4/T+VpC8SeoS17z41ztpiwSPJWowfAD/RhMhwlKRv5Bz
O5cbvTsjzlk3z7wOks+MXJiY/k1q+gA=
=ltSs
-----END PGP SIGNATURE-----

--txZUjU8dSxy0XkUh--

