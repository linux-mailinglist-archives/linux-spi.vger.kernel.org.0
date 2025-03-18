Return-Path: <linux-spi+bounces-7210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A32A67CE9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 20:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541683B25E2
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B82139B2;
	Tue, 18 Mar 2025 19:13:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCC2139A2;
	Tue, 18 Mar 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325198; cv=none; b=gRha1jCYNzSsnocXemWLXeenX3Vr1oisLHjWyesCXYF9WFekipKJLfC1YqMSG6kSOU5nL2vhnEddYC1/AMk3lz/0O3ih8tH0xednmWg7/YKX+IF6CfJXvZI4wEavxBzjRJD/9tsbtdAI+4wdop8w/Fm8qkkiI+Hp0dS5Qg4RD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325198; c=relaxed/simple;
	bh=8wTedWLvcS9YJAHF+ZNeZe2q8fASOnTz6qRoYTkeLWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+/zPrMfZUdljvyg5Itayydu9nL2E8rZPs++LOV+kj0BaBElvfI+enBXHDpVi0fUxurWQrIfCGNLiLVw/lT1vw7Ye4wfBAx5qzyQksMa6QXEiU2H67qW21ZrjT3xVk0Mr5DGvj/Dp4W0bAhZpNYSB+iSb4kSv2RJmyJcTKJOWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F761C4CEDD;
	Tue, 18 Mar 2025 19:13:13 +0000 (UTC)
Date: Tue, 18 Mar 2025 19:13:10 +0000
From: Mark Brown <broonie@debian.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Breno Leitao <leitao@debian.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, jgg@ziepe.c
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
References: <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XIRHKOAFtKcUKZqC"
Content-Disposition: inline
In-Reply-To: <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
X-Cookie: Swim at your own risk.


--XIRHKOAFtKcUKZqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 08:00:05PM +0100, Arnd Bergmann wrote:

> That does sound like the easiest answer: if the spi controller driver
> knows that it needs a reset but there is no reset controller, shutting
> itself down and removing its child devices seems like the least
> offensive action.

In that case it's probably more just refuse to probe in the first case
without the reset controller.  Given that the device isn't working at
all it seems like the hardware description is broken anyway...

> No idea if there are other spi controllers that do something like this.

I'm really not thrilled about adding runtime error handling at that
level in the controller - it'll start to get into policy stuff if anyone
does something clever and realistically it's all broken hardware
description or very severe physical failure type stuff.

--XIRHKOAFtKcUKZqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZxcUACgkQJNaLcl1U
h9D2AAf/dcmiOcYOqIN2/BwSZjt4h18B3OrnfoCLBAEpCGkIzCyP/u8pyZOtbA0c
suiHpLtVriTdLzLusypmh7oFOhXa+fUNfnyRvgJt2DfJiKxPHQsEUaOYQWZxpz/C
k05RPoaRCDv2XA8QE47ibiBgW+v6KMcWBaZa60ix/QrcqdwxNO/DSro/6xfl6aHg
Z/un/hG3ODxg6KSPC8/pFTZKP+6pGBTslVSNr1b2C5IhpdFovL73JvxNKXmvFi1S
nt8G77PPDeIUkuQJ6gruZeHD4Bo+IQ/K50kyRu2gj4pwYJTTRhLo9v+2cW3yVVb8
xK4V3Sg6oOQSo4X4kYrVOMnym1/nLA==
=hEhA
-----END PGP SIGNATURE-----

--XIRHKOAFtKcUKZqC--

