Return-Path: <linux-spi+bounces-4951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0019849CA
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F58E286A23
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572B1AB6F6;
	Tue, 24 Sep 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZKeNpem"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF41AAE0D;
	Tue, 24 Sep 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195812; cv=none; b=PXf3vJFWpeRFgc+se91E8WMqrAwrBTxyTrzGfwD3dUuUn3UVvOMC0h4zPgFbJ2/8M0OnJBqPfW+9ayFQaP3lIKjGvzA4z78tUakep55PZCQumvV9EswMtDcLAMOFwcMJlhf77GGRLZzNBQ3gZXpXX1AtLrk+zG5r0d/RVlMHn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195812; c=relaxed/simple;
	bh=5VvhCMZaeNsBAmWJBTCSPhE8m0YS7fNLFTIYRz8hII0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCIjeVvkNMc9mW3i19gcQHSpmPRSqBAwzAfUHr83+YOiVzDxsHMA3HnyFu/mcaSdFj1JpQ9a82zG8XRB1Qb/oqC7GtbSxr+q3PugjeC0FwF/s45e7Sv4u1Q6XW+QHGMyG+rlDJRw05Al1TYbbgLhhkoYLGnHVfS2wBRu00ko2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZKeNpem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D7BC4CEC4;
	Tue, 24 Sep 2024 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195811;
	bh=5VvhCMZaeNsBAmWJBTCSPhE8m0YS7fNLFTIYRz8hII0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZKeNpemH38X1KDslf8fCc73trcmd1s7gfe4cWu9EtLSOMIAEvSFCtcn8mmMAvhUj
	 g60Bl22v05/MRaNZOJnmM4lqbAk4FtU4t5Odeg1DsxjqUIVNXFtiudVoQr61635FkJ
	 Fq/w+hE6/bhCo9vPnh1+aKLEOWOuvxNhFmcrPaGJQOVYa2bE/CjXvt/eVBJTggkW9e
	 1FnPuWsUhiOE1rmdSCvu0alkUhBSks++HAOarNQXIlMbADtm4+aRWawhZ9EU6bkHcl
	 Y/9YZ7z44o01GY6jhrn7QgjNo0cmScY7qnhNNA+c4O/VkYHbxC58noQF1Fhr3u2axb
	 BfEUkdodOxFwA==
Date: Tue, 24 Sep 2024 17:36:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Message-ID: <20240924-impaired-starving-eef91b339f67@spud>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TW6iJUl9SjJzFTPf"
Content-Disposition: inline
In-Reply-To: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>


--TW6iJUl9SjJzFTPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wrote:
> Include the 'clocks' and 'clock-names' properties in the AXI Quad-SPI
> bindings. When the AXI4-Lite interface is enabled, the core operates in
> legacy mode, maintaining backward compatibility with version 1.00, and
> uses 's_axi_aclk' and 'ext_spi_clk'. For the AXI interface, it uses
> 's_axi4_aclk' and 'ext_spi_clk'.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> BRANCH: for-next
> ---
>  .../devicetree/bindings/spi/spi-xilinx.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Docu=
mentation/devicetree/bindings/spi/spi-xilinx.yaml
> index 4beb3af0416d..9dfec195ecd4 100644
> --- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> @@ -12,6 +12,25 @@ maintainers:
>  allOf:
>    - $ref: spi-controller.yaml#

Please move the allOf block down to the end of the binding, after the
property definitions.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,axi-quad-spi-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: s_axi_aclk
> +            - const: ext_spi_clk

These are all clocks, there should be no need to have "clk" in the
names.

> +
> +    else:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: s_axi4_aclk
> +            - const: ext_spi_clk
> +
>  properties:
>    compatible:
>      enum:
> @@ -25,6 +44,12 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    maxItems: 2
> +
>    xlnx,num-ss-bits:
>      description: Number of chip selects used.
>      minimum: 1
> @@ -39,6 +64,8 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - clocks
> +  - clock-names

New required properties are an ABI break, where is the driver patch
that makes use of these clocks?

Cheers,
Conor.

> =20
>  unevaluatedProperties: false
> =20
> @@ -49,6 +76,8 @@ examples:
>        interrupt-parent =3D <&intc>;
>        interrupts =3D <0 31 1>;
>        reg =3D <0x41e00000 0x10000>;
> +      clocks =3D <&clkc 72>, <&clkc 73>;
> +      clock-names =3D "s_axi4_aclk", "ext_spi_clk";
>        xlnx,num-ss-bits =3D <0x1>;
>        xlnx,num-transfer-bits =3D <32>;
>      };
> --=20
> 2.34.1
>=20

--TW6iJUl9SjJzFTPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLqngAKCRB4tDGHoIJi
0jgQAP4qT9JElUko9VSDsRLLQWSll1SEQ7ZXTfbTFIke2mfMLQEAi65j4G/1poMs
wXPxx+hlcO36bMcB6Ac4Pus+2JQInwY=
=mVJ5
-----END PGP SIGNATURE-----

--TW6iJUl9SjJzFTPf--

