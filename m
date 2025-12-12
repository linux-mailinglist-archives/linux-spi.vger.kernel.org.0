Return-Path: <linux-spi+bounces-11877-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31ACB84E1
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02898300F897
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B992D979F;
	Fri, 12 Dec 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iti8AUr0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96884A01;
	Fri, 12 Dec 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529058; cv=none; b=R3JeMpkERRKgNP/sVtMyHnTVurpUQSS2CAX5ntNcMpER0zav5yqikbrz+VLJORK1e5SfJqO4q1NwG+5PDmOmgD+8aLXr23c9goMa5YdxoJAOe/t8xFcW9IN0Jyk0iN6Tvtul25+4nD6+cxHcsdyIi7Q2bsETrmJyOhL7PCpQPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529058; c=relaxed/simple;
	bh=0xN0jnamQ9VSpPh7Fd2w1C50hMFcLj+wzQUWCh7OffY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7sg8p5NDwwjPRuQnNKBB3Tn0yO/wZSOxecgq21956F1DnR0WwOtsNMJ7KRy3p670heF7osWSU29bYss2xXa96yJMDxZJwOzUsiAtuYhxNQCnKMMXMEZwoPK1pARKGUJyTYbzodT2NNBzMOnDSgBG/xPzPUK/Ar2P2PndQzHTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iti8AUr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720BCC116B1;
	Fri, 12 Dec 2025 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765529058;
	bh=0xN0jnamQ9VSpPh7Fd2w1C50hMFcLj+wzQUWCh7OffY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iti8AUr0r0y1dO6nS/vQXVwztxB/benKgf34RLY1x1Bdrg4nHfkVlUTtQdDTQrtIe
	 uIM2GC5uYbHZrmNyopnakEPaCZnX1GnvsP87SKZ9Vt0Verbc2zs/cknHgYSg819IV+
	 t5r/cAkKDHnldYmRJIvB4OTNTcvV3z7qrqiuFs0gWWYozzHfqMQwmcMI6FLWOva2Xd
	 6fTpVWuaGKVKELq5MbwBfNUQEyqbL2PUh5FtCdfmiWhuZs35Jn26S6GzRBE+N2kXad
	 KcjzMUpxGgLrIvj04ndPGPztLarh8h8viJUzDpRZcMWMzl8DSr6dj5SNiaSpPkNUKb
	 o+b7FgtMAe22w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id E5D351AC5657; Fri, 12 Dec 2025 17:44:15 +0900 (JST)
Date: Fri, 12 Dec 2025 17:44:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Anurag Dutta <a-dutta@ti.com>
Cc: grmoore@opensource.altera.com, nm@ti.com, francesco@dolcini.it,
	s-vadapalli@ti.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, gehariprasath@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Fix clock disable on probe
 failure path
Message-ID: <aTvV31zHFV30tR-N@sirena.co.uk>
References: <20251212072312.2711806-1-a-dutta@ti.com>
 <20251212072312.2711806-3-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yQzpWiqA4416odKe"
Content-Disposition: inline
In-Reply-To: <20251212072312.2711806-3-a-dutta@ti.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!


--yQzpWiqA4416odKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 12:53:12PM +0530, Anurag Dutta wrote:
> When cqspi_request_mmap_dma() returns -EPROBE_DEFER after runtime PM
> is enabled, the error path calls clk_disable_unprepare() on an already
> disabled clock, causing an imbalance.
>=20
> Use pm_runtime_get_sync() to increment the usage counter and resume the
> device. This prevents runtime_suspend() from being invoked and causing
> a double clock disable.

Thanks - this is working for me with a hack to trigger the issue,
hopefully others seeing the issue in real scenarios can confirm.

--yQzpWiqA4416odKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk71dwACgkQJNaLcl1U
h9Axygf/eBOeynLA4Xi8W1YBfi8xJkdWec4sPdC/7LMfZZKqU7Ug73H8C7nihurR
4VD/B8Q4+mks61V6Luy9IHJ3O7VVYCW5oBWIBX5mrTCR15qMb2tskPhTHEHSsm65
FjYaCwdP10PwkoJN+q1y+EnjFRLU4Tkxf4RmZw5SxY+DAasht1w+9qnZkCzHtdT2
d4iNI09BB3VGej1NxH94gOvlzSGQW8LD/Yy0nWTFC7iEX4xM49Q+qL7vgAAY16f3
BBcLjSjpU31dVcMw6nk7toT7z9hDPsCZKpScPqRwRTXPAKelWbZI1Y1ZzUog6uO9
raoQ42/GI0soj8dGDOjSiGrZZaGXyw==
=76ri
-----END PGP SIGNATURE-----

--yQzpWiqA4416odKe--

