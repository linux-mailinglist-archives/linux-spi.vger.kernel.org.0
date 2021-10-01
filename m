Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437741ECDC
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354162AbhJAMGL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 08:06:11 -0400
Received: from www.zeus03.de ([194.117.254.33]:55076 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354146AbhJAMGK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 08:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=sU1jHZ5AxD4VfGEdE0alKPxI1996
        qYnc3sUVIk98xIA=; b=o2DkK4TEJ2MjNtxegdLBJeBjQFr16jn7wHO4G/EAQU1K
        j1RK0i4oldYwujwtqM3GV/UGHQONbcgn6x9RtjmzfinIm+xq3fgXYuoL/LArmIRH
        m2gGCz81yu6LMx18Kdm4IrvgKuRj9bp7gMlhcF+D7jWKpZmPbsyTgyNG7rNUaMw=
Received: (qmail 2459946 invoked from network); 1 Oct 2021 14:04:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2021 14:04:22 +0200
X-UD-Smtp-Session: l3s3148p1@MLMZXUnNftIgAwDPXwmDAJN1R91E6vGQ
Date:   Fri, 1 Oct 2021 14:04:21 +0200
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
Subject: Re: [PATCH 6/6] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <YVb5RXvh9agIS7MG@ninjato>
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
 <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YVXMc1A4D/y4kjim@shikoro>
 <CA+V-a8sDSsyTGfTeQfG_ZhfrJHCm+2kBTEDWaoFMTgsMOmxEgQ@mail.gmail.com>
 <YVbM3z7x+D0MCkTF@ninjato>
 <CA+V-a8uyQmW3+4hAt4534spKeQHDoeZzuJJE4RY70KLZfYOXoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QK+6x2YA2y8yiDI"
Content-Disposition: inline
In-Reply-To: <CA+V-a8uyQmW3+4hAt4534spKeQHDoeZzuJJE4RY70KLZfYOXoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5QK+6x2YA2y8yiDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prabhakar,

I checked the G2L datasheet and reconsidered. It is better if your patch
goes in first. That means...

> > > > Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
> > > > datasheets? I am asking because I have a patch pending to remove writing
> > > > to undocumented locations. So, I was aboout to remove the IO3FV and
> > > > IO2FV macros.
> > > >
> > > Yes they are documented, you should be able to download the HW manual from [1]
> >
> > Great, then I will keep them!

... that you could change the comments here from "undocumented" to
"documened for G2L" or similar.

> > > > > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > > > > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > > > > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > > > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> > > >
> > > > regmap_update_bits?
> > > >
> > > Im a bit hesitant to use regmap_update_bits() here as some of the bits
> > > are not documented.

Here you can keep your code as is. I will change it afterwards if needed
once I clarified all undocumented locations.

Thanks and have a nice weekend,

   Wolfram


--5QK+6x2YA2y8yiDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFW+UEACgkQFA3kzBSg
Kbb9Nw//bCZjWZIYqwiSCfxBOafnLWkptccKRA/ccZ57W8k5zOSNRRPmx68uEr2+
G6p3M5tlc9g9oqT0Yek9lce9f+7SIVrbOdHLONIpBpeEHEb4FfZUKqOiLzDB+JDf
RlMF+IbEFNOwDAfhFCJdR9SY5GeobFjmLpTWyMfJlRnFvTFFe9S3NF7V1V9AQMHh
KrTC2H67mMpgzVwT/iF7naTL4mHI7GaT9I1bm3U1meHYxDM7hDZB2uWvwErPzh1w
plGrppDm02M6Bj+IllzZukxvC7ppzPDAjmuHMttjuurInrem5NrWCtTMT4mZdf/w
0OIn2me7d40DI351em9tk5YL3tsqyIgTp+MpmrDGGi/9bs5FCQzPYh5RHtRVNwiZ
XicfUYQzFXg5FxSwf2LcDOcuHu737TZxjjrr++cKC6e9uGnzfXUlAy+HNhzSce7M
NqIZbnMNQD2t83mThggTvl+XgNQ/c4pMiJ11Je/fImfHkB/OV+ExZzhoTYqeRkjX
STlHRriE+XIuotL+RFD/ImGqKXPauFhWJwCrQcJFmwMhV4vl8EkWdtZlNDiR9sR7
+ir4YTUv1s7FUEpRCozcHus1MiKtFdoxDgC+yNDLwbo/fDE21lBB7o/4nTm3P3Qd
itXUJBUf8jxaSazpaURv1jiRCGSFZZEZCYmbnD2SDS3+y4J3PDM=
=nApo
-----END PGP SIGNATURE-----

--5QK+6x2YA2y8yiDI--
