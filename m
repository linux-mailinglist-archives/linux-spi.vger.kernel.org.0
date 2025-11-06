Return-Path: <linux-spi+bounces-11096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5017C3CACA
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42545646D2
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3133BBBB;
	Thu,  6 Nov 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCUCqgz9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEB285CBC;
	Thu,  6 Nov 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448153; cv=none; b=H0ZIV7tNj0M8XPvoGWiAH0c2lDxJgTMXiV3FhSh8lGSX8BxLoadwj/Z+6f3XxiAPKq92jJw+JG8uPmQ2GKHYrINB5vkcu4ztxLmoUOTjsG8+u4qXLBU4GHCd0TeMlMRcXEDR1D9A5b1IMoJJGfmZpTSW+NR5DzPdl/5qCtqwpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448153; c=relaxed/simple;
	bh=INKkQZKXRvoEmqr56OZfn85xTxcnjEuZr06CrINjP9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNpz4QQjlfA/pXAcfp8485/4lZQ/iGbFgK9osqQoV9NJxdO2B2MFE7Oi2KPJflrqnlAINi/0/8OBlq6FxsOTCIL7bz5eZR3VzOYRaP5aMJ+TOhvbuoKdrSt9cDnmkSEYTQrR4e8vzes35vm7DR3OE3f5sOkNd1hh0jurYJP20VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCUCqgz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D242FC16AAE;
	Thu,  6 Nov 2025 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448152;
	bh=INKkQZKXRvoEmqr56OZfn85xTxcnjEuZr06CrINjP9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCUCqgz9oWWuCpVclbbG53qqmAEteEcTdkFeRqvQroyYKhiHf3z7u6AqdAEi6hrEg
	 StHrV3mHiauNqRF0X3i2vwoYPNJ1dM7xUNnypZpe2MhYscpZZBmNhbXdl8ntQqtFgT
	 ZcsTgQ3Ze1UxPoZM1NyfMR4/0obP8BrDDOp5fRmQgLc74/LcwYBYSzeZcXe6TekX0/
	 ZKp8EcnC4VRfuawjVB7Avwhhzl9v5/YOOfYfFrGllmVe3GgsDaL5oeMx8vbvN0JxmH
	 jNGYiytGccA8KUOwQp8u6asNv64vsd/JLCLswZKCF5HEOTjK6gFIsfaccRcEe4TjIt
	 BZY+TPvUm1FWw==
Date: Thu, 6 Nov 2025 16:55:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, dlan@gentoo.org, Frank.li@nxp.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <aQzTFODaYaevp0v-@finisterre.sirena.org.uk>
References: <20251027133008.360237-1-elder@riscstar.com>
 <20251027133008.360237-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2o85NyMik87PQrJf"
Content-Disposition: inline
In-Reply-To: <20251027133008.360237-2-elder@riscstar.com>
X-Cookie: If in doubt, mumble.


--2o85NyMik87PQrJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2025 at 08:29:59AM -0500, Alex Elder wrote:
> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
> is the first non-Freescale device represented here.  It has a nearly
> identidal register set, and this binding correctly describes the hardware.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--2o85NyMik87PQrJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkM0xMACgkQJNaLcl1U
h9C9ygf/asts4SaYlQ8kFs/PjZGM6Z5eh7AXfCSNgZMDEWxBB50XugwxeAM3zXmv
NQsKsvHvhBmKGsZFerQcA273D6wh2mzw+Y95N69tHKfokmk8NE5UF3uCgv/HUwNM
oRx/E5weS5meAoTeuCrkvduSTnoBimeYrJtzV4IvvrgbbMBQ+9fpBn70yAk30p1N
9wCaF/aVNynUW0Cclof9tFQ4RckouUEKdkuvt9CXV8bGpZdNevCV4J7RVoFN/Njs
Bui0PLDSesJmuRMyOSUVATZDqzG9Qf9baMUB2hptWaXlHVcXaOc8nLyfwPoYOR/c
yNI0CT15fzoNFqlhEecigMQfInXKhQ==
=d0As
-----END PGP SIGNATURE-----

--2o85NyMik87PQrJf--

