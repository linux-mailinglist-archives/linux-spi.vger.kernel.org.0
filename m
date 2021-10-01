Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E251B41E93E
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbhJAI4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 04:56:46 -0400
Received: from www.zeus03.de ([194.117.254.33]:42258 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352441AbhJAI4p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 04:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=U0XYrY7BfpzXUDaE53ryLcZq8bbX
        xEwB4ugx+HOYEAM=; b=Y0dkP3YbmXab6WI/QAVhlO/cRwgLvXfKY5aQuEWMP9zi
        PIKv+vSUuxsBC3jPZ9vP1yWk6m7nO06Hk5J8S6+fL3tY0CUAD2Og/YocuD1ApjAG
        gc1vSVyFKORA8TwoVMkl+4ia5KluFN/Sj1ix4syqNvBJyUa8qby/WFR1+qPUX/8=
Received: (qmail 2400745 invoked from network); 1 Oct 2021 10:54:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2021 10:54:58 +0200
X-UD-Smtp-Session: l3s3148p1@mSSZt0bNQtAgAwDPXwmDAJN1R91E6vGQ
Date:   Fri, 1 Oct 2021 10:54:55 +0200
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
Message-ID: <YVbM3z7x+D0MCkTF@ninjato>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="POeIfeKI2d2tOV4O"
Content-Disposition: inline
In-Reply-To: <CA+V-a8sDSsyTGfTeQfG_ZhfrJHCm+2kBTEDWaoFMTgsMOmxEgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--POeIfeKI2d2tOV4O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prabhakar,

> > Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
> > datasheets? I am asking because I have a patch pending to remove writing
> > to undocumented locations. So, I was aboout to remove the IO3FV and
> > IO2FV macros.
> >
> Yes they are documented, you should be able to download the HW manual from [1]

Great, then I will keep them!

> > > +     regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> > > +     regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000024);
> >
> > Can't we have defines for these magic values? At least in my latest Gen3
> > documentation, these values are explained.
> >
> RZ/G2L manual doesn't explain these bits. Let me refer to R-Car Gen3
> and define them as macros.

Seems like we have the best of both worlds then with the documentation
;)

> > > +     if (rpc->type == RPCIF_RCAR_GEN3) {
> > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> > > +                          RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > > +     } else {
> > > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> >
> > regmap_update_bits?
> >
> Im a bit hesitant to use regmap_update_bits() here as some of the bits
> are not documented.

Hmm, maybe I should then update the patch avoiding undocumented register
access beforehand? I will download your docs and see what remains and
send that out for you to check. Somewhen later today.

Sounds good?

Happy hacking,

   Wolfram


--POeIfeKI2d2tOV4O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFWzNsACgkQFA3kzBSg
KbYpCw/+IFCm4M9GxL7MN1VHz4q6kfkDKhe8TfEXrR2uOdjopf1//OvCjtch/I2F
VmI7EvVLoXUb8fadtW5pYbJtaASC4PBTyhyOJR05YfH6DT3czamx0S95CFoi2b6c
ZAeZ4V6uCyN97jBuAia2rFxuu+yIoavlrp/+VFGmP7O2dyw2MOTinezfIJMZnvhm
RGEW79XjZ9zEvecBuyBNRnnkK+XwUsRFgod5dnxmoXb6VMsGlAEtiX607VqvfLI9
xrtIdtx6HLf/LqLLjzSBfmtF8V3rnaXJ2o3xNQLmVxMPtLs5JsQ0U1Ra7kYc9kaJ
wN60H5LJ1jV5fn79oMp4HsxAAYuAhWjcTtnXwet3LnnMhB2dwcycjF+sqOt4oODH
diVh9X3CV8OO821jouKtIOKw4aC998J4qgVsklyrP6fXQf+BUBVF0S6l3am9Zazw
QBkSGc6wdzJjB3hLg66KZP8OuP/vim9KM2diuYvXptIGDzeD3AXTsvgKvtlfaW1v
Xby3E0kQoNkg0WLfYfH5N5pt60Qtj32Y6ewXRntWqZ8HeSaDyLM00n6GMfyRV50I
4fdvwejos4Ub3j37pNeK8f14Ltd4jEQO/dsVX6IAOiMcxaZMLe4a1DN/45l+s3sk
bz7FDrS7YldjhJMYv8TcI3MQJ0B+TW8pagl3j27ma19x/xtDKvo=
=KZfF
-----END PGP SIGNATURE-----

--POeIfeKI2d2tOV4O--
