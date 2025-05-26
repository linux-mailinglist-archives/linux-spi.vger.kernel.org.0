Return-Path: <linux-spi+bounces-8300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B4AC422D
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5947A92EE
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F61211A3D;
	Mon, 26 May 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d11PDPZw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EE8460;
	Mon, 26 May 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272499; cv=none; b=pcWf9ZFT1QGgcUOuR/1A0kpNX3HY7nVl/0xryYILH2XTA02grIf/c6Lzt60IazNrN9CBhJy5kiIcpAC2yQur6sBaJ2p4FPmcpE5ulF4KA3Pgb2MobNzApGC8yqtOXluB4Padiv5En7kEd1vmJQ4EGJYFwtYf41OS5fEQto5H3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272499; c=relaxed/simple;
	bh=hFGRcfD0Y2n8tquVud5hBr54D9H+RrZF/YlhNIB3mp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj5LPx/91X4Pm+Iqs8JZDHdIVtMGfIKeMG+pBRMyk+agVN+sJqjHgwPex3xFwccO30aVBNafkFJ+Dtm5evx1jLXFLghMTFa3rVz6DphLrjrDkb1g3UeWwRytroXLwTXWSRwMy/fB4EE1eggp3QPTyYnp/FZa99wCAoNLZ+KRpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d11PDPZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2BBC4CEE9;
	Mon, 26 May 2025 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748272498;
	bh=hFGRcfD0Y2n8tquVud5hBr54D9H+RrZF/YlhNIB3mp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d11PDPZwjxXYqjOAS0hpdMCtQMffOYc96Z0AX5n2fka3qyWh35Qs6jXhlgTe7Sh3s
	 QEp6vRfFQbqv0L0CTkR3ujXn6IrNJVCwnZMju/6qUoTlKr+1Lb7oX+8Xw45Eh4LlsX
	 SP4TN5/frytZ2tl9d68YmZIWJkkJnrcGCr3uhm0RwJsZiDVnQzfbvon272Z3ILDM9Q
	 4RgMjjyeMZ9Fdg4CJ4Ag3ivVHKARNjrJvvWJMAKnjL7vSzRSuKV5XcOUrIy05zizkr
	 876DBdToY1mKDKetGx0LQwJMh6eBTzn5zpLatzX++1t+5o+qCBrX+KgKksbIHPtPGj
	 iGd7Td8r1h2jA==
Date: Mon, 26 May 2025 16:14:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO
 SG2042
Message-ID: <20250526-celery-penniless-adeed760308b@spud>
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
 <20250525-sfg-spifmc-v2-1-a3732b6f5ab4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3cRYTBgHkSKip73E"
Content-Disposition: inline
In-Reply-To: <20250525-sfg-spifmc-v2-1-a3732b6f5ab4@gmail.com>


--3cRYTBgHkSKip73E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 10:58:41PM +0800, Zixian Zeng wrote:
> Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
> which is compatible with SOPHGO SG2044.
>=20
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3cRYTBgHkSKip73E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSFbAAKCRB4tDGHoIJi
0vvRAQC1yxztI2Z6owktYW9zecEyYKO6H2lY5nM7yjC9X9ZNsQEAjHE9q523CcF7
ugJZyD6pN+G7L/lRxhr81CKvhalv5wA=
=aYhi
-----END PGP SIGNATURE-----

--3cRYTBgHkSKip73E--

