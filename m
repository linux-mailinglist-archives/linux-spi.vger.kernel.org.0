Return-Path: <linux-spi+bounces-7211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044BA67CEB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D165D19C056A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E8199924;
	Tue, 18 Mar 2025 19:16:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA615C0;
	Tue, 18 Mar 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325404; cv=none; b=KM5IrkMXC6uo8BBy0/YiiHAllN4L5EsmbBQbfy6+OgkHuZYBXqlfKt8L28iJKzSxI61lWDw8IjTP51PQicN5G8zzgf/NllAypze6HoquB+UxxOZU7dmBiyIc73HGUCjyQtl8Rrl1vyU1YVlPqIoU8almhsIIPIuDTPpc9OCJLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325404; c=relaxed/simple;
	bh=89sJZybhvqn8VMKAoelBFvG6TNx8/1Nxp66TfZ9HfIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDnbInAabSvOKKGkblkY96QA6baUtxbW9EkB56wUv9QIDep8VL2SIjPZzXtfoWN0adK0DNVPNK23dxiePytntHD/grX6xha8X99axNjI3fgpCFi5hoVO0/Cz2TDttsNKYgm1oexCSgT+nacg5zJM68J9vneQXrvXd1fK1iiAGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C21FC4CEDD;
	Tue, 18 Mar 2025 19:16:42 +0000 (UTC)
Date: Tue, 18 Mar 2025 19:16:39 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <1cd3e228-7a1a-4696-aae3-0ede63b4103e@sirena.org.uk>
References: <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <7f2ac489-51e5-4798-a38a-a8b7ef3d4c83@sirena.org.uk>
 <20250318-impetuous-vagabond-pig-eb288c@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="06Okc7PKDjPjNTC5"
Content-Disposition: inline
In-Reply-To: <20250318-impetuous-vagabond-pig-eb288c@leitao>
X-Cookie: Swim at your own risk.


--06Okc7PKDjPjNTC5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 12:08:56PM -0700, Breno Leitao wrote:

> Sorry, I am more than happy to change it the way you prefer, but, the
> warnings coming from "device reset failed" are already printed once:

> Here are the instances of calls to device_reset(), all of them with
> `dev_warn_once()`:

Oh, in that case I guess just drop it (or based on Arnd's suggestion
change the one in probe() to be fatal).

--06Okc7PKDjPjNTC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZxpYACgkQJNaLcl1U
h9B6Ogf/UAh9iu2rs/VrO8Vz7kMb4Z3hYJg/yGx/meH/M7xZ4PCyRSpBtLxJlsba
1KylyWcIRqPr3KCLurjgPRnTyeBaxu8Q0nsJyMzKi8ThewiLQlP6WvESb6uWnXDr
IM5aZKDk2DtQSdoX8bSh2Kcl5eCzpDoiswZZiAeICX/AKoOd1yyKTsYFMf1JgB38
Lzm+lxf1EyF3sd4T3amraBiuPAHpn98LpJKll18XXDtdJi6oZCueUgwePh4Jfw13
iVFYKk1D4h2GJiIVAvX95KuJbvPzGhs54syXnEI48qLEujAHiF/T/QfnnIfhspaC
Xm39wMLELjn7ZFDU6N6JZfR15RIx1g==
=tv7R
-----END PGP SIGNATURE-----

--06Okc7PKDjPjNTC5--

