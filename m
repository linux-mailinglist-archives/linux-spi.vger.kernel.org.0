Return-Path: <linux-spi+bounces-10862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25581C0F764
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3131188F027
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E831328E;
	Mon, 27 Oct 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0N7dVIx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D633126B3;
	Mon, 27 Oct 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583906; cv=none; b=KKqnAufJE9RiXdPt1E1EO0YXW+OOEI/5BjdSwDwr7cFh9aEXoOvLQ4SftZGcuNnKnDF0YOsqBKYg+E+Yw3iWfFHqHX9R29E2qywByVVqHimhc3bhkmwwfn7KODHNr1EYLLpyA4y2SmGO8kLDm6dPQ3Fr7PFWZqWctXtqWGPYVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583906; c=relaxed/simple;
	bh=bu/lKpmMPWH4T4b2scw9A8ku2NQlDdZsGjrmXtEeFCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Kuj2T9gq/HXvIfePVG87b5uL74QfFBcPciVMkN4fKTNdDEi4xCZgSr0gQNEHhC6/RjarO6xv4EjkkHvfKTtPcQSWQe15QvDGHFvCL0Txj8QSaGsegMS/sKezFlI4nw5DZZVYR5PDytaBoQ9K8+83H72e6/EkF9kkjQgYt2l7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0N7dVIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566DEC116B1;
	Mon, 27 Oct 2025 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583905;
	bh=bu/lKpmMPWH4T4b2scw9A8ku2NQlDdZsGjrmXtEeFCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0N7dVIxW3H5gN2pyjSsDsfNPiXgjx766SAXrI8ledXe2VJ2lMPjUqpgcy0z5cRGS
	 kgIHo6F7APQLaYfucRkbBvvJLgAeWGhXoiYIVQLLLWanw7xjwioYvtYL43YusmRm1h
	 z99ObIGGqefScff7FnhiMfa+OPm5N/VUaOqjeL9npaJryV/h4LrV6PaArOi222Jmxp
	 PfEv12M4KiHnEBB+iGTKTDyDQ3zP+S8wyN72sxPggZ9WE7it1dANyVI36xAc8AVThQ
	 NDL2CdmvMXAZw8tOhaD30rhkmeFXUgnXPg00pdEm3sKrmIbv9FNuI+KOxVN562mvW/
	 Latd97tc90Sgg==
Date: Mon, 27 Oct 2025 16:51:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: spi-cadence: update DT binding
 docs to support cix sky1 SoC
Message-ID: <20251027-strangely-reverence-6f47d87efca5@spud>
References: <20251027084239.2610141-1-jun.guo@cixtech.com>
 <20251027084239.2610141-3-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qZ7N/F0wEws9F2Jt"
Content-Disposition: inline
In-Reply-To: <20251027084239.2610141-3-jun.guo@cixtech.com>


--qZ7N/F0wEws9F2Jt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 04:42:38PM +0800, Jun Guo wrote:
> - Add new compatible strings to the DT binding documents to support
>  cix sky1 SoC;
> - Adjust the configuration of the compatible property to support both
>  single-item and two-items cases.=E2=80=8B=E2=80=8B
>=20
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>  .../devicetree/bindings/spi/spi-cadence.yaml          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Doc=
umentation/devicetree/bindings/spi/spi-cadence.yaml
> index 8de96abe9da1..e75b142a1368 100644
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -14,9 +14,14 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - cdns,spi-r1p6
> -      - xlnx,zynq-spi-r1p6
> +    oneOf:
> +      - enum:
> +          - cdns,spi-r1p6
> +          - xlnx,zynq-spi-r1p6
> +      - items:
> +          - enum:
> +              - cix,sky1-spi-r1p6
> +          - const: cdns,spi-r1p6

This doesn't apply, probably needs a rebase on spi/for-next?
Approach is correct though, but it'll be a more minimal patch when
rebased.
pw-bot: changes-requested

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--qZ7N/F0wEws9F2Jt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP+jHAAKCRB4tDGHoIJi
0lwvAP9dIvvZKdNHcniRy6tvBX0PUWhJlaEexqHWrbXPKt0FTAEAkY8vPORYUHc7
VeoJdBGzXyTRjF7Wkm5YpF+RkT5zZwY=
=HLOL
-----END PGP SIGNATURE-----

--qZ7N/F0wEws9F2Jt--

