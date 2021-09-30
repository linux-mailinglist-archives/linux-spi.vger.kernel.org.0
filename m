Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3141DB51
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351747AbhI3Non (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 09:44:43 -0400
Received: from www.zeus03.de ([194.117.254.33]:57276 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350042AbhI3Non (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 09:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=enjVHhjyJZgjd0uz2ZMCGxCdBS+f
        mbNWBXj4KgCu+/g=; b=Vq4frCFv5u/OJhnwA+2jw2Zo3C8qPCWnb8BlITwGu6W2
        F3Ba0Jot9YgQactoV/1PgzGVxftoTEzEYX6eKWjWBrPZxkb5fNVjqntHammaEn/p
        0WVvfEdoIOWiPs1K+noRZDFS67NKKd1xx2//p8fbxw95ZZwnEuWR6tyimZEMtTw=
Received: (qmail 2095125 invoked from network); 30 Sep 2021 15:42:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 15:42:57 +0200
X-UD-Smtp-Session: l3s3148p1@ZcTdnzbN1IQgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 15:42:57 +0200
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
Subject: Re: [PATCH 4/6] mtd: hyperbus: rpc-if: Check return value of
 rpcif_sw_init()
Message-ID: <YVW+4fueYq0qwpZz@shikoro>
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
 <20210928140721.8805-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UH/3+F32BIFpPcH9"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UH/3+F32BIFpPcH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 03:07:19PM +0100, Lad Prabhakar wrote:
> rpcif_sw_init() can fail so make sure we check the return value
> of it and on error exit rpcif_hb_probe() callback with error code.
>=20
> Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--UH/3+F32BIFpPcH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVvuEACgkQFA3kzBSg
KbaFOhAAkhQT+eANrESXMUmHwDoBaEftQaOhPkUb8DlXOqKGq+DAjzW+JyzW0kSL
ESmiEdv89aufX5RfHPtGhaMpg4zw77UD3K2Lorxq/0NhbpSsw1QQPLJQ7S7opXi+
4YbfeFnCQHfDshSl4Z72qhYIK2+hX0UxGb+Rwc4cFo+VlfSf0kwY3Fou40hyfvuc
1QX32jsF4nIx8n0aRlChTwOkiDozSFhYsF6hyaHkujln6Tl3/XkhFJnVMx28Rx9D
intGfPYb140kKY42sOSYyVIvU5NEOA20uptacBGyHjD08JMoUqngNFTrB9QSD7Qn
UXyNSm8hCR2O4jXwqyaq+NkB38/KjGiA0KhqLe7VfIJF2kpIhD7A0byOuXeJN5NJ
mzx8B1Je7st8S2+8tsB8+QXx4LhaxUwgOE6AuW4egwuh75VrXmKlOZpz7p7ScGga
51om9XkoqZKZ8y/OYjlLs0PTnILm3FSC3kMG13bJEaKh7xDXujRTMHYhCLAeR+kP
cnxNI6KR8+t/y8WgTukfo7z8uaC29WJ83cE4Nyl549lub9Y6s0mJJPmIW19xVxzY
7kyjUj+BkBWsr96db+5f1hQJWxoJ55o7dhtmEscLa6Ka06uW5/fL6YLZQ3u0Cccs
wshCtE1z4f40IvhH1w10UaNvmL4CXvI0tKQ6EgcoUQtp5p21m7M=
=KpqM
-----END PGP SIGNATURE-----

--UH/3+F32BIFpPcH9--
