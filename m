Return-Path: <linux-spi+bounces-8051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C901AB20B6
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 03:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78A41C27534
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D6263C73;
	Sat, 10 May 2025 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAHwqVpa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE21F1507;
	Sat, 10 May 2025 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839918; cv=none; b=qEJhq0okmLdZg1jUJpBfaNM7oKQBLiMOtbHlBwO7L7FYCMvy+v7E1bjQKnacdbhLX9KgkCEU1fwWqb/zTqrCscum/nJohxbCApj9C8QFn6VwqerijwtnCrP6SHQOJVJ8ehxjlUfY4lbaKqAGIaYYBEjTlx2WxztKdid+DmZp5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839918; c=relaxed/simple;
	bh=yWNHjmwW9VsY6glrAg1UgBAK/oAU6eV1FZfNUgwyLLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t62a2ap2CazhQEPuFZTp0Et/WwmJuDwnayAxYQQhM9vWDiAv6JnY8PlOa7zE8rSPVVIBHrxml2ZUhditAi7C3o+u9MvZaR570iHxHJQyRmPYDLPCcHcQ60j5j3rmmLLCY5UCCEQ2NkT21E4rKB88cVdVfWCpYr8BDUt9/GG6CrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAHwqVpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89254C4CEE4;
	Sat, 10 May 2025 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746839918;
	bh=yWNHjmwW9VsY6glrAg1UgBAK/oAU6eV1FZfNUgwyLLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAHwqVpa+OPmYTeTOF3uAZyF2H4hAXRZ1spCaoMTnfu37b4Ot7eoz179At92w6cNg
	 jyHcLdEd8j3OBko28P1K7y4ea0boGTCzuhXLY/4N7cqoK5C6+YLjZ9Jmf+RKAen6di
	 e620rxLGMKANV5f/Uw9oYzjmygvGzy4ESypigdBGspB2jeJdtrTuNllH3yIN4xNLCp
	 o0Ij64Qynas8CmeOW3wCqcu3zf6n8yChNQCrqHxdAzM5HaEU8/Klrf4c5kTjouyjb9
	 ZnfJN+7lIQyTj0kN58918DGD6ZYGPKG7x+dPNariC5nDbWkJqHDIu3OH3fAmnzLUnv
	 U3kRJ+ceZQY6A==
Date: Sat, 10 May 2025 10:18:35 +0900
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com,
	arnd@linaro.org, andrei.stefanescu@nxp.com,
	dan.carpenter@linaro.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Subject: Re: [PATCH 10/14] spi: spi-fsl-dspi: Enable modified transfer
 protocol
Message-ID: <aB6pa9m0emX2vMH8@finisterre.sirena.org.uk>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-10-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eHDy/O/wzZPE7H4n"
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-10-32bfcd2fea11@linaro.org>
X-Cookie: Well begun is half done.


--eHDy/O/wzZPE7H4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 12:05:57PM +0100, James Clark wrote:
> From: Andra-Teodora Ilie <andra.ilie@nxp.com>
>=20
> Set MTFE bit in MCR register for frequencies higher than 25MHz.

Is this a bug fix?

--eHDy/O/wzZPE7H4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgeqWoACgkQJNaLcl1U
h9ATVQf/ViujQ6wWUrilRw8LqA2oeHPk8LhY8ucw+I5me7zj0rDL8yKoaeNZtjCH
+wT0CIW70XthMVfnFJOXemdqWwGXOyy46igADLMlMDSo7YB04rzabrpjH2CPrg6b
SY99Rj5KOB9t8l+LRSpmDTwGwAnL8HXXNzPrT8pG/MC28XA+ISE7XBvSSW/5cSZL
Zih0iT1J6H4LuAWqbWXPU4s0OeutaTDwBvGhaP4JZhgrFc8r3jUoaZoDedIoM6rP
m7WV4Bb8KDWOPMBMa41Hl/xMr7YwTlCBGe4L/E1qxFNHnstcicFvF6vclJ6JIl8C
zkFVj+hpbFd5F2fRz5RHJm2blPrUpg==
=9NmH
-----END PGP SIGNATURE-----

--eHDy/O/wzZPE7H4n--

