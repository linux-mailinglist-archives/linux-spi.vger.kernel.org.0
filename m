Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F341DCE8
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348734AbhI3PDl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 11:03:41 -0400
Received: from www.zeus03.de ([194.117.254.33]:34272 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348564AbhI3PDl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 11:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=r+o3vngVkdgztVQkxkUxvPMjJ9nS
        mdIiV96Cw1ESXyc=; b=CXiUxsT2FblaWdUcBNRW+qgmMsmmSNwCXBs3DTwU3ScX
        SFb0bWfx+QD6R2MfmlF/a2igkJAipQBxDcYehr3rhi05Ed8fZsydSIBOlYBHa91a
        mqvamJacTStj4qLZENtzL7Z49MPxeNugnjA/yO0Q9qGWFe9JuNmPTeRtGVOPsTo=
Received: (qmail 2119133 invoked from network); 30 Sep 2021 17:01:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 17:01:56 +0200
X-UD-Smtp-Session: l3s3148p1@mcROujfNQIYgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 17:01:56 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/6] Add SPI Multi I/O Bus Controller support for RZ/G2L
Message-ID: <YVXRZNxrgmfROlJy@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdec5ePrzlj11VEg"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gdec5ePrzlj11VEg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This patch series adds a couple of fixes for rpc-if driver and
> adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> is identical to the RPC-IF block found on R-Car Gen3 SoC's.

I did some basic testing on the Falcon board with a Renesas R-Car V3U
SoC and did not find a regression, so:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--gdec5ePrzlj11VEg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFV0WMACgkQFA3kzBSg
KbbtBQ//UDqnFRl9bJ/3z/krcE5cI7mn3iuGbS97ZGR6nqRDvSvmbIiQPTreCPNU
VQqMfbLoLkHM9O9u7UR7ucjggb7kveCz1wAtz4h0WPArBvFXJXbOaaeU2dodlk2Y
tYZCGkrfn5FhaRokcMK9MbIBxwwv5ZIypR1DBdyvPD5tX4QujTBrX2z/XzGkCfn2
be+IxS8ibDKnx2VwD0ErPa7la4fKcGVh+4bVd8Wn3fCC+1lTBXaQl5sIcgZnS2H0
HdhETeXxJTPLpPWKNjkYbO9gQRiKQ9iM9tg34hLjWvrgkG45LCct/Q/UTI998yeh
4OXhypsgoFKnLjNJXh3CLAV1Ud8xQvglWV5YkLEyeinTb2xdk4LX45h+DKDOmcHU
0GD2VvzY3ilwcneSAFRlae6EuJ+lvw6AingESituuIOPCtAmDbQ3MYkZsFHwDW2K
rHnVMKNT6ajsehg9jmwIBOr7zAU1YEG0WrTXDI1KzoeL8hhczcGVRnhGOv0CMSXY
tGrqEiVC9hSX6trxx60N42hLwuMxF2E4aS6mi/CsdkfPYfoOJ4YEWuvkMc+iG4mB
4znsrDwaBYF47lX96RsW6nSI8prCyOsvf42vyZ6OeWJYOOlAgBSh9wGJN2IuYeh8
BRop7XCqLmNVFAt/Q9CXDgsmXKcB+dE82t0MtavGfuwukYE01D4=
=o3Q2
-----END PGP SIGNATURE-----

--gdec5ePrzlj11VEg--
