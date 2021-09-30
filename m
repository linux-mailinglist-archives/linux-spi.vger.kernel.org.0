Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8333441DC86
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbhI3Omi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 10:42:38 -0400
Received: from www.zeus03.de ([194.117.254.33]:53726 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349935AbhI3Omi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 10:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ZvuuUAw5AdmQ+JTYkJ6m1x8aRVdo
        Y2ZDvcWvQg7OFPw=; b=uy0cT/9XbZgr0mYdfwfFkaC9jCiiEzQsvUhaHfevC06L
        JpB2Ce5HRlksLwL8oLsDeYjWXKlLUfpyDj5f2u/tolIJtB+TIfO0lozqlyb8V3DE
        Ce8xg/YNqvUPDS47XRfLRmATWnphnARtcPWaqPAjl3WSEB2WtU97rUrU9Ek/QQw=
Received: (qmail 2113065 invoked from network); 30 Sep 2021 16:40:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 16:40:51 +0200
X-UD-Smtp-Session: l3s3148p1@v/frbjfNNoYgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 16:40:51 +0200
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
Subject: Re: [PATCH 6/6] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <YVXMc1A4D/y4kjim@shikoro>
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
 <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="myXSi1SOqxroiqCO"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--myXSi1SOqxroiqCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

>  #define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* undocumented */
>  #define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* undocumented */
>  #define RPCIF_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
> -#define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
> -				 RPCIF_CMNCR_IO3FV(3))
> +#define RPCIF_CMNCR_IOFV_HIZ(val) (RPCIF_CMNCR_IO0FV(val) | RPCIF_CMNCR_IO2FV(val) | \
> +				 RPCIF_CMNCR_IO3FV(val))

Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
datasheets? I am asking because I have a patch pending to remove writing
to undocumented locations. So, I was aboout to remove the IO3FV and
IO2FV macros.

> +#define RPCIF_PHYADJ1		0x0070	/* R/W */
> +#define RPCIF_PHYADJ2		0x0074	/* R/W */

Those are named 'PHYADD' and 'PHYWR' in the Gen3 documentation. They are
only available on a few of the Gen3 SoCs. I think the Gen3 namings make
more sense because then it becomes easily understandable that the
registers are used to write something to the PHY.

> +#define RPCIF_PHYCNT_CKSEL(v)	(((v) & 0x3) << 16)

We should add a comment here that these bits are only valid for G2L...

>  #define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)

and these only for Gen3.


> +static void rpcif_timing_adjust_sdr(struct rpcif *rpc)
> +{
> +	u32 data;
> +
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0xA5390000);
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000000);
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000022);
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000024);

Can't we have defines for these magic values? At least in my latest Gen3
documentation, these values are explained.

> +
> +	regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
> +	regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));

regmap_update_bits?

> +	if (rpc->type == RPCIF_RCAR_GEN3) {
> +		regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> +			     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> +	} else {
> +		regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> +		dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> +		dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> +		regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);

regmap_update_bits?

Rest looks good.

Thanks and happy hacking!

   Wolfram


--myXSi1SOqxroiqCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVzG8ACgkQFA3kzBSg
KbbQRRAAsUhxjWffPi0zOAX/Kwx59slKArNPjW/bbcIaFpQJZHOaAtZN5f7ShJj9
heQOq0GZ59dy5mC9n8jWKRfLmIiy+kT7wyGIGHNZGjhIfGD/w6cJdATO13s62J91
76lxaruXnCIViD8oIqfJ9zayEVPesKwZ/wxaTuHZDQMzs6iOz0nW39a82pnvhXIr
aTiWOY3HuAbS59JNaY94+mbo+wSqZzosEI1hhinQCMPjITE8L1oe0rluhSQTV38P
5P9WQv8fd03duVvr5ERN7j/Dvhos6/nP/er99//xAcLe2cf2D2VruI6CduNN7Ilb
CBiPBubGkpRrNOTMFJOSpeaCrxZ+swulBjd59ZX6C/aIc6NK1kDjfON2unzC1iTd
eS25kDiUM2dgM5hALSh8yRyivVnSERjsg7wFVUmACJv8rf71pO257zOjA7Cktfa/
V9RByghEW+2beoOdDU1nu05jHraSQDBL7BsrDZSh/YS9LTbMBxo3EDDVfk1/vrWI
EKcTpDXqGCJdSf00OnDfXOB3cLQJJ1hhbA8u6/OvPtjnxG7+8mdLf7JXbEqwQoQ0
KfkKoIGxNCPH/Fb0s3YllskM0pG/gOqTs/ANfZBOR6GRwl9YETpxVqTEkKMXQJVu
LXP83RWNa2fCA6Bcb88B9EkqmXimkuaHuHPUX4z+O6hWg9yzQiU=
=FvhF
-----END PGP SIGNATURE-----

--myXSi1SOqxroiqCO--
