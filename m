Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5492C41DB4A
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbhI3Nnm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 09:43:42 -0400
Received: from www.zeus03.de ([194.117.254.33]:56822 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351691AbhI3Nnl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 09:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=rpIWuAp9ZNmG25KjbAPLOGuH7M0l
        sNvKK6EG741biUk=; b=f1XyGz7oEPJZaD/2Xu6LZDdIa1ofgTsSXFo4+3x0R5w+
        5mEK69p3J8zOK4+JqRmH9yB1WX4n2xNhpaz5jSY0QeVKLoYAonDpc23dPYGqA2yX
        opCkuDukYdsFdQ+9iwai1b6sVe4Yudg/7lRHH3HbyCGivgq9G8uyIVnkhE8JVHg=
Received: (qmail 2094768 invoked from network); 30 Sep 2021 15:41:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 15:41:57 +0200
X-UD-Smtp-Session: l3s3148p1@2cs+nDbN0oQgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 15:41:56 +0200
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
Subject: Re: [PATCH 3/6] spi: spi-rpc-if: Check return value of
 rpcif_sw_init()
Message-ID: <YVW+pLtnipm0/q9o@shikoro>
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
 <20210928140721.8805-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmwXyugRvFzLlAzO"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fmwXyugRvFzLlAzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 03:07:18PM +0100, Lad Prabhakar wrote:
> rpcif_sw_init() can fail so make sure we check the return value
> of it and on error exit rpcif_spi_probe() callback with error code.
>=20
> Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

If it fails, we should really bail out.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fmwXyugRvFzLlAzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVvqQACgkQFA3kzBSg
Kbby2hAAqjZsRM4m18UG6QCICxShrPpcJzI1sH6ogMykOFUrDeZK/bHfa6DgEwfW
U4Z9iGiHB2jyR2VhWzw3QXvvTirVy8oLS4g7H3oz9FnJHWcPFrxCFs/rby/PyiOk
WG0sYm7Xbui6A7Qto4z5ua3K/ea8UEMSoTaf9Je+fb0YXLnvh2b6k7APv/qC9xBK
vYhRy6qDB6VcxZKTlYIZotL58s4oxHNb6Pe9idPiA6U1pRKOSYzB1ecUctiRAtW2
f0CJ05OSrwr7S5XUnJUL0oLFS4m96ICebUyMicn7b4z1k5qg+O2UabDVwFa5zpiv
pAhIor0d6vncJ9HI/k1PdTFB0AkHkYnu32NIhGXVn4c6SD/sIYQxCKGALo5P0XIQ
nKfVxzopvMYLfsPt2bFIcRx6ngjhxHQj51lVBpQw0KH0odvkoKqGcrixpKnmQ6us
9q2b302MA63zw3qpfQW/wb4JZFVR4s92pqi+rFeAb4+QbfibCr99MhKXKOpRn5bS
lwedVUBYqXCzAwDVS2MhFaPPP+Q8UsqhHDo//I9W/WdZF6GPB3PBCnKUI18wtPCP
F8GMd3b+wEe28sZFFD/BZjZ7/Cqctv29FCxRlx+xy0fWgOf+HU0eUKuBE88D1Eku
NGqjtFvCob7wd/UHTFRurE//SkA3TaolkY8r5KL4h6QwezGE1ZQ=
=jzQb
-----END PGP SIGNATURE-----

--fmwXyugRvFzLlAzO--
