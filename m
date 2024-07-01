Return-Path: <linux-spi+bounces-3710-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E791E1ED
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CAF287B2D
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264816089A;
	Mon,  1 Jul 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQuibPTH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B61160885;
	Mon,  1 Jul 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843045; cv=none; b=j3+bncp8X4TRjUMtaX+OJu8CNc3IURO1YQabCSWcCwR2ZpzotA5r73yC4fPIxf4DYSNqMhb+/1h0cXiKOMD2cTukMVTakqYjVKMlCSTikhwQ7IlvNVtqM5bjwGQa7birEuaT7/JE6FVI4x6Hp2/WnuPSpJ/G0nKF3q6J4QcsH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843045; c=relaxed/simple;
	bh=ON+nntxM1A/nZjP7xkxPPcVzGNlKwHXzUiAQYpUlRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryPzEJz8A4/f6RvTt5anCRblgn9tPBmfm6rYvt6r7XLcve98ytNH/DYIFhGnhUEStTkOj4n2Pylla539Ec78zraGq4CX3SOfGG11XVbBhWXMjg7bmbPEV1kyRZt8VMwHrKKlHg8yeKYqd+PZz6BzNFxmGBN6cLoeqolLowK79SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQuibPTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78217C116B1;
	Mon,  1 Jul 2024 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843045;
	bh=ON+nntxM1A/nZjP7xkxPPcVzGNlKwHXzUiAQYpUlRgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQuibPTHJ3nSdk+Z/Pjt6EzKaXmviM6McN6GlBzArW9AfjD3jubpGYckP9EydFHM0
	 75DmM9bJRkl5+nyem+uXsb6cFEbnvfQ5IkV6lc1Ql+TBeYajAsvZ+wD1hJguSXeEOM
	 1ej8+wbLVzMZvKP/jVOCMH+bCVVJbswstmqzYTJFm6WCahnXKGnGy+mt37++m/Us+q
	 IC3s9/+D6ueVDvXCJmbyPEo6mBAY3/ifze1Mnhb5gJY1d/tH2cL09zwTKAsa2FTBub
	 ST3hVcss6/EAxQ1VhUX6PEd2bx6jsp992CrgPeviRKWHITRqhqjsqFJWpNIe/eIMu4
	 2ETupm0lBSzLQ==
Date: Mon, 1 Jul 2024 15:10:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: snps,dw-apb-ssi.yaml: update
 compatible property
Message-ID: <20240701-unveiling-violation-b351a2514a3e@spud>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-3-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3/8GkF0jS0jmNSZ"
Content-Disposition: inline
In-Reply-To: <20240701121355.262259-3-kanakshilledar@gmail.com>


--g3/8GkF0jS0jmNSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 05:43:52PM +0530, Kanak Shilledar wrote:

$subject: dt-bindings: spi: snps,dw-apb-ssi.yaml: update compatible property

Mark likes SPI bindings to be worked "spi: dt-bindings: ...", but
additionally I think the subject should say something like "add support
for T-Head th1520" or similar, what you've got is pretty generic.
Not requesting a respin for that alone, maybe Mark will grab it as-is.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> updated compatible property to include "thead,th1520-spi" for the
> TH1520 SoC SPI Controller.
>=20
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v2:
> - Separated from a single patch file
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b=
/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index fde3776a558b..bccd00a1ddd0 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -88,6 +88,10 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: T-HEAD TH1520 SoC SPI Controller
> +        items:
> +          - const: thead,th1520-spi
> +          - const: snps,dw-apb-ssi
> =20
>    reg:
>      minItems: 1
> --=20
> 2.45.2
>=20

--g3/8GkF0jS0jmNSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoK44AAKCRB4tDGHoIJi
0i+KAP9WbgNjmAJbuYovmoWmaxtHGrw7NSki6DjRw3Zji1HEmwD+JSgByUspkeDv
u7tlU/holugHHzXnp08OUX7QEnYk3go=
=I0Ar
-----END PGP SIGNATURE-----

--g3/8GkF0jS0jmNSZ--

