Return-Path: <linux-spi+bounces-3672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621C91C419
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0671F21DF5
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12C1BE86E;
	Fri, 28 Jun 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBIG95UM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF38D2E5;
	Fri, 28 Jun 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593313; cv=none; b=D2webenikSr63oU2RXdMFHYMZr9rqOekL4UJlgfdHNq19bE7nwsCrx+u1IR773G8wMLwejq/7jpa6RLbDcXzYwqajw+NZs+wtiWop09l745klcQst0TVrdOXokAYMlM249n7orlMP74cqOfs+dhCrBO1u+fp4yQXFute4lSxzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593313; c=relaxed/simple;
	bh=xPTahYQJelAr+V5E11fJx0UgUKke4AGftBFZip9Tksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDVXvUl7iYOE80/Izf3A8hGfDZvOHtHc8teYknsPPqiMRAwWe488RFCYY5ZacQwcXJPJxtppLhIMElXNOzBbGrkLPDxNMeJnVn5e268iuU915bDM7rqKWUYJOxlM2hBdv/uErpdVSMTBYwpVqfrC2fsz+HG5RMQuG4YemuaRuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBIG95UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADDC116B1;
	Fri, 28 Jun 2024 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593312;
	bh=xPTahYQJelAr+V5E11fJx0UgUKke4AGftBFZip9Tksg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBIG95UM2bQkGjm2FtAz7IEzUjyfJDIV3TSKc6ZjvqMuCacQ1xi2PZwCMW2GQUs5U
	 5yvMQu6Z2aRdAm3Y0j4GvCX0/vHU9Dyf3UVzMesJe4pzbcFbe30IufPxKCaPlQVKBy
	 DybzGI0pilibQLVCvg6CcdOJNBsWpbjn/bVKRznUSIbHqGog15KzVsSXVp7belElSf
	 A1WNhLne0185tQBoFJoPVej7lWzh4mZqJIlCI7GeYFCCuMh8LN6Cb494fVNIV9WKJD
	 njpKEj1SMqxCjONfgu1kV/PvpmOWJaKfnDqqGjQOLRLvuaUXRTemupatmjRn5eWxvF
	 pwgtbV7H8RZUQ==
Date: Fri, 28 Jun 2024 17:48:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/7] dt-bindings: mikrobus: Add mikrobus-spi binding
Message-ID: <20240628-cake-ocean-25363137b1ab@spud>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q7m1m69FJSotxIJN"
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org>


--q7m1m69FJSotxIJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:56:13PM +0530, Ayush Singh wrote:
> Add bindings for MikroBUS boards using SPI interface.
>=20
> Almost all of the properties that are valid for SPI devices can be used
> except reg. Since the goal is to allow use of the same MikroBUS board
> across different connectors, config needs to be independent of the actual
> SPI controller in mikroBUS port(s), it is not possible to define the
> chipselect by number in advance. Thus, `spi-cs-apply` property is used to
> specify the chipselect(s) by name.
>=20
> Another important fact is that while there is a CS pin in the mikroBUS
> connector, some boards (eg SPI Extend Click) use additional pins as
> chipselect. Thus we need a way to specify the CS pin(s) in terms of
> mikcrobus-connector which can then handle bindings the actual CS pin(s).
>=20
> Link: https://www.mikroe.com/spi-extend-click SPI Extend Click
>=20
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../devicetree/bindings/mikrobus/mikrobus-spi.yaml | 37 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 38 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml=
 b/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
> new file mode 100644
> index 000000000000..35ca2cce3b03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mikrobus/mikrobus-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board using SPI
> +
> +maintainers:
> +  - Ayush Singh <ayush@beagleboard.org>
> +
> +allOf:
> +  - $ref: /schemas/mikrobus/mikrobus-board.yaml#
> +
> +properties:
> +  compatible:
> +    const: mikrobus-spi
> +
> +  spi-cs-apply:
> +    minItems: 1
> +    maxItems: 12
> +    items:
> +      enum: [default, pwm, int, rx, tx, scl, sda, an, rst, sck, cipo, co=
pi]

Property descriptions belong in the property, not in the commit message.


> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermo-click {
> +      compatible =3D "maxim,max31855k", "mikrobus,spi";

I am really not keen on what this implies, as I think Rob and I have
already mentioned, the connector should handle the "mapping" and the
regular SPI/I2C/whatever bindings for the SPI devices themselves
should be usable.

Also you clearly didn't test this binding - please test them.

Thanks,
Conor.

> +      spi-max-frequency =3D <1000000>;
> +      pinctrl-apply =3D "default", "spi_default";
> +      spi-cs-apply =3D "default";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14eba18832d5..88f2b3adc824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15114,6 +15114,7 @@ M:	Vaishnav M A <vaishnav@beagleboard.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>  F:	Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
> +F:	Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
> =20
>  MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>  M:	Luka Kovacic <luka.kovacic@sartura.hr>
>=20
> --=20
> 2.45.2
>=20

--q7m1m69FJSotxIJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7pWgAKCRB4tDGHoIJi
0t+BAP9xCq4ptTm0LV6thbxqhsSKb00MXWPQyiah0LuqX6j+BAEA45D3y7cLzK8q
UE7G5invTOoL958xU4V3zI+AeAlTXAo=
=S7NC
-----END PGP SIGNATURE-----

--q7m1m69FJSotxIJN--

