Return-Path: <linux-spi+bounces-2834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB28C44F6
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8CD1C2323F
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861E155346;
	Mon, 13 May 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUR3MjzE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8B14F114;
	Mon, 13 May 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617117; cv=none; b=BYeerisEqsUNIEO4AQLMgG+sEuhOuTzwa7Mq4syJ/G3+t+Bv6XFXZ68R5SF/C0SOMb7WUNBFp2AJzBn9dSsWgce8g3kz43vdLKIqkYPvRppeOHmRIjnr3cWs1D2lZ0epA+xhmS2wOrDr/OxYoppBUEr5Ds08OaOzLO6ghvFXL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617117; c=relaxed/simple;
	bh=nfEM6omj7zswBVc4Pl686kAKij6wpm0T4qhFkcSb0qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol+7/p+vcMi5YTaU24uM1Cb17KA4ZU/XPtN2g8UGiGKcxzf4gSo3xkvMDoWw8olroWfhZ0uFuol+LpVa6qVGfinGkssUkwomeBWpcoj/yJYQSu/ajRF7N6lV4ng225uXqP+ZxxkGeGsslLPkSeGknHVGuEWvG0IXpvrxgtkCcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUR3MjzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A84C113CC;
	Mon, 13 May 2024 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715617117;
	bh=nfEM6omj7zswBVc4Pl686kAKij6wpm0T4qhFkcSb0qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUR3MjzEMRn7hboWJrFKHgNuNHuxB8YbFb2oJTsdaBUr1GlwBrxC/or0HOTXaI1P8
	 aQW62eUlpo9GeXTrIsZZbzni2Fg68Gu8UUm4Cwf0Ikll+w49RJJigiiUeYfbkBTtJz
	 hiI+cdEYvsh/chR2f3YcOhXLZspYAAVGe/m3zMVxZQ4kAVZR9snkFP45FgoV13oUH3
	 7y4ZCiesIrnbz4ieBxiAZLZMKHSnotTPeX5CMYcLNXVEBrUQnz0SZoYkvUYf2zGNOu
	 /MhF6d+hJSYLXkr9ZUwCIYuaMz1HfbHczjWq4o2VMit+WLOQ9XoXhuT9vIBD3nUm23
	 Wpmqmk14MN8Ig==
Date: Mon, 13 May 2024 17:18:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: wahrenst@gmx.net, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: brcm,bcm2835-spi: convert to
 dtschema
Message-ID: <20240513-strongbox-excretory-0c5313bd2679@spud>
References: <20240511061457.8363-1-kanakshilledar@gmail.com>
 <20240513-shredder-renderer-80f888812467@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YUj+nTFmPSqv1Me8"
Content-Disposition: inline
In-Reply-To: <20240513-shredder-renderer-80f888812467@spud>


--YUj+nTFmPSqv1Me8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 05:17:20PM +0100, Conor Dooley wrote:
> On Sat, May 11, 2024 at 11:44:56AM +0530, Kanak Shilledar wrote:
> > diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yam=
l b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> > new file mode 100644
> > index 000000000000..94da68792194
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM2835 SPI0 controller
> > +
> > +maintainers:
> > +  - Florian Fainelli <florian.fainelli@broadcom.com>
>=20
>=20
> > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > +  - Kanak Shilledar <kanakshilledar111@protonmail.com>
>=20
> Why didn't you use protonmail for both?
>=20
> Otherwise, this looks fine.

Ordinarily, I'd not care, but given it's proton I have an ulterior
motive :)

--YUj+nTFmPSqv1Me8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI9VwAKCRB4tDGHoIJi
0ljCAP0V69c4uPLJCyL9oAKl/1ezqDNyHKqcutlsoNbdHWwXWwEAgYGjjaMfKdNe
b8RjAxSVkvZk3xVSrCeCZSNcpmel5g4=
=rvuj
-----END PGP SIGNATURE-----

--YUj+nTFmPSqv1Me8--

