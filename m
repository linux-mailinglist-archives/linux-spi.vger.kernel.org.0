Return-Path: <linux-spi+bounces-11761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3091CA3CF0
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97DDE3009609
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C60341ACB;
	Thu,  4 Dec 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiHahVYI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5633FE01;
	Thu,  4 Dec 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854888; cv=none; b=ALobbCUe7Z3LeCmSPJU96Mt9AxjmvZ/Poge1WLSpUvxWePe+JwIXy3kdMX2Tp+iU+Be2hEAS6nVK6eYdsQz0b3ciScBBSfFk2Gr37QaVpb53snrb3nNfEXPRCa6BtNXA27xp3qOnEM1MvL6iZwqA1I1BmdC2oMSSSym4HSJkJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854888; c=relaxed/simple;
	bh=xeLLsRWbjQjALHiUTrlrtoZ6VbalpQ7iBRIvIu/YyOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIc5aJ+NPRSv+9xSUhpJD3NNYoTqEtLOYKtNyK1QKkqVE6P/SEJWRAfIGjRgEOZW5EWfg/pkDjagorkee7Qr8GiwhDx3URtmYmBrT8k/AZx090S9//XMWemgn5ZNpliJNb4ZYdoboA+nMQEgjaIEhEGsynxojNLG/CeKOsy7Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiHahVYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DFC116C6;
	Thu,  4 Dec 2025 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854885;
	bh=xeLLsRWbjQjALHiUTrlrtoZ6VbalpQ7iBRIvIu/YyOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiHahVYI09ao2DDbBgQbzY9ssKDyQod0FvA2sD82c/at5RYtpBvLNNVxiVq1PpZRE
	 bzL0uOla9PKBXCSiBWztf1wQeK/ggzFBDZClDqJDzQLgedlfacmTOsjuVeZDJsCSVl
	 kTgWNmPTUnTainrTHhZcOYKE1FILr2cDhrPl5txXGWr8Ay4s5OjQiQwEoddSjZ5ixd
	 grO4+VWnmQfjzBWJrVklKORVgvsZ8joA/VzqgWlMtkuG4AG8DHoPSaCyFAG6QZN84Q
	 LMX1XQms5dxy5Ksza6oZGUrnSU98d+qhmxMZDMd0M8sTMWiFbZj0iFkgtP24QpV7/x
	 Igv7jEQrN5Jyg==
Date: Thu, 4 Dec 2025 13:28:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYL5BUIZoAJo6euc"
Content-Disposition: inline
In-Reply-To: <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
X-Cookie: volcano, n.:


--fYL5BUIZoAJo6euc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 10:13:35AM +0100, Francesco Dolcini wrote:

> Unless I did some stupid mistake testing the patch, it does not fix the issue.
> Here the log with v6.18 + this patch

Yeah, I'm pretty sure it didn't work.  I've managed to find a system
which instantiates the IP so hopefully I can modify it to trigger the
issue and test directly rather than working blind, I've also noticed
that we're getting

[   15.430306] cadence-qspi 13010000.spi: Runtime PM usage count underflow!

even in normal operation (on that system anyway) so the runtime PM
handling is definitely unhappy.

--fYL5BUIZoAJo6euc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxjGAACgkQJNaLcl1U
h9Dh9wf/dY6Nm8EDZlrpDbXE9eUWQTwRKYwmP7KAAAhh38EkTWrDZWXtoD17gMO5
Ac/7dAjaQRytB6uvcJvwgiCLPxKOgpoZmWQGMN0W46QsXpgCqCCmQdvfezclbFFO
mrKkRjdZh6q9/mh0z3VeVxOAKjdIx/QBxU15v2R7/qA/VtygtNzrJxaCmkhQQ7SH
PUeW/eHy4l8uMzMrdQg4gmX4pfD2wLc7gSpGzYm63S9tkC9ygntoCHGVo4tKmfet
CC8gXCsW7q7Tetcq3UMw3VlV+ikeAJjdZuoRWYodZf07bGmTslyvVkhiVezJ4BXf
R9Z5FQ+Af6dETTv1/MMbiE4RXEjKpA==
=Zi8G
-----END PGP SIGNATURE-----

--fYL5BUIZoAJo6euc--

