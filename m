Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B593B4504E6
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhKONGx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 08:06:53 -0500
Received: from www.zeus03.de ([194.117.254.33]:45370 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhKONGt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 08:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=OLQihzRKyh2y1tQZCycpI3W9roJE
        NIrd1K7JiBrcKzw=; b=e3Bu02K7i7uyvNYMDoFHa46HUAPsXRIPSBTVuOHM4mR/
        vrYNlMettOwqW611Y6BjqKTTJzT2FGszgkpJme9B3HYLTrfcCET06f9hgR/7WSXY
        8l/kPvJQrXup+4Myb+hu4+4gmiBxQ4m2sErKCtDDPnUsCwNHfRw+js+cxSlSvus=
Received: (qmail 2337764 invoked from network); 15 Nov 2021 14:03:50 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Nov 2021 14:03:50 +0100
X-UD-Smtp-Session: l3s3148p1@2jancNPQvrYgAwDPXwfBADNdh3YJLcIx
Date:   Mon, 15 Nov 2021 14:03:50 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <YZJatk2Xs6bYdCyB@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ih87i6XTGwSWpEQ3"
Content-Disposition: inline
In-Reply-To: <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ih87i6XTGwSWpEQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 09:56:31PM +0100, Lad Prabhakar wrote:
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
>=20
> This patch adds a new compatible string for the RZ/G2L family so
> that the timing values on RZ/G2L can be adjusted.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

After some internal investigations we found out that we have to live
with these magic numbers. We shouldn't mix documentation there. So, this
patch is fine as is. The minor nit I will fix incrementally because I
will work on this file soon as well.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ih87i6XTGwSWpEQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGSWrUACgkQFA3kzBSg
KbZACQ//QW6h49hTvyDnW3FXxCnOu8Fjy4Du93vzYyiffKiu1rT1kWz/eCxEDYIe
nAjwuUERonPPxtlnfyH7b1ZvC4wAde8dskw01huc7sJT/gNFHNp5t20B9Aj1R/eP
yMNoG5cEtDcYNUvjTQkfLZ9XQvH8m7KWVQUOcVx9IgCnCL9QGzOe6lGVADhTf5gX
orNojeAF09rUS/VkjzEbvcsx/8l4zKHQYmYWEIb9Q3nPvrv3UtT0DZeK7S9r1LMi
NsCrQCTKQQ4F31Vl3VQQMF+WhO3hGHXpzQKWK6MjccNGA/HgccptkYmgx7MECgrX
+k5deLVADSt18C+1ExdaODcD056JYw39cqOZL3Ig1K+9YVeWDFXXIcfFGoSUwFNR
eCn6Z+ps5LWaVqRIUkLHjo6X80IXoK3Z8GX2R518BLxc+tLRZbC0LObGPmIr3T+l
U0AE2NjVxscEFB/CFHRx4JR0W1ywyD6ZwbIoZVo2Mf5kdvjzJGajGRrGQLbPzLkO
9K8as9oOsjHwDhMKTJ4a8/9qTzWgsmzz5x9hZB+30g8JJm9l18+s0EKHFwmt0kR/
Ly0L8nVSI3C4NSTf+i02jsxC5wXoUXUZzAJc57XdME5SQEGxEbDJNbNvhstKsyZh
je4ZKZtMQKci6ngq+QhKF/eODcypttoHlG886SPcmoH5W+U6cKA=
=JiqE
-----END PGP SIGNATURE-----

--ih87i6XTGwSWpEQ3--
