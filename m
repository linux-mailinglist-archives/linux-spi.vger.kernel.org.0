Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4251F442D17
	for <lists+linux-spi@lfdr.de>; Tue,  2 Nov 2021 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKBLur (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Nov 2021 07:50:47 -0400
Received: from www.zeus03.de ([194.117.254.33]:54568 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhKBLur (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Nov 2021 07:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=dN9MYJ4hkMa2VeKQrok5+AhQyNq+
        WxeIgQN6Qx6FS+Y=; b=V6tP6HsdN3Xj6iLwUvhxiY4tcwSh5biRiwe4NwNydSem
        OSUAKddVbsfz9ExrsubzphmbNQ4SuIbUDhG3GWyVCxcfCUPoGqZoFd8pTEqtgAZN
        eO+o7DQebaG8rWHzEe+5zfLTtVGzQ/rjIuIMp0B/KJD1YdwS4p8YJmZlA/Gy23s=
Received: (qmail 3432356 invoked from network); 2 Nov 2021 12:48:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Nov 2021 12:48:09 +0100
X-UD-Smtp-Session: l3s3148p1@6ngQ3szPvrEgAQnoAGZOAQNlyaw0xFC0
Date:   Tue, 2 Nov 2021 12:48:09 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <YYElefbpP4pwfmUl@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xw48OLVEQGVpdzaE"
Content-Disposition: inline
In-Reply-To: <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Xw48OLVEQGVpdzaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prabhakar,

> +#define RPCIF_PHYADD		0x0070	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> +#define RPCIF_PHYWR		0x0074	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */

Nice detailed research, thanks! Minor nit: Keep the sorting
alphabetical: D3, E3, V3M.

> +static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
> +{
> +	u32 data;
> +
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000022);
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000024);
> +
> +	regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
> +	regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
> +}

Still magic values here. Don't you have them explained in your Gen3
documentation? It is tables 62.16 and 62.17 in my versions.

Other than these, looks good.

Thanks,

   Wolfram

--Xw48OLVEQGVpdzaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGBJXkACgkQFA3kzBSg
Kbai5w//U9777KhbnAVOH5ipoN2F3nwqrx58di9AO1NxfqlO2pTx9hlFix1jbQ3m
BMbw0km4viA9iT8XWRI1GsI3EkxIP2HKQJKIww4vxziDvwmT5KtUWzFcvqc6/SE0
Z8i1j9swoSfgJo0ZFeAhPjNl4YYtsf2ESUl1Wx1xFQc3oGDzsRHUULw5SugbX79H
qgER7VTWeZhL4eQ1rBUCVVY3G2JPtsLhYZ2jf72jUDBIRS39/BlyaCrSETwzYVcH
HRGodyfWogpB7t36UdbxesdWM+OMnKM0JCKZEf30sQeFp5YaTqcLYBoVvwg+tePC
y25zwria2RbGl5FplptuDnj7cg1Khpz/n7uXCmeaOejk8yYF8DR6g1NET4Neo1Rz
lXlukauT07VLU47RuuQqlg/4z39ai3DphF4ew2qMTSh4Sz11sAn9F3+OEPUuMUiG
JIvu9CVrie13frUtSd7Xc2M897hyJMP7lKiUP2jrw5klHFPZH7yryCMvKeXEOALX
rv0Jp10phC2oBtO6HjPlXIQUCcVnHe2BUXAISMDN6l1McnR16SoDi0F00d6Z9YB2
G3Svf/sfaN+As5bNqkywaalSVfvt8IfqxqXtYRfLyKzwJCUY+f8JhF75sgX4HbGr
eDYheRfVDVZHewRUDRkdYXtyBlczYwo3q6pgYOCW3gOJ9k12g2E=
=45MZ
-----END PGP SIGNATURE-----

--Xw48OLVEQGVpdzaE--
