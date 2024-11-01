Return-Path: <linux-spi+bounces-5588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0448F9B9556
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1091F217A5
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DB1C7B82;
	Fri,  1 Nov 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl8Bgwcw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C61798C;
	Fri,  1 Nov 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478459; cv=none; b=e1+BtKhvBRg31EicmQaPGIPQMjta5yAzkq7m2+y9jC0XryAWWU5TUsukUVxysxpulbXwhX5N7uqrJB4pdwEiL3YedUykpkIUJm8ATsM8IedIP2L+5p7byl3IubszJSN5VogvRBoer/1uikX7RmCThLrMb4pgBxkuspqf1S2AEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478459; c=relaxed/simple;
	bh=kJqFcsvQINdidT98+YNnLof9J1GKlvt9L8buCuMsEtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jetXeJeFRbPirzuNu2YeV0JbvVFV5TzgblfWMCATloYUwYjhU83H1JMrKRT8OMxU6dHGnlWodr4wUczHPUWwBDsFEXYboWHl3DNcuf1C2hPz+LgiZOAOQTE1hz0U1Jkbs5TYZZHRGgNwwurE+slkZXSk88CPPPOSn6lkoze/uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl8Bgwcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7D2C4CECD;
	Fri,  1 Nov 2024 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478458;
	bh=kJqFcsvQINdidT98+YNnLof9J1GKlvt9L8buCuMsEtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sl8BgwcwXkDpC76XnctTpLrhDP+mSRqYETjfbM1UA5+8kI2Tu+SjqUw0bVQd8+nwh
	 u+6SaLasKcLMdvxgiafbTqYANY03f+frzcUtYQS8iHWY+jhd5/VenwNIipiUFtav9x
	 +LSrAOWO9sqokkZbHz0/W2pvEtXOGRacCwjJMZEgqGEthKKvqAj9r2eZzHBLbV1JTf
	 Xy9HiY8jqSYtJXuz3hNEAhL2Vgcz857CwP1LqsI2y6s7kRVh5moCZFlcaWzjfWGqo8
	 wO1cf/hsOhe09GBvvGrpm9fyAkUa7J7WZBLE9xIlDhct3+N20bG7TtvG2Evoj/eez2
	 kva02sLNcG4ag==
Date: Fri, 1 Nov 2024 16:27:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <0b4901b4-8cb7-49e2-a411-a6c57b9edd97@sirena.org.uk>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
 <e3008c6b-ba71-46cf-810b-053dbafe2cfb@sirena.org.uk>
 <20241101161905.GB194146@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mRv77eGBnhX9W2oC"
Content-Disposition: inline
In-Reply-To: <20241101161905.GB194146@robin.jannau.net>
X-Cookie: We read to say that we have read.


--mRv77eGBnhX9W2oC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 05:19:05PM +0100, Janne Grunau wrote:
> On Fri, Nov 01, 2024 at 04:08:20PM +0000, Mark Brown wrote:
> > On Fri, Nov 01, 2024 at 03:25:04PM +0100, Janne Grunau via B4 Relay wrote:

> > > +++ b/drivers/spi/spi-apple.c
> > > @@ -0,0 +1,531 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Apple SoC SPI device driver

> > Please make the entire comment block a C++ one so things look more
> > intentional.

> I did after your the same comment in v1 but reverted that since
> checkpatch.pl complained. See

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=a674fefd1732#n3742

> The inconsistency between *.h and *.c is surprising. I'll change it and
> ignore checkpatch.pl for v3. I'll address the other comemnts as well.

Did you make the comment block a C++ one or a C one?  The SPDX header
does need to be a C++ comment (//) for the SPDX parsers so I'm saying
make everything else also use //.  There's some constraints from tools
that consume C headers but don't support the C++ syntax.

--mRv77eGBnhX9W2oC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmclAXMACgkQJNaLcl1U
h9CKEAgAgU3tdPmqQKdOXiFwpZBujNpETg0Fgi0njVkztO2Zp9Wk4RNoW6rfq2Kj
L4izInHsvBx+vaOZoym2NKgYrrjTMiETjR8u4K+5NP0X0FCqOS7jKAl+Zzoh5m9p
l15LtYap0VAv5Ac10zoLbvPX1GtzC6R36fPMvxAXQ36OlI4cPevqk8IAo5KhAis7
NPe8+92HTdTYnAkV+m3fqJHgJXF3UaQyWSFElHJO7CpCC0XtN9Gu8dJ5Qf5lpR7P
y9Pgm23VUmIHKTX6EQXWwooHGme2PxqjIoPxV2/evnFJ2XOukZYe96S33saXLJHC
rRqkV1jhePyVNP4tSN4KGHSOjtLH6Q==
=GRtA
-----END PGP SIGNATURE-----

--mRv77eGBnhX9W2oC--

