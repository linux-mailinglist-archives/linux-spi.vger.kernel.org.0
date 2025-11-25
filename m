Return-Path: <linux-spi+bounces-11525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA7C86546
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18CA44E30B7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BDF32ABCF;
	Tue, 25 Nov 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6croIvp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2F32AADC;
	Tue, 25 Nov 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093100; cv=none; b=danJbuNuPBZDSABn2OtPLmF5+WERcClUQRGtOOOQH99BeppA3II51lqNXlW6DbPRn+eTk7YBMhyw6l7fWvTP7Y3NAzTgwJI+m87C6tZENAsaXlranPu+Gf2XYb9PS6/vdwWgyixiyhRGCn0NT9sAM+UCF36Rc1WYdCWtGzR3WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093100; c=relaxed/simple;
	bh=EXijMCYNnJdE7UQPk8RxSZXhsEest8tLZXPwXBE3hnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4dLAaaR/oXzGZCuFqFbpjhPyGlFhvCj8kBCBZTpCiUFYgoOWXDwSXW4j87yK7Nt7hIKN77kkXqbzPI3TjHseJTuv1JuWYI/mRw++GFQCF0taDeUiuIxLAiSSlfOZZhtOOQz7Mg8MqJHykhn+g1bwrssD0XVpMpjlVIX0GyeGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6croIvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD8C4CEF1;
	Tue, 25 Nov 2025 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764093100;
	bh=EXijMCYNnJdE7UQPk8RxSZXhsEest8tLZXPwXBE3hnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6croIvphLl4gz0XbFJY54LXqq0XY8YQnGOW/3gdhkbNJrInNGzkVsMn/781hYjPL
	 tIIO3mbTV9JdfZzJ2zS9lZRW6QDnWbZTtkkWaHTPsdRnMiDw01jVABM9q/lMmis013
	 klu+MH/QI13gsHLdbHSWrmKy1/RU0kzCUwMUnpcJbDf7Wd2B7FgPJ0fnN+ic9oOxsw
	 6HDqL523hn85QspY7WFq41nuBuedq9KMJjiJokgWObDqfe7DRjI5OgNhbFFJPP29jO
	 mv/DAGskmVQHwXBc1iKrsWd6czN+ram1OOTS8dqgtqN0bvA8WWJByAXbqfyU7AGQ8R
	 KHmYScGnorgmg==
Date: Tue, 25 Nov 2025 17:51:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	frank.li@nxp.com, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: spi: Document imx94 xspi
Message-ID: <03542bc2-b124-4c18-ab3d-f18905814591@sirena.org.uk>
References: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
 <20251125-xspi-v6-1-22b22de50cda@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ec2hrEYWTjbUPiDe"
Content-Disposition: inline
In-Reply-To: <20251125-xspi-v6-1-22b22de50cda@nxp.com>
X-Cookie: Too ripped.  Gotta go.


--Ec2hrEYWTjbUPiDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 03:42:18PM +0800, Haibo Chen wrote:
> Document imx94 xspi that supports interface to serial flash
> supporting following features:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Ec2hrEYWTjbUPiDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkl7KUACgkQJNaLcl1U
h9BcQAf/esEN6KIUbIfcZ4CNvRd6y+jdOFjQMquv3oexP3VS3Gmu17eBz/Ld8kmw
b+2E1ycOtyleZkpbynrc4ozmb09WJ2M6BW/pQ8RDsaDuDvBVVI9WfM7AeocRmcNK
7ftB1tU9MjVkyJCJ9lDXVqQLJw3KfxbEa+xfdvP7Fg0LI6gQjTpAcTPd148z5Uql
aliiQJiI/T/gnYERisrOzNd0AMkODKy1L5X5Te4S6K2chWaNJHGlM8j3xBOvl7vR
71Try90Vi9hJqAdAUvfEGs8mAixJIJgUhujASO8QX0e5M+SZpY8PwneSM2LYJm/o
2in9Dupq1yTlsZ7M2QMz7lhwUcezTg==
=YLuU
-----END PGP SIGNATURE-----

--Ec2hrEYWTjbUPiDe--

