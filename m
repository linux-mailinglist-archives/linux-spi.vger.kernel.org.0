Return-Path: <linux-spi+bounces-9441-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E2B26EFF
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C31AA4B01
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9522AE65;
	Thu, 14 Aug 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t73TiIhU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4531984B;
	Thu, 14 Aug 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196544; cv=none; b=VHtZp+mFEPs3/J9/chNLqaF3q3Y0/5NMdUrAcp4bTBtNldgxo0CerjxYM1T63wOVuVz/GbaIyTqpW9KFr8Ng4MVfOOdNm21NWEV3oSdzK2Id+FBeY6Wy1fycZ/Udl3M/y4+vIje/1D0FMlgBi0iw34nKaLw4I7hVUZe/+nHQQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196544; c=relaxed/simple;
	bh=h5MKIzBH54USG5jIpDirNZgYA2LPIdYRWDSe/7xDSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP0/um23bhixRp8vWehet/cTK3Vob1XH26gZzdG1PV9kNQ5g0L3Vj98UIhruPg2VJkNZJkdF3qRIBs55OvRvICIi8Z7OX0atbi2j29/QxA0txq5z/CufKB2rpphgUhr9rmfnI+tIIDgKuernRt9PwrV1tAzWy+f5By9Dt+Ixd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t73TiIhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED551C4CEED;
	Thu, 14 Aug 2025 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196544;
	bh=h5MKIzBH54USG5jIpDirNZgYA2LPIdYRWDSe/7xDSwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t73TiIhUJzCoPq+9VUC6Zb4+m+TIzNl29T8PDm4A733GNxGeIeRvMD9x4GcybvmGT
	 5zRpFsRM/aOBwKf3ah1kxfuOs15VEPrtmuEZi2vk4uNLai+AKQup3bjH/ic+Kpc3Vi
	 ypdN+yNVMb+tYH2Osksoi1oyLFxvWvxRtj+PRlfweHik0hrAlBpUELP6OuXiQS1Llb
	 ULsEnQE//ysL6Aey9NW9I3XwfKTCihopPsqRjZ57rOen3jqj+hqLf9K5O6gYwicCrz
	 nAlz3/9oefer1hwKCFj9x//wUad6bNmXsFINfXOJVj8yxeBFDFyHFPEAZGwUnlZClC
	 p6o+pyelPipHA==
Date: Thu, 14 Aug 2025 19:35:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: James Clark <james.clark@linaro.org>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 00/13] spi: spi-fsl-lpspi: Generic fixes and support for
 S32G devices
Message-ID: <ff52d023-7835-4398-a8d9-34a059c13636@sirena.org.uk>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <aJ4RlGvBhwRcHYM6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xRrHkriYZG5HSvu/"
Content-Disposition: inline
In-Reply-To: <aJ4RlGvBhwRcHYM6@lizhi-Precision-Tower-5810>
X-Cookie: This sentence no verb.


--xRrHkriYZG5HSvu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 12:40:52PM -0400, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:40PM +0100, James Clark wrote:
> > Various fixes for LPSI along with some refactorings.

> Fixes and refactor generally is two serise.

It's fine for me if there's dependencies from the fixes in the new code.

--xRrHkriYZG5HSvu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmieLHgACgkQJNaLcl1U
h9C+qgf/YUHsYWAj1lcGBlXsArfkeslgznqqwL72xkkaLzV5OJq6cphheT4+w87t
zOzfMQZWpWrByMZkzZI+6lFmh0zLMY+ihxUPSJZ+HgFqQAs7A8Cck+c/LDK6miqz
VWmfMTYGIWG9N8Sci1sDfhHqlVun3XuxAb27cWuNvMOO+F1kOfAYCWvhjtJiqN+G
0cR1SPYsja/J6Sqp7OCEl0xnIQv80CLyyE0VCZRh84OZxwCn++qW3om312fupOLe
mlpl0LiLia0Oyv81e6cN5p47xRT7NlQpskmwMRnX/gj6oeuiZQhOThGJynEA4XRt
VIYWYl8/Fwgqqar2GIWsWxKghPcRiQ==
=AeY+
-----END PGP SIGNATURE-----

--xRrHkriYZG5HSvu/--

