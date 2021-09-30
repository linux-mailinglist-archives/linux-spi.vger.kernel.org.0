Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4A41DC9D
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351241AbhI3Op1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 10:45:27 -0400
Received: from www.zeus03.de ([194.117.254.33]:55078 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351225AbhI3OpW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 10:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=zC0Alauy1GO2I9lyHxa0EfxWQbz8
        B2+rwQmkFWLZr+w=; b=pVciIik0p6VGP3udU6MCYIxqkKUY8GygzNDt3dr10lV1
        x766ShUFEUcOvUJT65QToDAgeM8MTBAN3nLWv1gKhosWZiBdpwhLI31NzKU6ardB
        2v2fqIabltyNPKTFY3nKtuwAJL8h5q1XgxJhMgOC2zsX3STrgNcsJ+6LS1ULl/Y=
Received: (qmail 2114006 invoked from network); 30 Sep 2021 16:43:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 16:43:37 +0200
X-UD-Smtp-Session: l3s3148p1@9OrLeDfNOoYgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 16:43:37 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5/6] memory: renesas-rpc-if: Drop usage of
 RPCIF_DIRMAP_SIZE macro
Message-ID: <YVXNGTfOdMgkqxPT@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YVXBwx7rxJLRhlTI@shikoro>
 <CA+V-a8sZ0qudhbV7Fart-puNQO-ZHhDEG3OdRH=w_dbTHy2A7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+vXGT369GaKLNZZk"
Content-Disposition: inline
In-Reply-To: <CA+V-a8sZ0qudhbV7Fart-puNQO-ZHhDEG3OdRH=w_dbTHy2A7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+vXGT369GaKLNZZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Both the fixes would apply to the first patch itself i.e. when
> resource_size was added in ca7d8b980b67 and later in 59e27d7c94aa
> resource_size was moved online below (this would cause kernel panic
> res is NULL). Do you agree?

Yes. I do wonder a little if we need the Fixes tag for ca7d8b980b67
because we fix 59e27d7c94aa which already fixes ca7d8b980b67, so there
is a chain. But maybe redundancy doesn't hurt here. I don't mind.


--+vXGT369GaKLNZZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVzRgACgkQFA3kzBSg
Kba5Ag/+Nh2/+1ZBUs5G25GPrGF4qipbPyFFYvcGBkQ5Mx+GsiS9Z6jPdM3kjylF
+suiOYdPxy4HsRrZuu43cSb3SCK9Liem2sE1hvd3HmWk6jEhctIpKWzVBXEYahHS
g+BqPhcwQVEYlZCC6k46ByedC+E9IgSR6/of2J+3lVqVnH3iZhQjC5lAyan70za3
9Zo8mTCxqhaugRFrVl9tROKrQ6Kh1tYwQ7cRWvUbXS5Cx813m19TPXs+ieXFQTIq
KR3j3xAbkLSNjr+Y6Nlz6/4gcbF+FL9Y2u2/ey7Vku1ER6gwjpREkx0vVa9Dhi6K
HOoRCI1bP/4T7IuTJ4Nsz2Wlram+VfwqaEv5PLmzquWnOmWY8IqXhiC2JtR5FqoM
zbZbqVvAdrGLI8Ca+ogT4BDxB06JlZkgOW3454Nfw5xNNW1mc05Yoy45uTLvN5sf
LHrkLQ5HH3yxbbSl5bTAeUz2SWj8rHoCG4a/THVwY9sdd/iBV+mQlsGWd4XV++ES
zydPwjo37x04T/95dRpOOMqXeB5Ob5j0V2Dki1+hCTsHLmS2Gy1wrjhPKGR4C9RI
JC8s9wmC9dFgbcmNZGqdWyVA/0L9h7u2XdZR+nQb7ZTuHlbNoa44gElHaCOS4i4U
opohmx5AwY2ItrBcROWpTF7GMGRO+eyRn1I2kFLrCvJKJmA4wXE=
=nHUc
-----END PGP SIGNATURE-----

--+vXGT369GaKLNZZk--
