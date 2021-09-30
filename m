Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1919541DB90
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbhI3N5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 09:57:01 -0400
Received: from www.zeus03.de ([194.117.254.33]:34142 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351532AbhI3N5A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=lACN/fAUucdc9g/2SkCkqipA6nj3
        JMT9I8knLNGVIRc=; b=RamTHQIWkQK+fuLGLW0ws8vId009JxFNyus/bGbMvQpe
        N/LLTH3ZSg4tG2e3fbGaN5ZCtiBc28jZfSELK1ogZgFP8AJXfmoclxqt5Pgj9osX
        rcypf/pOERZPljCCM6gwAEmuYGC1mwz1zgBG0q1p6DGUe7775T6r9XpsjNaJib8=
Received: (qmail 2098631 invoked from network); 30 Sep 2021 15:55:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 15:55:15 +0200
X-UD-Smtp-Session: l3s3148p1@OM3WyzbN1oQgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 15:55:15 +0200
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
Subject: Re: [PATCH 5/6] memory: renesas-rpc-if: Drop usage of
 RPCIF_DIRMAP_SIZE macro
Message-ID: <YVXBwx7rxJLRhlTI@shikoro>
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
 <20210928140721.8805-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okOuMtWAHaaiVQFC"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--okOuMtWAHaaiVQFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 03:07:20PM +0100, Lad Prabhakar wrote:
> RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
> RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
> which is already part of struct rpcif.
>=20
> Also make sure we return error in case devm_ioremap_resource()
> fails for dirmap.
>=20
> Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> Fixes: 59e27d7c94aa ("memory: renesas-rpc-if: fix possible NULL pointer d=
ereference of resource")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

In general, all fine. I just think this should be split into two
patches:

> @@ -147,8 +147,6 @@
>  #define RPCIF_PHYINT		0x0088	/* R/W */
>  #define RPCIF_PHYINT_WPVAL	BIT(1)
> =20
> -#define RPCIF_DIRMAP_SIZE	0x4000000
> -
>  static const struct regmap_range rpcif_volatile_ranges[] =3D {
>  	regmap_reg_range(RPCIF_SMRDR0, RPCIF_SMRDR1),
>  	regmap_reg_range(RPCIF_SMWDR0, RPCIF_SMWDR1),
> @@ -547,8 +545,8 @@ EXPORT_SYMBOL(rpcif_manual_xfer);
> =20
>  ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void =
*buf)
>  {
> -	loff_t from =3D offs & (RPCIF_DIRMAP_SIZE - 1);
> -	size_t size =3D RPCIF_DIRMAP_SIZE - from;
> +	loff_t from =3D offs & (rpc->size - 1);
> +	size_t size =3D rpc->size - from;
> =20
>  	if (len > size)
>  		len =3D size;

This is the second patch to split which fixes ca7d8b980b67.


> @@ -244,7 +242,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *d=
ev)
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
>  	rpc->dirmap =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rpc->dirmap))
> -		rpc->dirmap =3D NULL;
> +		return PTR_ERR(rpc->dirmap);
>  	rpc->size =3D resource_size(res);
> =20
>  	rpc->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);

This is the first patch to split which fixes 59e27d7c94aa.

Makes sense?

If you agree, you can add my tag already to the new patches:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--okOuMtWAHaaiVQFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVwcMACgkQFA3kzBSg
KbZM5A//fXS4viqAsvu5+MJsDqWy1PnkkxWVX0eKh7vxVxdV7ykHo6BWNIor3Trb
RNDFycLEbVe+9SrnhLKUZiShiFR4xNQsBmJGds25YGFdQogDFGmnyapKA6zXtGj8
KBe34UCyjUo5dv8Mvl5DGo5HEhYmu4OVZpGxPBfFqzmUEpk5dW9nUbiuH8rROVpW
cs4UyGIAWC+NjGCm04VXy8pAWikVwCrs0RLBTGlk1KITESWts2Sz2q9EXuJdymy8
yLfHKeTWl8oUAhLBlULhvaOp9z55U4utgBUtzP7xEwXdyWbSAmzluYIrQVaS/xtQ
Mp6zCCwl4rpsYjWPPv5CKioj/qtBp2S9hbB4E/iigjMcpPCL7Znu+42/ehVu5HDf
NLS4dizP/N+qTjZYIv1oCrkYFsdvOGwryAHYStOsZS9aSjO71lNLFBNdxnzi2B7p
ySFR7l/Eb1VdNa82ZAfz1HbTxPKVhzHZHont7LW8LvqcfM3lZ1Xjm7+vvKmh1mq3
Ypb0Hs6VlCIeBsvUUSTtmKYHA9E8+goahA4t5VPwtJVVXXVps5EnBFjoOEYZWAS2
5t+rHMCIPX3+HB+kcr82WSZwoTydzO8lbwyIg7as1/U9nC0riYLPueeI3Wf/sxWt
lpreIkbOSze9ThMEedlaTRzQouFaQW4JTTYG6IlCk/wpzadT/hE=
=Pshj
-----END PGP SIGNATURE-----

--okOuMtWAHaaiVQFC--
