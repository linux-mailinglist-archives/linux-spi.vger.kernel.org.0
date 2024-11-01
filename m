Return-Path: <linux-spi+bounces-5586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0F9B94F3
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 17:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B712284ECE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531A1C82F1;
	Fri,  1 Nov 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igi+83t8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1F13D893;
	Fri,  1 Nov 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477306; cv=none; b=S6DpmgBC+dz9JBfK8kX2gjiB1z5w5oOHYo7zBA8q0EsRh80/gyJuZVtQYK+wMFrGtAaCvAbQqe/GJfM3kBMCmW5V01TYhzJXR5X/GWWcr9RqpbrhpQuOWs0b9DujGzVzFiX8RnG7OS8SiuyrQu3xAmV5d5EUPOLfsixr4R/G9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477306; c=relaxed/simple;
	bh=z/zU3VAMR7o1s5ellyeBMQGSOHuJK6e1Il8p5hmq1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQT6ew55qEWwcnC+gSmA+eXTrHE8Pnmj4dn0tjn5PzWd6JDOpNfpFel4hqQlo5MAIk0ZsSEwD8Bvd6YIeZOMoiRSc+fF+aGNx+EJziJrJ3tUyJ51NRnWCu3j9aJIJANQFyptxVMI94K5aD5m6/QGSUABoyAjAZJkyD1VC4BwmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igi+83t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB14C4CECD;
	Fri,  1 Nov 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477305;
	bh=z/zU3VAMR7o1s5ellyeBMQGSOHuJK6e1Il8p5hmq1A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igi+83t82Hxt0inVEK7BtwfHMIYxT7T1W/IF8Lvn318KNmubbGWJJ070eXK7h+SPM
	 yQSd01WFJ6aPtEcz65508SDUNran5bN8aPnIxXn2SFiDrMtFrpBUJYagZ4KzgVj3jh
	 7Lls0s+1Ih5eZ4rn9zLCeIsUgUR/opOa9sP7r1D/ubbn7O5fZ6oaDBaWvc96uSZ1wR
	 UY3MG11aCzlzeBhawuAswUYPM2fT58m4IMaYxKkNZAxEZdTl/cYZ7cnx2yrq0wgmIe
	 P+CvxUvbmmMqES7bZu/YzvkJnLlKsYWre7ATT8FGCzcWFAXWY5j/2VAtF6sIAg1Ap9
	 Wf3b/tyZUslAg==
Date: Fri, 1 Nov 2024 16:08:20 +0000
From: Mark Brown <broonie@kernel.org>
To: j@jannau.net
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <e3008c6b-ba71-46cf-810b-053dbafe2cfb@sirena.org.uk>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxQmEEN76lEDPmLk"
Content-Disposition: inline
In-Reply-To: <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
X-Cookie: We read to say that we have read.


--vxQmEEN76lEDPmLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 03:25:04PM +0100, Janne Grunau via B4 Relay wrote:

> transfer, most of which we do not use right now. Hardware CS control
> is available, but we haven't found a way to make it stay low across
> multiple logical transfers, so we just use software CS control for now.

It is extremely common for hardware CS control to not support multiple
transfers, I wouldn't be surprised if it's simply not possible.  We
could potentially use it with compatible messages it seems dubious that
it'd be worth the time/effort of checking and using it only some of the
time.

> +++ b/drivers/spi/spi-apple.c
> @@ -0,0 +1,531 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple SoC SPI device driver
> + *

Please make the entire comment block a C++ one so things look more
intentional.

--vxQmEEN76lEDPmLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmck/PMACgkQJNaLcl1U
h9BaDQgAgY0Tgn8A8AUWpa6rhj7aN09cctz9vhkmDJR8/ez7hwonJ4BpUrS1RES8
ERU9g7IS5n2nnmq4Fw2f0G0ZlKHHprCkmj/rfCWFd5CX19kngP3ipq5DW0msYyfA
xip5+8iAvEuHEpOmrTKE0cMQ+UMGSj5841+b97jvCfD3n8h6r+veyZ/fwzo/6hsE
9CAYB4LimTQO+3qA8GCKTUIi4C3uvoBbpu+yM5spxtYAah8BRcfepv7BWvLUPx6U
58ZxNVMWMlkCWq/6F/+lenAafU0MfPWaQiumdqGgAlxifOyy0Qv+VS7toKAI3bol
7P5EiKWJAIC1VcGogoYW9JHOlGX2mg==
=K8jA
-----END PGP SIGNATURE-----

--vxQmEEN76lEDPmLk--

