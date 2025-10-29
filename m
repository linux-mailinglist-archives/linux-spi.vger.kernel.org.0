Return-Path: <linux-spi+bounces-10910-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60749C1CB46
	for <lists+linux-spi@lfdr.de>; Wed, 29 Oct 2025 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E41627C5E
	for <lists+linux-spi@lfdr.de>; Wed, 29 Oct 2025 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF9354AE5;
	Wed, 29 Oct 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW48nfcn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395333F394;
	Wed, 29 Oct 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760734; cv=none; b=Rm4Qw004WKuTTY1qOQMTGrB29lEJh1bvFbqY4RQOrzY6zUMPD6I/xEjAEENvK5VBRqDrtd99RNOlqsreXy/uD3EETjfKK0k9ioE3OJLUqlZ1F5u8tNYjS8JtM5tptVXcRElHKVrst2Toh1aVm01pxrM0R2BZSpYUYC9KJRRVqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760734; c=relaxed/simple;
	bh=ZTqNfE12/OY2hJBlOM+SDakOKIOgcInVy8P7IwXldec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeIPspRRhu6/RxK2p7y2kuRKfYlvU4R/ZwFW+zwA2aYQgHYOLJNTDZK8Xg3aQKkDm0o36lq5VWtJmb8OlXR+0M9OeKHNtdm7P50AP0krFJVwbHfoAkormsDImurY1JO4DX7ANigsjX/k9d9Rthw6RTj8ZsFnvD2gRBdNadoxj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW48nfcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C137DC4CEF7;
	Wed, 29 Oct 2025 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760733;
	bh=ZTqNfE12/OY2hJBlOM+SDakOKIOgcInVy8P7IwXldec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MW48nfcnhyPke7+bwVWNs4hq0w1hddXCPFQBiJGapm/WvzmP90voWL2BCmSFCVz9Q
	 kJ7nfZH0bmYJUy9xLw+A72lHekoe+TqVkhIhFrg74+PtBufx+GCF1e1nuNR2W9mRw2
	 n/SNJ7loGvcQdkpKVoYrCnZhu0qKWHM1toNSznvV4J4R3aDuKZPQAkZy9ifJcDcHGb
	 oj/6X25NOIE/IRJI3OTS7nb4IDQuVFAbLb1lvdxG60eF5MNFMqUF26S2Gt+QsOV8fY
	 fgLr+kB9wbO0lOpChRjhJC3WNA0PUBSPrUUDmeLhtR4xMnHWqEI00CwG4EJ/2h7dL8
	 fvCXCGW9Api7Q==
Date: Wed, 29 Oct 2025 17:58:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
Message-ID: <20251029-relieving-prude-c097e63f368e@spud>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251028133151.1487327-12-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FWiBg5MDrLC1yaeJ"
Content-Disposition: inline
In-Reply-To: <20251028133151.1487327-12-cosmin-gabriel.tanislav.xa@renesas.com>


--FWiBg5MDrLC1yaeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 03:31:42PM +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals.
>=20
> Compared to the previously supported RZ/V2H, these SoCs have a smaller
> FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> being the clock from which the SPI transfer clock is generated, is the
> equivalent of the TCLK from V2H.
>=20
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> entirely compatible.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 62 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yam=
l b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> index ab27fefc3c3a..65ba120a6b23 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> @@ -9,12 +9,15 @@ title: Renesas RZ/V2H(P) Renesas Serial Peripheral Inte=
rface (RSPI)
>  maintainers:
>    - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> =20
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: renesas,r9a09g057-rspi # RZ/V2H(P)
> +    oneOf:
> +      - enum:
> +          - renesas,r9a09g057-rspi # RZ/V2H(P)
> +          - renesas,r9a09g077-rspi # RZ/T2H
> +      - items:
> +          - const: renesas,r9a09g087-rspi # RZ/N2H
> +          - const: renesas,r9a09g077-rspi # RZ/T2H
> =20
>    reg:
>      maxItems: 1
> @@ -36,13 +39,12 @@ properties:
>        - const: tx
> =20
>    clocks:
> +    minItems: 2
>      maxItems: 3
> =20
>    clock-names:
> -    items:
> -      - const: pclk
> -      - const: pclk_sfr
> -      - const: tclk
> +    minItems: 2
> +    maxItems: 3
> =20
>    resets:
>      maxItems: 2
> @@ -62,12 +64,52 @@ required:
>    - interrupt-names
>    - clocks
>    - clock-names
> -  - resets
> -  - reset-names
>    - power-domains
>    - '#address-cells'
>    - '#size-cells'
> =20
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g057-rspi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: pclk_sfr
> +            - const: tclk
> +
> +      required:
> +        - resets
> +        - reset-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g077-rspi
> +              - renesas,r9a09g087-rspi

Do these platforms have optional resets? If they do not, please add
"resets: false" & "reset-names: false" below. If they do have optional
resets,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable
If they don't, you can apply the tag when you add the ": false"s.

Cheers,
Conor.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: pclkspi
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.51.1
>=20

--FWiBg5MDrLC1yaeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJV2AAKCRB4tDGHoIJi
0nFGAQDSmQ4OK0aex2kkGKOPqcTZtWEKmOCHzGqia+7z1QcHGgD/VQwGjfiKeEGv
C0Sz7D4lzzgi1XrCQm0Ulwe35AHLLgY=
=LqV+
-----END PGP SIGNATURE-----

--FWiBg5MDrLC1yaeJ--

