Return-Path: <linux-spi+bounces-9668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3205B371B7
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9007116FF88
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B62C15A0;
	Tue, 26 Aug 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBIWB8Cf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B4214A9E;
	Tue, 26 Aug 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230694; cv=none; b=ZxAGbuXwItn59fKU9yD5r6E46sillJqXmflxe4A2/azUz5H6fGR7auc1DNNYC1cK7XRhC/Rsb2Zkx5xFkfJXBc1c9KFnS/8nTfECoHgqaULGb7N1NkdzS+xNAfSyDQoTWNizLa4mxuoF3p+iYbko+jNXx4fMH9hu4KnZpDSAVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230694; c=relaxed/simple;
	bh=5OG0CFSumhwO6LPpaT7Nwl9tbfKtGy7nJSNDdcsM6Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYFYnjtZeNPTZisHJMLSJ3RhmxuIey1aYRVf00AmJkkM8l4kiTviNRe0wzirRzkfeUwsF7CG15Ev43RRE5CgJEIfUEMaVoExDkWFQGuKsqGRmtxEVjnQnOkYbJWj6WvW84p/T1c6DwLIQo/6p8OldfWzWIXhN/nfR/ohoem4iKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBIWB8Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72F2C4CEF1;
	Tue, 26 Aug 2025 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230693;
	bh=5OG0CFSumhwO6LPpaT7Nwl9tbfKtGy7nJSNDdcsM6Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBIWB8CfNuqO2Xt04dr1deTArEr1hsWTPwg3F+HkeDvfDwssE5q+kkFSD6kSTleEN
	 00d6M0WcGX5tfcuEb1jeRM4FhRpA1iVofSqHon/UJK8jDClHQAHt/XiSWvt6ofRRRV
	 P54jx5TwCo9IRGFD21Xt7eUWwpkaVRVhov8z8dWtJTjrbv8lQTJr7GxD0uxxNdrITF
	 Ewpw0B3LnGgv0+qIJeWk+4nwUn6zF7bU71y3GZHEnkWGofxwqw3bATe3mHa1LoUaD+
	 pBBYsBR2/A7eREM5xY6JjyJQP8jTH46SanN4fy90/GdhJPIgLp+DGPTga2bvrROvZL
	 +WxtkIB0brobg==
Date: Tue, 26 Aug 2025 18:51:29 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: add Amlogic A113L2 SFC
Message-ID: <20250826-scratch-cleft-a3f7b36a3cb5@spud>
References: <20250826-spifc-v3-0-7e926041d7f6@amlogic.com>
 <20250826-spifc-v3-1-7e926041d7f6@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nV4lczYBtuhRtLNv"
Content-Disposition: inline
In-Reply-To: <20250826-spifc-v3-1-7e926041d7f6@amlogic.com>


--nV4lczYBtuhRtLNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:10:09AM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Feng Chen <feng.chen@amlogic.com>
>=20
> The Flash Controller is derived by adding an SPI path to the original
> raw NAND controller. This controller supports two modes: raw mode and
> SPI mode. The raw mode has already been implemented in the community,
> and the SPI mode is described here.
>=20
> Add bindings for Amlogic A113L2 SPI Flash Controller.
>=20
> Signed-off-by: Feng Chen <feng.chen@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 82 ++++++++++++++++=
++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml =
b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> new file mode 100644
> index 000000000000..80a89408a832
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2025 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI flash controller for Amlogic ARM SoCs
> +
> +maintainers:
> +  - Liang Yang <liang.yang@amlogic.com>
> +  - Feng Chen <feng.chen@amlogic.com>
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +description:
> +  The Amlogic SPI flash controller is an extended version of the Amlogic=
 NAND
> +  flash controller. It supports SPI Nor Flash and SPI NAND Flash(where t=
he Host
> +  ECC HW engine could be enabled).
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: amlogic,a4-spifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock apb gate
> +      - description: clock used for the controller
> +
> +  clock-names:
> +    items:
> +      - const: gate
> +      - const: core
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  amlogic,rx-adj:
> +    description:
> +      Adjust sample timing for RX, Sampling time move later by 1 bus clo=
ck.

By 1 bus clock? Or by up to 3? I'd suggest rewording this to something
like "Number of clock cycles by which sampling is delayed" or along
those lines.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sfc0: spi@fe08d000 {
> +      compatible =3D "amlogic,a4-spifc";
> +      reg =3D <0xfe08d000 0x800>;
> +      clocks =3D <&clkc_periphs 31>,
> +               <&clkc_periphs 102>;
> +      clock-names =3D "gate", "core";
> +
> +      pinctrl-0 =3D <&spiflash_default>;
> +      pinctrl-names =3D "default";
> +
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      flash@0 {
> +          compatible =3D "spi-nand";
> +          reg =3D <0>;
> +          #address-cells =3D <1>;
> +          #size-cells =3D <1>;
> +          nand-ecc-engine =3D <&sfc0>;
> +          nand-ecc-strength =3D <8>;
> +          nand-ecc-step-size =3D <512>;
> +      };
> +    };
>=20
> --=20
> 2.37.1
>=20
>=20

--nV4lczYBtuhRtLNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK30IQAKCRB4tDGHoIJi
0mnBAP9q21gLzy77xyCZZSJg4XByZEMOe0XHyHUr6l/8gLQX/AEA5uxdEN8+9653
Kjgpi+dqVC4/8HIBfELwg25BaNiapwM=
=qzT9
-----END PGP SIGNATURE-----

--nV4lczYBtuhRtLNv--

