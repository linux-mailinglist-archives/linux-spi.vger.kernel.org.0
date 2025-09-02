Return-Path: <linux-spi+bounces-9855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69379B3FD5D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6152C2EFA
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AE2F6175;
	Tue,  2 Sep 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifW05R+L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6F2F532D;
	Tue,  2 Sep 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811331; cv=none; b=FEokAxrWLO9rUvdaR/DoUGjPdE/OYDphdkSxb2K7eQBUfYmsC1KeYRknrXWtWjlIhWNEE5Zz/jugyR8rV3OEEod6kpoRq7D/yksRssqdmtpZX2ETzygc0QyfbBjVVLHshtFXn9RkKrmSDuQidVmM16LzcqcTAFTGKxpDhKmdBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811331; c=relaxed/simple;
	bh=98GrAJno92DtCQZEPAy9W7Uzdr9pTw990Q22kkCJlRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE8TIbSyFzshq0S4i34eu/WHcqQSx5W3AMT8GnOEzhMAmf7cb9r+QDoCCQPqvMrb30jjC30/3d1wGdzG5ywnZZvVDtyIy5PObuaclfvyD2u983aplrdOUkiUtjNkVc2A18czqULWQuzs1jI9AV4zMA4YK4qJISB2RrQp1wtxoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifW05R+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A47C4CEED;
	Tue,  2 Sep 2025 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756811330;
	bh=98GrAJno92DtCQZEPAy9W7Uzdr9pTw990Q22kkCJlRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifW05R+LdY8B6zwqefFGGNa0leX7MA7g+cKDdAinoLxOYupDZyZ5sfVUSeKWcL9pu
	 gukM8j7ssOnOgcLwnq9iJnzi3WAYlRr5dMNN0QaS5+Z3tudL2qVFQoquzc0+aq/dmO
	 /BseaJiu3B4HxSSFcdbU/nOg4d5OvcI9B+zqb6P0pHjvHG5XR85yil2QtjXMOpj5wP
	 HY3t4yPsbH3ZFct7V/3M5agxgx7pHpU4JK5y9Hi9jwbS0TvyPqavtwVJBT5pCnrR+k
	 FqZZdHkeHtF0mNPB0U0m4Ng3us4+AGg1bAbjIDM5bNMUs319Oag0n1co/6JCzjIt0U
	 DPjz+vFpwuQqA==
Date: Tue, 2 Sep 2025 12:08:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: [PATCH 0/5] Add QSPI support for sam9x7 and sama7d65 SoCs
Message-ID: <33770201-9c62-44ea-be9c-6d84e783a5a7@sirena.org.uk>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WoEm1YhYkZYnPu1J"
Content-Disposition: inline
In-Reply-To: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
X-Cookie: Vote anarchist.


--WoEm1YhYkZYnPu1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 11:22:17AM +0530, Dharma Balasubiramani wrote:
> This patch series adds support for SAM9X7 and sama7d65 QSPI controller
> along with the SoC-specific capabilities.

The driver bits of this all look OK to me.

--WoEm1YhYkZYnPu1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi20DwACgkQJNaLcl1U
h9D5Qgf/f5J1ANHIWLWnMtWR1RwnzOz1QDrcwcMjPKsHh84tpstX1jmhmDnCv2/R
QuXbIgk8AUZ3ykObhqQgbpb4CHoYEBN3ah0L3li/UFZykiWaMAs9GWpTrSuEsbiA
zuINXKaiDfkcZQqElk963QLLpf+MPV51YycUFbLqtQysqDzvkcTGieXb6QkXLTnM
riguC9rm303m3kWZ0RMREjAyVtclyy50hjF0TQHtxjrhiFftMvLPyQoSVvshRdyS
7pxIhaPFRreFvdpTbKfoo4q6LwIWjizDHzWK0i2TZPMcJBrKk0zkChR5QX0wGMvd
UA+StqccRScoVssTI0w9wVa2Fhw5Nw==
=kwiz
-----END PGP SIGNATURE-----

--WoEm1YhYkZYnPu1J--

