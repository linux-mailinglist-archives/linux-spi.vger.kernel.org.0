Return-Path: <linux-spi+bounces-3733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007692652B
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B571C20DC0
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED67181CE6;
	Wed,  3 Jul 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN/8Du6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF50181BB3;
	Wed,  3 Jul 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021457; cv=none; b=MX3wIWOgLkTwJ6z+B1whOXtyA2AbrIMNSLsAQZjiM4SHtZeSAWBPlEszBsysNhLMuGPH2SqVD494oR2ke0eRuWp9mh141iMntfgnCiXH4/2D5hgri8dYp7qXe+NeRJU6pS6kHJsnT6ZXqj066W6ievJAiVI9rCEv13TSAuPCCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021457; c=relaxed/simple;
	bh=jYmjQiqQpad3hkViZYZAMJQKoWXm0SiaRxoFOzHBIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCS/QPVmZyL6um7saYv4rA9g8Sit8LQ0ngjrBP5rclwhDihJQ4QawTxhWY6ued99maT6k3krZvESwmRNOZQE6g8cT/m7rNs6r5lK4Zza/BdcwW3B3UIMxIW8/EsJF7j6XR5jn5DkgbUMKqK7Y/wd1zTUHXKq6ORDAsP4C30xjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN/8Du6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A0FC2BD10;
	Wed,  3 Jul 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021456;
	bh=jYmjQiqQpad3hkViZYZAMJQKoWXm0SiaRxoFOzHBIkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN/8Du6HCu0Gdq60W5VRZIsiUC75cPPDb1SqJ71UnLu5D/FuILg5+f1ffm/OPABTX
	 UXpH7GXqZBV1Ud3d6BxKH8xViZ1NltX8TFiwETF8F3DqQou2Xf6IITWZpnw1Bs4oST
	 eYLL2ZmBdYkUcdUSS3hSNlaNnStaDj3BDtBwQAP59T4yaIRx4N5RxKhdY9CdzWLQyo
	 MyNMGBn9r+gkEFKA7NberWi8XPb5M1aFQLOh/WP9xZ6VjkdInS0U3ZNygmv2t6DAq5
	 xbSdSmT1I4e3VqzDwXWRTxYSRx6sy8ruDWf9XXreCz18zkZCNaAjgHj4DQsjzO5Vjx
	 dcrcBY19oBXuw==
Date: Wed, 3 Jul 2024 16:44:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 03/27] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7.
Message-ID: <20240703-turbulent-geologic-fdcb698a4b55@spud>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102640.195431-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HPDmH2zYVKMCfEhh"
Content-Disposition: inline
In-Reply-To: <20240703102640.195431-1-varshini.rajendran@microchip.com>


--HPDmH2zYVKMCfEhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 03:56:40PM +0530, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v5:
> - Corrected the order of bindings.
> - sam9x60 bindings in the dts and dt documentation in future series.
> ---
>  .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.ya=
ml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index eb2992a447d7..f466c38518c4 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -23,13 +23,20 @@ properties:
>            - const: atmel,at91sam9260-dbgu
>            - const: atmel,at91sam9260-usart
>        - items:
> -          - const: microchip,sam9x60-usart
> +          - enum:
> +              - microchip,sam9x60-usart
> +              - microchip,sam9x7-usart
>            - const: atmel,at91sam9260-usart
>        - items:
>            - const: microchip,sam9x60-dbgu
>            - const: microchip,sam9x60-usart
>            - const: atmel,at91sam9260-dbgu
>            - const: atmel,at91sam9260-usart
> +      - items:
> +          - const: microchip,sam9x7-dbgu
> +          - const: atmel,at91sam9260-dbgu

> +          - const: microchip,sam9x7-usart

I still think that this particular compatible shouldn't be here, but I
did say I would accept this version.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +          - const: atmel,at91sam9260-usart
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--HPDmH2zYVKMCfEhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVxyQAKCRB4tDGHoIJi
0lMdAQC9IlgMexaIHRE/kzioxuHqnOOQ4p5nqh5Iwz7U7KIhAwD/VwBipX8VhBQg
Sb9kTKARv8FnQcLhLcFDHHwB1UA99g0=
=0ChQ
-----END PGP SIGNATURE-----

--HPDmH2zYVKMCfEhh--

