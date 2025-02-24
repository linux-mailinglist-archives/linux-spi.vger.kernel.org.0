Return-Path: <linux-spi+bounces-6897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEEA4261D
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E05419C478C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6431632D3;
	Mon, 24 Feb 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYhLEhGv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283A1519B0;
	Mon, 24 Feb 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410203; cv=none; b=amvzKXqUC8HNluAJu2a8KgzmdG9UFgtW3w3o0WkMJVjr2fQB+6rIuFEf4G0fzdx9JrSTHrkjgZYjjA4X+qR34CZYrWhr5uDN1okx5HpRVI5Nwh+cdSDHtvOQDBjBl9NjCfRvvI60LaEEsUl4VXzQVFx3rg8xgWcAVd1kidQenZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410203; c=relaxed/simple;
	bh=K0QZDgtlRnOJa9UjdXc+6jh5pVnTRQJroTBmUnt1KUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUkX1XmRnWYeMc+Zbe4jvPxJSQS2bcfipA/jvgojyx0Y+dmvxG4Saa2a6T+kzcJ16ttiOMuS4ATjeddUPm2HGKMIjwZHnmnvWvW2o+cfU6wp27E1Ca7mQ13d6UMm96Z6gerTgwFtVr4P1icr0pVKxNUUmzFOB78ky7QAlIOHYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYhLEhGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16421C4CEE8;
	Mon, 24 Feb 2025 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740410202;
	bh=K0QZDgtlRnOJa9UjdXc+6jh5pVnTRQJroTBmUnt1KUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYhLEhGvmlerXvKccUvJDO5vW7UdQGGP42wVF3xTZ5ePNLfIVo1SfD4etJEIBfJh2
	 bod6f/WBwQEiP6BqqKpX4nbuemuQcgETxy6G/hqyv07BRAr1xMtXGeeyxk5x2ULPng
	 GS/b+HI8rz3pEONWoQbpNorkanj2z/hD6bJysaMx2zSiizCPjJF2FJvhcZ+G/1XzKd
	 rBy/4CmV8MO1pF24/H2U99OuImN/I5n3EoArhF6AlCer31YlkVSI7UMPn7Z69/lcB5
	 X6l5FQ4SU9TQ/C0awgBQP4CJXHdgtLuQu5iXJLFHQXPHDqJOLoS50MsRN3TGKcn+I1
	 QYIMvDbRHM+2g==
Date: Mon, 24 Feb 2025 15:16:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for LWE's btt device
Message-ID: <5661510e-3aea-4c07-88d6-2c3efccadb37@sirena.org.uk>
References: <20250221155644.1168860-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PAo3YaDka89++Hzu"
Content-Disposition: inline
In-Reply-To: <20250221155644.1168860-1-lukma@denx.de>
X-Cookie: Phone call for chucky-pooh.


--PAo3YaDka89++Hzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2025 at 04:56:44PM +0100, Lukasz Majewski wrote:
> The Liebherr's BTT devices are using spidev to communicate via
> SPI to monitoring devices. Extend compatibles to allow proper
> DTS description.

This is fine but we need a bindings document update too
(trivial-devices.yaml should be fine I think).

--PAo3YaDka89++Hzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8jVYACgkQJNaLcl1U
h9CEUwf+K3UDLV64CQs6pPKuiX5rxPq6c1k7Cv1JJGogmS1dyKty9DU8Ntd0SCkh
hi3Wl+IZNB7O7xNMxLHagDEnTZVLn4JinDZZnsGy+MDj6TAN+tIfu68p2sEsLgIZ
owiKb8m67tBFstocSND9CKcQqKIaQZWT0frpri3uUn2/MN11h8nQPDDDi95+xmbG
6D3Xxt5IBUUV3UjwOkgIbfbY1BhR+GXsME8O0+Cpw4sAUNJf9YIB222+FBiG9Gsr
NW6OqfkIkWmShuwN6PcpTXUCo+++fsjbdW3VOmS8lprecvqeywBR+yOTUUV/ladG
vnD6+ooOO1TeLJjvnkmrFCPDR3alxA==
=70nJ
-----END PGP SIGNATURE-----

--PAo3YaDka89++Hzu--

