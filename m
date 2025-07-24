Return-Path: <linux-spi+bounces-9171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF7B10ACB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97AD5811A3
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1E2D46C4;
	Thu, 24 Jul 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLOmCAbS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F71274B24;
	Thu, 24 Jul 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361984; cv=none; b=nZCJtsQ2alqdpCwNyQwrsl4r6ScYLkFvtO19olNIzEDNSYeU0AJrMy6yFO2BrF+QXABnZoLESOmLyxy+A8dROlfnKogXJcsL6A9FTWEhkF7t1cuxxvkPzTsEVQeXIS3IevEWgYUfC0xB6sP0auzOAgDxwRzwi+QAAJpVtWGcDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361984; c=relaxed/simple;
	bh=LCDw3KpOAhFbW7VpydgQpLzMcDlEFJwhJ3nZVJpgc/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uckxv0IVXQq1Hh/jINsNSk9l7SZdSptyMHg4CmiA0v1sS3jBR7/wUA3P9URUQPhQvjrzIE3YGRA4OVuQJYHUda5zkXsplIX/Vp6a0UYE68xNYE5iHDtiyJO861WJVwCMX5vgqUQhV6LXc8wSS6FBjs5SyLMgkIkz82dQswyj0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLOmCAbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA8C4CEED;
	Thu, 24 Jul 2025 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361982;
	bh=LCDw3KpOAhFbW7VpydgQpLzMcDlEFJwhJ3nZVJpgc/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLOmCAbSv7QzXQWGgV6EmNfDV2ypCW2/s+5547FawBAM0YZrFzEGgDRVgY7MetmqL
	 21q2DB8NnN4dA+BsDWeZlAHTK1mjEEy4ixWvSNHaVrj4ewSVLbSHwiqtLl7b2Ud75t
	 iLNXuRfJW54eoGnqagqEnl2XOhKLHKjIC2HwY1EGGPwvQVroJDTrtDYH1++mEYwSCv
	 0s94IQSbWl7UpHwewpoIRNupllGDBEzC9OS/hO76j9MK7pXlVQERkZTX2uEPtfYnpE
	 blS+sOj2HpIf7Imn+oZ8wR+2eCAbtWiuG7qzzwJKVbtHpXqXrg2NVeGFf0jl/XiSIo
	 Oj35esBxVLBFg==
Date: Thu, 24 Jul 2025 13:59:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Message-ID: <0b58e72a-ef96-4f04-94dd-66a6f3f4d0f6@sirena.org.uk>
References: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
 <20250704162036.468765-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KCzpajG08jCdybG8"
Content-Disposition: inline
In-Reply-To: <20250704162036.468765-4-fabrizio.castro.jz@renesas.com>
X-Cookie: Where do you think you're going today?


--KCzpajG08jCdybG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2025 at 05:20:36PM +0100, Fabrizio Castro wrote:
> Add the MAINTAINERS entries for the Renesas RZ/V2H(P) RSPI
> driver.

This doesn't apply against current code, please check and resend.

--KCzpajG08jCdybG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiCLjgACgkQJNaLcl1U
h9BM1wf6A6Bo4D1foxqkvJmASu2oQ+0VaeVhxh6stF2ZbciFw/jHjYKRx4z38sei
tD1fhUx9Iy0higdeXR6fJy5D33nB1HDNRaxorXPcRsi9tJNLUXafSr2ZLHjpDYVT
h0cJ6NpxcysI6SFfyemDH678EijWS3xjYLMYwhRjylPYzeUQjgLCGJGUm3XUHPHD
JumKjpbIr12al41LKa3Bz6dNusPFEUeV6u3PhqRAPMB9Nj7+cWAB3654CJ6qfPBy
tNbxlNEWBzZLowowtcepTUjdEvsO75bbXebzd4Z87p5SM4GFid1lI8sBur8Uy+sS
Fx06Q5nHS/xzGpCxoNaWHw1Qe3xXhw==
=jU+F
-----END PGP SIGNATURE-----

--KCzpajG08jCdybG8--

