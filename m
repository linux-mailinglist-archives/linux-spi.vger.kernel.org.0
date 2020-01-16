Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2613DD4F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPOXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 09:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgAPOXE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 09:23:04 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F3A20748;
        Thu, 16 Jan 2020 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579184584;
        bh=cKTUtAai+F3kwsCgiV5+gcSXb75k6M9kqJPe1f1yhys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNcjSTjqpkciihCkSGiSg3Qpg2MI1znaP2oRwTnHBuLDK0/y9OQDLcx1r3TIAFIpC
         kDnaweSlGbk4XiR9KHFbpNmCvx4DeLbO/NoKlNzkeejECdZTYwpHNejyP4T6D14gdz
         xEfoN6XswDHd8P7ChKjjKol0OT/RLp3ML4+/4JP0=
Date:   Thu, 16 Jan 2020 15:23:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: spi: sunxi: Document new compatible
 strings
Message-ID: <20200116142301.w2t4o6pg3dapp3g6@gilmour.lan>
References: <20200116005654.27672-1-andre.przywara@arm.com>
 <20200116005654.27672-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtp4obhou6ga2i2o"
Content-Disposition: inline
In-Reply-To: <20200116005654.27672-4-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dtp4obhou6ga2i2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jan 16, 2020 at 12:56:54AM +0000, Andre Przywara wrote:
> The Allwinner H6 SPI controller has advanced features over the H3
> version, but remains compatible with it.
> Document the usual "specific", "fallback" compatible string pair.
> Also add the R40 version while at it.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml     | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index f36c46d236d7..c19dfbe42d90 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -18,9 +18,15 @@ properties:
>    "#size-cells": true
>
>    compatible:
> -    enum:
> -      - allwinner,sun6i-a31-spi
> -      - allwinner,sun8i-h3-spi
> +    oneOf:
> +      - const: allwinner,sun6i-a31-spi
> +      - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - const: allwinner,sun8i-r40-spi
> +          - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - const: allwinner,sun50i-h6-spi
> +          - const: allwinner,sun8i-h3-spi

Having

oneOf:
  - const: allwinner,sun6i-a31-spi
  - const: allwinner,sun8i-h3-spi
  - items:
    - enum:
      - allwinner,sun8i-r40-spi
      - allwinner,sun50i-h6-spi
    - const: allwinner,sun8i-h3-spi

Will be easier to maintain in the long run

Maxime

--dtp4obhou6ga2i2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiBxxQAKCRDj7w1vZxhR
xRUZAQDisZVXdmeqha8atHLsAl78/m8TbSfhS0431utHf0z35AEArNAvTTDGJZT3
fIwJSFWfYpI4H2JuT4OzXW9UJtlNUQ0=
=tA6x
-----END PGP SIGNATURE-----

--dtp4obhou6ga2i2o--
