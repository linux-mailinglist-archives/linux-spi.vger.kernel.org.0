Return-Path: <linux-spi+bounces-5629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADAC9BCE76
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 14:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2781C21777
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8B1D8DFD;
	Tue,  5 Nov 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4qZAbHt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873621D86D2;
	Tue,  5 Nov 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815122; cv=none; b=jV31AgDkvrSZ5TwtnL2CbsKVNkaw9qwkEkSEx9vJlLQXN0f+SmxAAPxYORoGrK3FPUlzPZaje63yOkgQJz7op6JBM4D+6PQk1z6WL1/BUnkogcxnSL+wRF69H6XjwnPmag5ANY5dVzkH9eiuNPXvkN/p8aZGpP7j0EtfDIc5dSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815122; c=relaxed/simple;
	bh=h2YyTsHPIecoq/D4+stAYCx0ZPE+tzXUnwD5nOOZyYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbTTZRaGYRkpx2Fn8XfBl2R1ksYNI9dSXy0HL7qJ7xUP1k/2LjxOIPvhOx9YuhFcVN2LyxdByFhSTeVAYm0nDDX3WurvqHcNg+rPxSOhk3ZhI4I+4PMihA7s0g3j69wXsCd0FdZYc/hxcdxIOCrDV/MFPJLUqtrdLFbohTZQ+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4qZAbHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC624C4CECF;
	Tue,  5 Nov 2024 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815122;
	bh=h2YyTsHPIecoq/D4+stAYCx0ZPE+tzXUnwD5nOOZyYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4qZAbHtQ4DIqtzwwDm32mI0YSVaHX/AgRsCjaTnM5Frn69ZFO8YlR+DmhgbOgdbK
	 oiNNvQQlmLFwhNXuwWhH9x35Frw+LJ9460iZVhOravxJ+HXGwL+IS+6c/hdQZyB6TT
	 XpPzjFLTgVqlUm/ymL5qcggAQ9d7oR41h8E/6kAh8AK62wOo5Euf2ktOWiw2/WGbaY
	 2KC0/ozgfZIdyO3hM03Y6wjMj29SaRF72pRUsbmSorcvmKwNkKIeGlfD1owws/zHcD
	 P+8xz2zgoXwyPSJyYOIZtFpFUBGNMKQMGS6gYKR2sFC8Yz4I3VVWO7EiFdrcp5Zk1Q
	 AZmI5zu2ujmVQ==
Date: Tue, 5 Nov 2024 13:58:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <947246c5-b9e6-43e7-a516-7b82136e6e8e@sirena.org.uk>
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
 <20241105-asahi-spi-v4-2-d9734f089fc9@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iENhY6dim+9r+yWz"
Content-Disposition: inline
In-Reply-To: <20241105-asahi-spi-v4-2-d9734f089fc9@jannau.net>
X-Cookie: I'll be Grateful when they're Dead.


--iENhY6dim+9r+yWz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:08:30AM +0100, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> This SPI controller is present in Apple SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). It is a relatively straightforward design with two
> 16-entry FIFOs, arbitrary transfer sizes (up to 2**32 - 1) and fully
> configurable word size up to 32 bits. It supports one hardware CS line
> which can also be driven via the pinctrl/GPIO driver instead, if
> desired. TX and RX can be independently enabled.

This breaks the build with current code:

/build/stage/linux/drivers/spi/spi-apple.c: In function =E2=80=98apple_spi_=
probe=E2=80=99:
/build/stage/linux/drivers/spi/spi-apple.c:463:16: error: implicit declarat=
ion o
f function =E2=80=98devm_spi_alloc_master=E2=80=99; did you mean =E2=80=98d=
evm_spi_alloc_target=E2=80=99? [-Werr
or=3Dimplicit-function-declaration]
  463 |         ctlr =3D devm_spi_alloc_master(&pdev->dev, sizeof(struct ap=
ple_spi
));
      |                ^~~~~~~~~~~~~~~~~~~~~
      |                devm_spi_alloc_target
/build/stage/linux/drivers/spi/spi-apple.c:463:14: error: assignment to =E2=
=80=98struct=20
spi_controller *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast [-Werror=3D
int-conversion]
  463 |         ctlr =3D devm_spi_alloc_master(&pdev->dev, sizeof(struct ap=
ple_spi
));
      |              ^
cc1: all warnings being treated as errors

It needs an update for the retirement of the old API name.

--iENhY6dim+9r+yWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcqJIwACgkQJNaLcl1U
h9DgKgf/ddf0YmZ4oEkNm4wgCTlT/ycNyO5dWuRJbH1oSBwFNktY2pJQsMx3JswW
GfOvhWqiQSN7BXsCNCYwM79OA36ABMxTDU5+YhEiZVxIS2XYyLIO18tDd4KXWYUr
D1JN7D+nGYiaLi8Cfhw3AfnXc3HFDkxW/lb0Syb+V3Z2C9ETTtpcLqqKsGZld9Go
O0mIylw6nzdoNvBOX8acNRseCjifKTS34aFp5VHBlkjHud7wcsJ4mI2YFiMDjkUB
r+3i/soG9MKgVQUVmFukVNqZQtQAgZAfj4OL/B0FK9YfC5ul9RaKbqYO8dznFUBX
o5okgT+07d5QMV/0LnBW9eHfwEy9Pw==
=PxTk
-----END PGP SIGNATURE-----

--iENhY6dim+9r+yWz--

