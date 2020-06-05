Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A491EF5EE
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFEK6H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 06:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgFEK6H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 06:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5DD9ACAE;
        Fri,  5 Jun 2020 10:58:07 +0000 (UTC)
Message-ID: <d419325c67594d77a918f49222013f0f1f454371.camel@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>, lukas@wunner.de,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Date:   Fri, 05 Jun 2020 12:58:01 +0200
In-Reply-To: <f728f55fe6266718b5041b6f3b1864a673991129.camel@suse.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
         <f728f55fe6266718b5041b6f3b1864a673991129.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/79CtvoenK8DEBzH9xLO"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-/79CtvoenK8DEBzH9xLO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-05 at 10:46 +0200, Nicolas Saenz Julienne wrote:
> Hi Florian,
> Thanks for taking over this!
>=20
> On Thu, 2020-06-04 at 14:28 -0700, Florian Fainelli wrote:
> > The 4 SPI controller instances added in BCM2711 and BCM7211 SoCs (SPI3,
> > SPI4, SPI5 and SPI6) share the same interrupt line with SPI0.
>=20
> I think this isn't 100% correct. SPI0 has its own interrupt, but SPI[3-6]
> share
> the same interrupt.

I'm wrong here, I missed this in bcm2711.dtsi:

&spi {
	interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
};

Sorry for the noise.

Regards,
Nicolas


--=-/79CtvoenK8DEBzH9xLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aJTkACgkQlfZmHno8
x/5SQgf+OmvPj4BYlREL3zg38OEq+NEtQE5Tw5Oi5SBMTLf3HpyUM+ZNDOuHNB9a
R7fFlBKHS8fIYxPawpYXKr2Z48Avs7rv1dUeD5WHKdE40ErEnSkASihptnK53bbx
6Ysl/oZuU+s2mtHZvWhVPDSJuhf1EX5W80Iv4diqD4pAH3HVlFBdqARgjV4GND9Z
fz3dhXgFuVS3Pdq8hsn0o5+U8965J2swadD70xt4J1vJyAM/eD9jz+AlGAh25t7o
wYt1pUNi0yA6N+i27vLpsv+tNmgnNq9KOqzDzZomPUvYunCUl+Z3/LfvEz9EF1dr
gTqqjhjMLd/2aovu/MYhjQs5bqrf9g==
=lD2O
-----END PGP SIGNATURE-----

--=-/79CtvoenK8DEBzH9xLO--

