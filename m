Return-Path: <linux-spi+bounces-4981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EF986DEE
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C1F1C21B9C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB64189539;
	Thu, 26 Sep 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcUSIMgk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74321186E47;
	Thu, 26 Sep 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336759; cv=none; b=chEAjupdUf9Ieuit7S7VnRtzwbdd1oHPe0CylAa8xKNtRBJpCXIGPl/VxJNFp2fe0OCfi+0/+y+et5hb6QaJJIAFgWd6GxFqEZcVVgV6n3dU5ZRm88v8PRbgQX/PL1gzT7Ek9jyTeoHi7qJcx7wzSTfl/OquRXS2b681aD4ping=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336759; c=relaxed/simple;
	bh=e/gntNiBQgCaRPooExpC06zI/SPYCIBZpwHJdV6OL0A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihmvEHrl+uBp9vJ5JvMaJgAteBZftBjLbMXAJYOp49thvnTV/9oqiwaXD5OJSAP30vObN3vhY+tGDWa8cJBvqbNe29MeAplcDuhtR52QonHUBolXjAe1RXTz0iFTnS/amKnIGugsOwHHJDgs+ajN6LGDP0nnErB1FC52L7mmjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcUSIMgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F46C4CECE;
	Thu, 26 Sep 2024 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727336759;
	bh=e/gntNiBQgCaRPooExpC06zI/SPYCIBZpwHJdV6OL0A=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=VcUSIMgkwDc5KZPM4C5+1WvSAwzn619GXNhxXc4+VSrfgfvgkOmyEcEMTPz+rK3Oe
	 EQIrGkUApcb+ZqcFPtxvV5A7/NyqjY+AeirPkQk0FuwFkXG15BNAdyiveETK0+nyZ1
	 tUVCpcv6/xDfLTaumfTn3lQnENIsbPfvv2WG0rb2joDcjyBiPR38s2WGSpoXubMSiQ
	 gPgH3Bxo8DT2shkpTFHftpwoKwaljSrJ4nYRX2LszpiEGj/y2VARqUZp03N5jH6oRb
	 4YPVz7Q1bkcjLtPbwpReGrB+h3DRfWvFhR1ZZvI+gXbIt9mv6H2qXLRbchZzy5gdCD
	 qP+8qSDqY4Kug==
Date: Thu, 26 Sep 2024 09:45:55 +0200
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: atmel-quadspi: Avoid overwriting delay register
 settings
Message-ID: <ZvURMxKGilu_XBvH@finisterre.sirena.org.uk>
References: <20240918082744.379610-1-ada@thorsis.com>
 <20240918082744.379610-2-ada@thorsis.com>
 <20240926-macarena-wincing-7c4995487a29@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aU3UVmKPQDmkhMy2"
Content-Disposition: inline
In-Reply-To: <20240926-macarena-wincing-7c4995487a29@thorsis.com>
X-Cookie: Editing is a rewording activity.


--aU3UVmKPQDmkhMy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2024 at 09:25:10AM +0200, Alexander Dahl wrote:

> This is somewhat embarrassing, because the patch was already applied
> to master.  Should it be reverted, then I would send a v2 of the
> series?  Or should I send a quick fixup?

A quick fixup is better.

--aU3UVmKPQDmkhMy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb1ETMACgkQJNaLcl1U
h9Bmbwf+NwL/UaJuHEoWm+uNNHHz3McUtlO9QHBPoFb3qobRbG4X/ON80i5y/xs4
MXtgq4shjhhndmpIwj6zPjXGtk+KyDIC/fIUDW9/Khh4t7Fol6FGuWRtfrh/SVZN
UtkkifVcl6mXRvD+f04SNeLaHp694h+x/0PU4Fo3p6TzfZU40EP5AkNlqpySJnaO
fny3gtdxhQV3ux/fxVKB/yw/1r22OwoxYXmHS59ep88z8BGXPfUTNcdlHLSNF4E1
c60H0583bxB7PVWKHgWpMT68msJIKBk7xbgE+sDQ962/K85EKtcz3M8rDHa+Og2/
OEFcNHPDCxWJioZmYLBGkvmaOUooFA==
=zAYW
-----END PGP SIGNATURE-----

--aU3UVmKPQDmkhMy2--

