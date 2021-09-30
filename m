Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C441DB43
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351301AbhI3Nk4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 09:40:56 -0400
Received: from www.zeus03.de ([194.117.254.33]:55630 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351387AbhI3Nkz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 09:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=yYGRL5IIN4QUzqrtcpKYkK1W8kRr
        W8asPlA4c59DDlA=; b=RZLx2txP8BU71m8ccD7oTRxGHRp0/gA7NEJ4GNkS7hBB
        E+Rh2YpVCGpv7aUmC8qkrud7wXVpZculG6H54KanhUpMLGaeuYhBR1vUgtVuF/65
        RZo8kDQs85CfIMyRhVRv2PNGxAt/4nlRIT9Gzzcwf3jQdQP7j6l7ZHqd9srJpBA=
Received: (qmail 2093872 invoked from network); 30 Sep 2021 15:39:06 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2021 15:39:06 +0200
X-UD-Smtp-Session: l3s3148p1@KRfmkTbNyIQgARa4RV6LAWawlO8I9jL3
Date:   Thu, 30 Sep 2021 15:39:02 +0200
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
Subject: Re: [PATCH 2/6] dt-bindings: memory: renesas,rpc-if: Add optional
 interrupts property
Message-ID: <YVW99ticP5scIWHZ@shikoro>
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
 <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pbwG+L1mKyN7j93+"
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pbwG+L1mKyN7j93+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 03:07:17PM +0100, Lad Prabhakar wrote:
> For completeness add optional interrupts property.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pbwG+L1mKyN7j93+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFVvfIACgkQFA3kzBSg
KbZcEA/8DC+4Sfb4u+PPrWzR+e018I2qQPkGfH9kMwfBCx3LodnuGf6de22Ny77Y
cqAaS1tILf2ZxCs895Pc01WETkqxpK4hGLfYfvZh8x3WPXhVZTwtnAbbBqXimty3
TvYp5Wh8ASIi+EirBaZ4Ji6pE2x/fPTGz6FFODOVoPTzgUIDTZay3lkuTdqhqiBA
u2obEJD1paLNlval0kXKuOhONyILRucb5WhtlIdUMo1ILTURMt/7ueQ4kl3TL8T4
phrfuIxkwyrZzhdGmumrPxyn12ixoNUGurA/RltLp3cF474vHfY4OnFZsAE1lQEf
RsVBuQTbIT/kTp9YCxu9tqmLilF4vgzRPfM/EnbdFiUv4ysQ3W79RdIz9fovo3kO
6hcCsgaQyCT8VPpoG8IfO1wKwI6c+DVMdH+yJcwD7hE3aJw19gr7bho8V+NEoA0Q
MDz9co6oLqjFq+AkzGSPsbLzbF9HCWby9Mhd5sSrIok/k6/BYHYM2mfOxYUoP82G
SICnTVltyR/btOke+v/WfP/jswdCYB/dDXOM+9Pxf0PCM82gRuCDOvDZdC+Xry2v
wcKvHu5Kq7V1veohoSL9JdAQLdqrVrXHrvxuFB+oK9Cij8Rp7d7FegC/jVUYFCFH
4tQpW1SG5KvIk7vjSnEz3G+NHu9uCVToaRZCoMQvcPtHy4e1R1A=
=EJF1
-----END PGP SIGNATURE-----

--pbwG+L1mKyN7j93+--
