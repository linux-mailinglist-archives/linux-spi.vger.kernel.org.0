Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82570443E80
	for <lists+linux-spi@lfdr.de>; Wed,  3 Nov 2021 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKCIo0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Nov 2021 04:44:26 -0400
Received: from www.zeus03.de ([194.117.254.33]:56548 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKCIoZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Nov 2021 04:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=dMC2lX62GntGviPXdg/KWy3WWd2f
        nwOs+hAlvdSI+Lo=; b=QkUE+PYyhJ6Za2I7PJCop+MWdhAp1+DuxGz25qrGeOSO
        4aZYDMTQ/rzXAh8NesG7J2PDQsMWCSKD7FxVLHhkCscS9xLyax7W5hGuYiokKYwN
        7trj+QmOo/rS0vuMoxsz3Gluqen6Ok+q0NGYvlIKuUYWkKxXxI6icfsSqPXpDmo=
Received: (qmail 3771547 invoked from network); 3 Nov 2021 09:41:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2021 09:41:47 +0100
X-UD-Smtp-Session: l3s3148p1@kvpAYd7PnoAgAwDPXwjwAA05VFZREelC
Date:   Wed, 3 Nov 2021 09:41:44 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <YYJLSCE9ak2I/9A/@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YYElefbpP4pwfmUl@shikoro>
 <CA+V-a8uJxeSr=uoF14gccuSLG7WRqRk8X8uD9UDoxKPGM8hGgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pYP2Iqqm8byYnsBb"
Content-Disposition: inline
In-Reply-To: <CA+V-a8uJxeSr=uoF14gccuSLG7WRqRk8X8uD9UDoxKPGM8hGgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pYP2Iqqm8byYnsBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

> Oops I missed that, does the below look good?

Yes, only a minor nit.

>=20
> #define RPCIF_PHYADD_ADD_MD 0x00
> #define RPCIF_PHYADD_ADD_RDLSEL 0x22
> #define RPCIF_PHYADD_ADD_FDLSEL 0x24
> #define RPCIF_PHYADD_ADD_RDLMON 0x26
> #define RPCIF_PHYADD_ADD_FDLMON 0x28
>=20
> #define RPCIF_PHYADD_ACCEN BIT(31)
> #define RPCIF_PHYADD_RW BIT(30)

Maybe we could leave this because we don't use it? You decide.

> > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
> >
> For the above do you have any suggestions? As I couldn't find any
> details about it or shall I just go with magic numbers for now?

Ack. I couldn't find docs about these as well. I suggest to add a
comment where this value came from. We can ask the BSP and/or HW team
for details and update this pair incrementally.

> thanks, once we agree upon above I shall re-spin v3.

Cool, looking forward to it!

Happy hacking,

   Wolfram


--pYP2Iqqm8byYnsBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGCS0QACgkQFA3kzBSg
KbbuNhAAnt0A/Q1rD7IOA7oPFNk3ipuC9zHlHj5EodZ/Ad1DoMUIezY+NV5bSbEf
HP4OuTP+/OSbd3bQbyBnNwM1P8dTR6FBK4CfqPnRISF5qm8AsB3ByoA5Webxy5QO
GeP2cSJwY+zQetc9EcMoxARH+1ZztRDLK7CA/y5oiURwSeUBxafJ8uRuRYOTgoA6
SAx9c7NAfH7D1Yv/eMsZrA7Kwe0Ms2wYwWyjLl9W0NDZiAgoPiUk2RDojMcbA00J
6fvEd5wYY6yPyjay4dFXHjFp3SToPq6KZ2+oBCSaTqhJFoLLUgWgJUQSHO/0TgaQ
Za8j3ncwdvj1lilrsxBZ7rdA9A/vyq6nFgBadvLVBB8wz/G9tWRSQZSKouvUQ6QO
6yEsCic5yrg2cmgj4XU964fM5a1pCVYpISE6UX3R5l/gJwMlPtXeyP7w6n53ZvaJ
lCtT8ulpZxdPrv6uHSH0qXEXwudZ2XxEOPlTYczJVXd5o6ckZCdeToDvZyR19AU9
ud2N0oc39jcYI4B6P0afBxZiavi1cu4xixaBxl6xq5o0wx6BSZR0gqHNXznQ5GWo
zsshKoBvM+tpInbYYJXBLj+9pLLjMjh5/1zEA6+zF5t6fcxTGbrQ/sSc/ssBXr+R
b50WBFSq6RsGLUIVFJJAhWSDUpd7XBZpc2fzbzGcKKnpNBNweo4=
=7d/U
-----END PGP SIGNATURE-----

--pYP2Iqqm8byYnsBb--
