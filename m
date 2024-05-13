Return-Path: <linux-spi+bounces-2833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F588C44EF
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E9280F43
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD42155342;
	Mon, 13 May 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJQBUmZX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8114F9F7;
	Mon, 13 May 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617045; cv=none; b=oJGOZWGv4Zpl3nS9590SX5zES3cUcapfZo7Uxr7+ZTTtPv0+YLQitlS7tgqeLFXotdftG3bV5Z3qUO+aMxxTIkBT+2bUqfuJDghprism5fzHy7r8CFS6WC7FH/I31c9uxe4oX3fD1tpwyLruEZWa5zb8fMyeD/EmGMTWVHjxgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617045; c=relaxed/simple;
	bh=iz6gKe5/2InAmAQEj6JDMra0XNlFlsPSsb2ffqq6GHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJTgUVxPT27ld/CNCxR7AiLsxCIMmFLmKgPV2aPc9yuSSefNzc+e/MP5VOOeKU4yWY1Hh52uCtIWc3ikWbmTjOs0D8naP71hHAHriHSHe/ExYDnctBnYoNDNhc5/8iab1uIc7A9Q+6JyTBdZrFBwCngOZi20M5o3GThJVTzKwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJQBUmZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E0CC113CC;
	Mon, 13 May 2024 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715617045;
	bh=iz6gKe5/2InAmAQEj6JDMra0XNlFlsPSsb2ffqq6GHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJQBUmZXzTCZ/i1iZR65iKFMbRctWdBBqKRZNljj9p+noqSRWQmXkwKJaN3MBfu0U
	 anmvFJolRIELG1uK2Achj/hy4DwI6C9W8v/9UN2VdZbIVAeW0LjHdVNjvCHz3horZV
	 WmhKLCLpMt7zSt4oGG2oBbQbMNc8SpVI8upNAJLZ9LaymR5n1Ta2CoSE9KecwsQ2ME
	 aKeNvTcouOTx/IahhGTeTwDEADKgk1/uAdDPSG9MM0xeFi3KdzKHKDduvdcecM+6d1
	 Z+C3FsY1sy3XDKvUrvlNf9VTN5YNQCFeyv1PXRGKRWdYpDWFZL/1ig/GA/xMZX368E
	 3s5OLstfuCdUA==
Date: Mon, 13 May 2024 17:17:20 +0100
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
Message-ID: <20240513-shredder-renderer-80f888812467@spud>
References: <20240511061457.8363-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iNrqzZLi0em8VcEV"
Content-Disposition: inline
In-Reply-To: <20240511061457.8363-1-kanakshilledar@gmail.com>


--iNrqzZLi0em8VcEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:44:56AM +0530, Kanak Shilledar wrote:
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml =
b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> new file mode 100644
> index 000000000000..94da68792194
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 SPI0 controller
> +
> +maintainers:
> +  - Florian Fainelli <florian.fainelli@broadcom.com>


> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> +  - Kanak Shilledar <kanakshilledar111@protonmail.com>

Why didn't you use protonmail for both?

Otherwise, this looks fine.

Thanks,
Conor.

> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-spi
> +      - brcm,bcm2711-spi
> +      - brcm,bcm7211-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@20204000 {
> +        compatible =3D "brcm,bcm2835-spi";
> +        reg =3D <0x7e204000 0x1000>;
> +        interrupts =3D <2 22>;
> +        clocks =3D <&clk_spi>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +    };
> --=20
> 2.34.1
>=20

--iNrqzZLi0em8VcEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI9EAAKCRB4tDGHoIJi
0jVvAQDreMdyauMLXm/MjQJ/ND97gubmJtVqz3KZ0m6Mgfy9MQD+IZ8qrPf5LryK
WZjiu6UhLbPIHSAPZ88qxmdKAbWpzAk=
=hu+c
-----END PGP SIGNATURE-----

--iNrqzZLi0em8VcEV--

