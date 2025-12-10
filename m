Return-Path: <linux-spi+bounces-11856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E885ECB3C59
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AA8C3015627
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381452F7ADF;
	Wed, 10 Dec 2025 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhcWEI0u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BE283FC9;
	Wed, 10 Dec 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391794; cv=none; b=P1le6VFTIGw4Oyf5SNb8UVEIc3eT489u6I8GOg412KiRFSemQhs2p/A/MMS8VpSYR5LWeqU09U7d8sVSuEEzvuEI68n07Qe4ismgRUvsckJTCWLRSPtOf9G0NOfv2rFIPt/9iq1+ek2KLiW2/XC60hkQygTUUgQCRmjfbzCfSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391794; c=relaxed/simple;
	bh=EKm0SGHZ3KmBRr79ByTOZgV5jqb57ykeH76XMVwzoOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze2aOWbqNoPvkV2e2vsFauMZfW6GQIPqikYVZ6mz2s+uvjIUOIDKI8v3Ma69w/g7xLm1s7Oz9HHwJjLmTOFFh8vAHNhQt5a4oT+nrlWknaonUG/0e8rXfND565HLS4lqy5i3Stexbvy3N3/oTGQAYVjoRt741chzhXSmJ8bDjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhcWEI0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E11C4CEF1;
	Wed, 10 Dec 2025 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765391792;
	bh=EKm0SGHZ3KmBRr79ByTOZgV5jqb57ykeH76XMVwzoOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhcWEI0ua2L36FHVg/O/UxjbMrk2/YUwOZ8T9/Mt4l57S1EgcwAZTg6z7iD9d4UW7
	 6CYkuPy7RUX17NBnOCKRgLPjV0N4ufCgCFpMrkbU2wKpxlk3P3Ty6IN4w6VgPDKrQA
	 ax0ucZjiR+R9P0EgeKG8F5r5kUZD01XmEXJvhmTdzJzVDrJgzFSHidBkeFOaUCt3WM
	 AUFAaNZcEEhGce3i3fO8FR8TxJaACXrzorChAKqzDmAIMH9JIicQ2f56CL5sAmVbd6
	 qTCZbhQiI1YTDJ7HaWCx35ewY6AUTlABiNP5P/zLtsXsXfGDR8/cQ2E4j5S0UsGmgC
	 srsD4NZLE6nfQ==
Date: Wed, 10 Dec 2025 18:36:28 +0000
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
Message-ID: <20251210-repeated-perjurer-99219893524a@spud>
References: <20251210090430.3602380-1-cl634@andestech.com>
 <20251210090430.3602380-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wZGgkeRKxeoiumFS"
Content-Disposition: inline
In-Reply-To: <20251210090430.3602380-2-cl634@andestech.com>


--wZGgkeRKxeoiumFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 05:04:28PM +0800, CL Wang wrote:
> Document devicetree bindings for the Andes ATCSPI200 SPI controller.
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>
>   - Dropped the "spi_" prefix from dma-names as suggested.
>   - Updated the DT binding and documented all compatible strings.
>   - Added the "andestech,ae350-spi" compatible string.
>    =20
>     AE350 is part of the AndeShape=E2=84=A2 platform family and is a comm=
ercially
>     supported product with a fixed, documented SoC-level architecture (me=
mory
>     map, interrupt topology, and peripheral integration). Although AE350 =
is
>     often deployed on FPGA boards, the platform behaves as a stable SoC
>     integration rather than a prototype.
>    =20
>     Upstream Linux already accepts FPGA-based platform-level compatible s=
trings
>     for stable SoC-like integrations. For example, the Tensilica FPGA pla=
tform
>     uses:
>     compatible =3D "cdns,xtfpga-spi";
>   =20
>     Following the same rationale, "andestech,ae350-spi" is proposed as the
>     platform-level compatible string for AE350-based devices.
>=20
>     More information about AE350 can be found at:
>     https://www.andestech.com/en/products-solutions/andeshape-platforms/a=
e350-axi-based-platform-pre-integrated-with-n25f-nx25f-a25-ax25/
>=20
> ---
>  .../bindings/spi/andestech,qilai-spi.yaml     | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai=
-spi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/andestech,qilai-spi.ya=
ml b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
> new file mode 100644
> index 000000000000..e58e6d675d70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/andestech,qilai-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes ATCSPI200 SPI controller
> +
> +maintainers:
> +  - CL Wang <cl634@andestech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - andestech,qilai-spi
> +      - andestech,ae350-spi

I accept the rationale for adding the ae350 compatible, but given the
lack of match data in your driver, you should pick one of these and have
it be the fallback for the other. If you pick ae350, rename the file to
match (since that'd be the "main" compatible then).

pw-bot: changes-requested

Cheers,
Conor.

--wZGgkeRKxeoiumFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTm9rAAKCRB4tDGHoIJi
0v7OAQCnOjpxudD1hw9A8eh178DV9YBX6taLIXzefdCL1xVOsQEAtwrU1fmPGvvk
fs6/O1V6gi5b8oUf2lkqaFbHsrgUPgM=
=jnqp
-----END PGP SIGNATURE-----

--wZGgkeRKxeoiumFS--

