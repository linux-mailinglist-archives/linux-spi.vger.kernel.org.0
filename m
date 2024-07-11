Return-Path: <linux-spi+bounces-3834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645C92ECDC
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DB41C21DDB
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435715EFB8;
	Thu, 11 Jul 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmwMI+5d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32C16B743;
	Thu, 11 Jul 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715784; cv=none; b=UEWHf2kwo45L/JaKfkSBlbPbqwWcPzyAs5epiKlSN9jjU8UfGgUHPyQ/zERx1FpImXo3k2SlEJkZDvNyonPyCl3iH5jC+FovQzI7WSi2WLpuXuwXaNMk9SUN1mFozEaWAJ3FmDfQG/DcQPLN5Ygz3kJvzDfL9iZrw2QxruzH/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715784; c=relaxed/simple;
	bh=Jm3fjypV3N6HlvJt0y25c+PAjLhFWFvzu7Kl/s6RaTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyW1xYfm0doAlgtXi6BLh1NSzfziJUpYoPAp8ezM8pOhIgS0rDHMmwciOHAh/Sz8A9nOj/7oPAKMELeftR8TGA8GMRYoQiQVdoPjhmAU5pgBzLN3O/DPZodTmt3AZPf+bNN0vpQtbWEnnlNFfEQHvJ3fT3op4am/dD9yN554PBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmwMI+5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35202C116B1;
	Thu, 11 Jul 2024 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720715783;
	bh=Jm3fjypV3N6HlvJt0y25c+PAjLhFWFvzu7Kl/s6RaTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmwMI+5d9Th3iwz7epJYE2FbdQfTWExyVI6BF8sK97OCCVMceLgVJgO8BORqxd1bR
	 nElisC8y8rRmTrEIm49B+nKnETKCb83l9GMZ4u8Y4lWyfuQeI53CckMxpVvkW5nSTB
	 MG2w9oZSQUzL1qauOV6aA4FqSzx4zGKcbVQC2F1Q3eMsLVYhZS2ZrtRQkxpCdBbwYM
	 bWaEzSRV2JWtei0867yL3wAfZxa5RDZ1GG8SKXRm6ge8fzymJBCGeScQA5fjhMWwFK
	 RrfQo5HIGnAVTzBasaEnyVEhVBEHwjApyIg7KfpqJMVR9wmXisygBXzWiAKNMCwEfO
	 /I/3Hzipx6cHw==
Date: Thu, 11 Jul 2024 17:36:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Message-ID: <20240711-silicon-fringe-20466250f6b3@spud>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
 <20240514104508.938448-2-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="46hh1M94wZx3zWh6"
Content-Disposition: inline
In-Reply-To: <20240514104508.938448-2-prajna.rajendrakumar@microchip.com>


--46hh1M94wZx3zWh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:45:06AM +0100, Prajna Rajendra Kumar wrote:
> The PolarFire SoC SPI "hard" controller supports eight CS lines, out of
> which only one CS line is physically wired. The default value of
> 'num-cs' was never set and it did not didn't impose a maximum value.
>=20
> To reflect this hardware limitation in the device tree, the binding
> enforces that the 'num-cs' property cannot exceed 1 unless additional
> CS lines are explicitly defined using GPIO descriptors.
>=20
> Fixes: 2da187304e55 ("spi: add bindings for microchip mpfs spi")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>  .../bindings/spi/microchip,mpfs-spi.yaml      | 29 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yam=
l b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> index 74a817cc7d94..ffa8d1b48f8b 100644
> --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> @@ -13,9 +13,6 @@ description:
>  maintainers:
>    - Conor Dooley <conor.dooley@microchip.com>
> =20
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -43,6 +40,32 @@ required:
>    - interrupts
>    - clocks
> =20
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mpfs-spi
> +    then:
> +      properties:
> +        num-cs:
> +          default: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mpfs-spi
> +      not:
> +        required:
> +          - cs-gpios
> +    then:
> +      properties:
> +        num-cs:
> +          maximum: 1

So, it turns out that "maximum" here should actually be 2, as there's a
CS routed via the FPGA fabric as well. I think default should become 2
also. I can show you what we missed in the configurator on Monday, or
Cyril can if you see him before then.

Cheers,
Conor.

--46hh1M94wZx3zWh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpAKAQAKCRB4tDGHoIJi
0seiAP4il8T3aKRrsUvp/JEd1zwkEZsueHFdOCksvfA3m0mBeAD+N+60ES0F4Gdc
DJOApB7LWS5aU3t46wlPTu8y7HQE3AI=
=tLP7
-----END PGP SIGNATURE-----

--46hh1M94wZx3zWh6--

