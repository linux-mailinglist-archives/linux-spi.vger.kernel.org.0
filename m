Return-Path: <linux-spi+bounces-6395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50AA15068
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 14:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731503A1686
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE11FF609;
	Fri, 17 Jan 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVAj7slW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1ED25A627;
	Fri, 17 Jan 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120124; cv=none; b=pVDAnLZOGqaeIKBJDKPnvP/U8UtWC5Evcam7eTKzRgozcF0JKnYf3vIrvJ3LNb9DBtMMPu6BhKcAh9oXgsVwa9yY2rSlKnAX1MKUsorvLljT+4PYiMj0wHwpKU8PMrtePrddGLo53bzhljJ6jOthdTzpR+v+zrut8P985jM5ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120124; c=relaxed/simple;
	bh=fSFd7Zpved/J9ARzkNxskvv0MDGbMGB15yiCNUdlcSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu7F2XwzwJJ7nnORpKXQALu5lbUuxXLqB3lkx+5F3OXAvUEkTIcKde14IywLykwG2AL5cFn30tOalHshDekmoSbUBLF3xxAaoZ1O/BCCLowRax+Ef/Z7CQZR0spGHEhsr50Zem4VUrvREZ3uIUjwuHi/m1qt9d2/2HnDgmHeazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVAj7slW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1BC4CEDD;
	Fri, 17 Jan 2025 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737120123;
	bh=fSFd7Zpved/J9ARzkNxskvv0MDGbMGB15yiCNUdlcSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVAj7slWnimgq+K/qg63qK7az4/Vws1Vv8xbnNjPCVvcrp1GVjjJjYpUZaeC6cdbN
	 t0aTP+pi9UOlSGw0/1Uj9vBlAd9+vezH4C26sGtZmTvfj34KU6rKrMHypAah7uiJAo
	 ycHcRABpMoxkeMeKch7MRzDilZt08iWYzx6vqir0XKbot3F0eq3Gxkkd5ibemEW1rz
	 TZBe9m1pdpIHbPMi8Jlkc19JP5Y6glI+jNulChUh7IJmBrdj5hER39rGDFyIxUKV8l
	 lFnDh7Hn/d52+UhhRghZyxCHa4X7qBsUSRmD2Px5oy9EJSTmNz7nI6qr9/xgl4MHoW
	 tKkaQ3JNUsilg==
Date: Fri, 17 Jan 2025 13:21:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
Message-ID: <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9LaKOexVYp/mUJYS"
Content-Disposition: inline
In-Reply-To: <20250116225521.2688224-1-sean.anderson@linux.dev>
X-Cookie: Q:	Are we not men?


--9LaKOexVYp/mUJYS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2025 at 05:55:16PM -0500, Sean Anderson wrote:
> This series adds support for resetting the QSPI controller if we have a
> timeout. I find this greatly improves the stability of the device, which
> would tend to break after any timeout.

If you're hitting a timeout that tends to indicate there's already a
serious stability problem...

--9LaKOexVYp/mUJYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeKWXUACgkQJNaLcl1U
h9CpZAf/Wk3o1MAlJ9TGR6o+nwTpH4hHPLa3QLO78QLJo5xgPC8mTkGIg/FmONxC
lPPbIYeRT0sRBmIvct3xfbvWNjpsDa0elpSM4UzX578IEx2i7Hj+rWiLl7NUE/bM
reFUV23KdVcTYv/CfP0fmC5SpvoY788WnnP60xSbsf2M5H+IAoyWovHE+WvHEJSx
6Oyh+jLUWTdKkYJqADmTKytyZGHlJFujVq6IBUT4C0bEXYphv8BUmSaC1KvdxWfc
22h6JtGfKU7jYrALUaTABxweqaJle4lbbpd5WNYxdnD5xh2NlDfOswz5QF4DE4FW
HuF+P5Nkc9GMGbuJh5uWIwAagvlQ/g==
=Et2M
-----END PGP SIGNATURE-----

--9LaKOexVYp/mUJYS--

