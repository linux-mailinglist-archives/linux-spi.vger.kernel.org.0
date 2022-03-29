Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412E4EB421
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbiC2TdA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiC2Tc5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 15:32:57 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045A116B72
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=knNYMZEU69NMfpQ4m1rH0jsDGANi
        5zCmvpltFrEzd28=; b=lsWefx/liGK71ItGFC+CnZIEW36Kr8g3igLmsjFLK3M2
        k5S0rlO4S6q6NWmA9hrYHnJu4/mlcfst+a3fyndzSogNfXTH8rVlqYcp7qlFEgd9
        VpDvkdfgwzM7NJ2Dffv15QZC1bYPruh0c/oFeo7Y2W8zv+nOhe5MnkW6hOTfQp8=
Received: (qmail 1912200 invoked from network); 29 Mar 2022 21:31:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2022 21:31:11 +0200
X-UD-Smtp-Session: l3s3148p1@EtKmeGDbiOIgAQnoAFHmAKSkhU0Puvxy
Date:   Tue, 29 Mar 2022 21:31:11 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: rpc-if: Fix RPM imbalance in probe error path
Message-ID: <YkNef6Vkj3yWKLpF@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
 <1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p/R0G50SrYfB5ovU"
Content-Disposition: inline
In-Reply-To: <1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p/R0G50SrYfB5ovU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 04:00:39PM +0200, Geert Uytterhoeven wrote:
> If rpcif_hw_init() fails, Runtime PM is left enabled.
>=20
> Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--p/R0G50SrYfB5ovU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJDXn4ACgkQFA3kzBSg
KbYKHg//aEF5Ckun5neyJ3R7yRbUM5LIIQ4YUw1bqJ3qwDioYlnwR00wE968ZJJ7
X7dkJ+1MBGsU91h8diz1+YZvlO6c8IHbigM3efwFzy21NcVxu7I14Wb/7s068BEC
fDC4Rf7Ph8ajJNVXn4eO/ciwTi22zHgyfSTdlgATd4fI6IrDe2t5dcga7P0tBwWe
4lta3qbC1+iFdMJC8ohmlL0Un9UUy5UjyL2UTTEL7z23EjUSwtEWvGe8lr99HF1/
8CFVnzvWWk/EYwOX6LEvdMRQHpuwJNMi8qZ6cuUnDc/og/fxuTOHlwemF5JZNW7I
ZXJ8mUkf4t0WWpkNPSN/VDityv42rdGDiNBGA6N63qVfSe56GKGqtU8Hg0pcYNFG
O48z9VjIFLuPRBRFU0y+Yo42jNJBkxnAY/H5ZQpTRe+Jivqqf3p3Umu21UNG+2WH
52lXhDH9MOk2ijkOSV9WDhgnctg0yqcLa41mGv5Q1f4vEOQnB7H+AQxbdQo3wXXJ
dcXrXVvHGLZ/VOnXpNurcqqp3FwwLg9/1NOd/SSmZAKbIz1cSmI/H98f+F5ioqDr
HWvlddjv/2w2i9n9tZVDx5wSZUix8hn8wtFBcISQdV7h+9ymvFN0/gEEuXoDA8W6
LrEt3M0h42NXC6Oa1uYegMP5dsaxFDibA1WsxaAEy41fw0OAM40=
=5+x/
-----END PGP SIGNATURE-----

--p/R0G50SrYfB5ovU--
