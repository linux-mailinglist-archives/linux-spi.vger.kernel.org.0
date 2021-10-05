Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A24221E8
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhJEJQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 05:16:38 -0400
Received: from www.zeus03.de ([194.117.254.33]:37454 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhJEJQh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Oct 2021 05:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Ko//vJyuyzkPLobdWRfp+yv7tyBc
        7iVoX1/SJmxO3TA=; b=VtlR4bgMqXIBd5DWuugHtGk9yyyDygAneVjffLA5ldjl
        pAWSNhrqUERs8oyt4OKXq1q/a9QpTPiC7Rt2L+RJz5NqL/LSj5dPB5jCzcm3z6I6
        xfvrh+wqR/siH9eEiLFS2V4S5GVnbUGickqtE8JS6mabXe0R/olbq6f5D5LA/4I=
Received: (qmail 3740740 invoked from network); 5 Oct 2021 11:14:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Oct 2021 11:14:44 +0200
X-UD-Smtp-Session: l3s3148p1@JUPbdZfNBoogAwDPXw1kABtQsg8UzxVo
Date:   Tue, 5 Oct 2021 11:14:44 +0200
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
Message-ID: <YVwXhFalcYr72CZT@kunai>
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
        protocol="application/pgp-signature"; boundary="1E6oOfbK851bS2lO"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1E6oOfbK851bS2lO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prabhakar,

some updates after internal discussions I had.

> +#define RPCIF_CMNCR_MOIIO_HIZ(val) (RPCIF_CMNCR_MOIIO0(val) | \
> +				 RPCIF_CMNCR_MOIIO1(val) | \
> +				 RPCIF_CMNCR_MOIIO2(val) | RPCIF_CMNCR_MOIIO3(val))

Shimoda-san rightfully said that '_HIZ' should be removed from the macro
name because HIZ implies the value 3.


>  #define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* undocumented */
>  #define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* undocumented */

As discussed before, mention here that they are documented for G2L.
Sadly, we can't use them with Gen3...

> -#define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
> -				 RPCIF_CMNCR_IO3FV(3))
> +#define RPCIF_CMNCR_IOFV_HIZ(val) (RPCIF_CMNCR_IO0FV(val) | RPCIF_CMNCR_IO2FV(val) | \
> +				 RPCIF_CMNCR_IO3FV(val))

... which means we should remove this macro entirely because it is
forbidden for Gen3. I think it is best to use the RPCIF_CMNCR_IO<n>FV
macros directly where we need them.

Do you agree?

Kind regards,

   Wolfram


--1E6oOfbK851bS2lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFcF4QACgkQFA3kzBSg
KbbnLRAAl70bTAB+aCkvy4wf5a037bvW472u2V73Husi70cFbyNZccWvjYNENHbA
w15RefXBgSpefwx3hNndCw9hvXBW5TyLVHaKjGyN23G9y+d7clBKGUUzXI/8Wkko
cfYmv+T9Sx+EhH+ZX2fuYId22CcR4DY7q++BDytTmgeQ9iXqvgch1fNhol/XAoVo
8ADih0NYeq2qBD23OGejJxEQVzLSc3RX8p7oi4rNrr78nqVD+bPtKlqH7mX1s/5m
UtjXlgc3jqRWKfCq3anpE/ketF+F/D2reqsAE29dQP8Pnwhy64XmEvsJbwy+n0xl
GeQ7ZRS4maXgVPMcH157aPL77OgiUczqTNGYnpXGGQtUaxMNx7GOir+xtsHv9NaO
FTczDB4l0tx7E155wgKl3+bImYvnrFPTblJpQhBkzkzzu0fF2l4HNlLkUQ2Wusb0
MTlPa4efYMzK0Yo+BNeOf6962cjlA/Fmu+MZ1udD/Ko9NVvSfSgZH17LAX31cOGo
pI5eDH2LHZCkP7zhH7hIKYVAn8jKqJYX6aUk5/6yt1Rj/FLSRZzSiIb2UcRwC6Hs
gB2Ang+Rou0Dpu2rnhYxVG25tho+SeEx7I+RFXUZTQSrMCKpFIh67Oid5HY7RmaJ
v6EsYsI4+qDVRfamnyNTjS+Hwt5/fs+uRYyHMOAj2UXeSgZiOBk=
=3XAi
-----END PGP SIGNATURE-----

--1E6oOfbK851bS2lO--
