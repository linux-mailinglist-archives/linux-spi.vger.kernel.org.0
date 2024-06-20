Return-Path: <linux-spi+bounces-3499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E5910350
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0011F226AC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392F1AC252;
	Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdapU96M"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917D1AC24B;
	Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884041; cv=none; b=i/zWVcgPl9s85Vq4WDFI0cHaPNgQalx5xgt7eqIyoG93jPWaePbY3uzxEwKDS5EEWOYbDjwUlexXUWOUevmFgZbgvLLS0xOIT/W27414A4WFi8DrjXxsgOI3mksg5vnruq9AXil3rqGQQY2LIBdXzMnznpu7qZUIlY+45kWwMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884041; c=relaxed/simple;
	bh=ToNabALBbuBhFhwluskcKOaAkUWg3WHVU0SuICALAzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCPlhiZmpr1ZTUyKb4FivUb0uhXlmubTDVDsvXYL+p2sKViGF8B2W2iJk/L3ZxJP4jIrvZJWTZKgk8LbqkHCPfXcfeaZf07n6YjTowtwjhZu76f8aLuOuaulrfbEa3fjGCUsqF9KRbjmBIVMpoMRxnDZydgwBagUUOD6TD0euZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdapU96M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D2DC32786;
	Thu, 20 Jun 2024 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718884041;
	bh=ToNabALBbuBhFhwluskcKOaAkUWg3WHVU0SuICALAzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdapU96MCdWZmVmCIKzJOcJafc/1xIHXM4YbZbljz6LMcnv/L/DcMXn46wbGSmdFE
	 c2gZuQLMePFs9hKU/KB60zjt6oeor/CIFyDcPVcxHud+KgowlDNg1pgcDtgJt165Aa
	 Hu9g0v3zZa/sZ5wk0OQK/GpZhP3N2ye88nUv0uUH/G4QLtGENzX2/vTckMhijbtIhY
	 sLFpaJFmV5DkaR7vTXTKTgtr2tfyKZtuxndjYAf3dqorVuejA7Jb8r148PSqeOvZy4
	 0y5OhhMiMJkWPdKbKLfkWmJG67F8tZcZniyqJABSBb7RAA0pUasai3jMt+SFVxq5dk
	 gvgvJjnYDlbfA==
Date: Thu, 20 Jun 2024 12:47:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Moring <stefan.moring@technolution.nl>,
	Benjamin Bigler <benjamin@bigler.one>,
	Carlos Song <carlos.song@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Adam Butcher <adam@jessamine.co.uk>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>,
	Sebastian Reichel <sre@kernel.org>,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH] spi: spi-imx: imx51: revert burst length calculation
 back to bits_per_word
Message-ID: <63e0b99d-d47c-4645-bf83-fb671f28d57f@sirena.org.uk>
References: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
 <171888201712.41294.3998570181399309379.b4-ty@kernel.org>
 <20240620-annoying-elated-lobster-240aed-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4cmLCoCRDU6rA/K"
Content-Disposition: inline
In-Reply-To: <20240620-annoying-elated-lobster-240aed-mkl@pengutronix.de>
X-Cookie: You're already carrying the sphere!


--x4cmLCoCRDU6rA/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 01:43:29PM +0200, Marc Kleine-Budde wrote:

> As this is a fix of a regression, can you pick this for v6.10, too.

It is applied for v6.10.

--x4cmLCoCRDU6rA/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ0FsIACgkQJNaLcl1U
h9Akugf7BSpek4NuGXSKl176ezjD6HhiEH34iJ/wfYYdNMUN9igPTO6Avl2tzkNC
+ozsA2R58j0ZiD6x3s981l7eybc9P2nVRLMZomyYJhl+OeovGBinRJaz4Tu1wZiZ
QEi/35g4AdOepd/GfXhqA/gBvRdGmJVp9oEXEDDdG3skYmS7mL/brjpyoLfNA/mE
ixs4E5600ZGLI60oOvBjy0CbVDwsq7Tv5HOy7SOE8pqe0V8uNgz8E8sdabQu9CN1
Z7fEI5IiN0h6YSdljmoT45jImtp+GzlqAUNtZjM6otoG5aPYHx3XjcABkBJflRSs
Swn4Hq7zD6JrkeOzkOS0nHUDgP5T7Q==
=/N4G
-----END PGP SIGNATURE-----

--x4cmLCoCRDU6rA/K--

