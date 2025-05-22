Return-Path: <linux-spi+bounces-8260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E5AC1053
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A3D9E36E8
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650728A402;
	Thu, 22 May 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUNHEmM9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F941299942;
	Thu, 22 May 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929176; cv=none; b=t1kDhLiKkjR8Yc1kxUjdJIxny9Wp67uIHwxWGfll/ghNuCgNIxOt/O5593TLlzaPL3sDv2VgfsZDifRg7/gh+ROmZX8KZxmU+h1l2l+S9R5Ar+BRNji30S2YwuM3YBqy3uAbZQWC6Tl65uSKAhzqflLcYjEVMpmZGfUPFFaYdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929176; c=relaxed/simple;
	bh=x23FPZeEPbUJDrJ/tpjOcBaQ+IhLdc7QyoUXpM72I24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in8maFQI6RvkIudvu52kDl5TjPxT3bSCCBFGGC6FdrWNrIslk8dbQgRZnEg7inuPQrzXqwyGdxu21v8r7MRzvvJ0h3IgPhkE0EWFm0EfG2dvtm7x0NxJyrHMAADPuLmEWbP2pYC5wrrRsgfaWNfKJPvcKV0XemeO6jrOK3TADJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUNHEmM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C20C4CEE4;
	Thu, 22 May 2025 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929176;
	bh=x23FPZeEPbUJDrJ/tpjOcBaQ+IhLdc7QyoUXpM72I24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUNHEmM9wmT/cX42N4vNVY4CWi8ZyARLbeMEOicfgyN4H3Jk630NHkJw4W53j0Mgz
	 GIArCDpnmFWb38Eve0kgD8Ntwn2sEEidi6so77vpxWEVj629WpXFUjcNB+vw2zmOLy
	 H9oOo2GpSP3CuZPREwQ3FpDr2rdG0BTvsNGp7IwbnkdxrZ1wiRyHew80tn5Rldy8eq
	 ga5svPQDayvr4dWNbBz+382JVHeZFdNM+NZ7mCoIK26EFvNxPofICgUFT2z9bGWeJw
	 3Gkh89R0veSSJ9TUGm9U5xAKGgdCVT/xkcak+/PEPkpYr7A4Nsc4oPBr1PW4UYePL9
	 JrQxQ92s6z5eg==
Date: Thu, 22 May 2025 16:52:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Message-ID: <20250522-dropout-hertz-6f1db9256655@spud>
References: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yxTtStQQAneF1nFt"
Content-Disposition: inline
In-Reply-To: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>


--yxTtStQQAneF1nFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 04:17:45PM +0530, Amit Kumar Mahapatra wrote:
> The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
> one reset entry. To reflect this, the maxItems for "resets" and
> "reset-names" has been set to 1 for AMD Versal SoCs, and the minItems for
> these properties has also been updated to 1.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> BRANCH: mtd/next
>=20
> Changes in v2:
>  - Removed "resets" & "reset-names" from required properties.
>  - To address review comments, removed "maxItems" from "reset-names".
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/D=
ocumentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index d48ecd6cd5ad..648b8452877c 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -17,6 +17,13 @@ allOf:
>            contains:
>              const: xlnx,versal-ospi-1.0
>      then:
> +      properties:
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:
> +          items:
> +            enum: [ qspi ]
>        required:
>          - power-domains
>    - if:
> @@ -132,11 +139,11 @@ properties:
>      maxItems: 1
> =20
>    resets:
> -    minItems: 2
> +    minItems: 1

I think you're still missing one of the things Krzysztof requested on
v1, cos you reduce minItems for all platforms without restricting
it back to 2 for non-versal platforms.

>      maxItems: 3
> =20
>    reset-names:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 3
>      items:
>        enum: [ qspi, qspi-ocp, rstc_ref ]
> --=20
> 2.34.1
>=20

--yxTtStQQAneF1nFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaC9IUwAKCRB4tDGHoIJi
0p1HAP0fagpJMJCCCN+KFsXN+l8kHvHQutw4FibTTJ4qEE8VXgD9FJ+0yUyswsFI
ILKnaWZg5X+qM5Icjp78cOZLteiywgI=
=rHOR
-----END PGP SIGNATURE-----

--yxTtStQQAneF1nFt--

