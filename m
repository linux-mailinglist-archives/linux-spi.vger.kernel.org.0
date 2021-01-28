Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57B307830
	for <lists+linux-spi@lfdr.de>; Thu, 28 Jan 2021 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhA1Oem (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Jan 2021 09:34:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:60830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhA1OeL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Jan 2021 09:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 713D3B13F;
        Thu, 28 Jan 2021 14:33:30 +0000 (UTC)
Message-ID: <9916bdb638880bcd1dd4ba5d473fe704d4aceb04.camel@suse.de>
Subject: Re: SPI lock-up with zero-length transfers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Date:   Thu, 28 Jan 2021 15:33:29 +0100
In-Reply-To: <CAMEGJJ2M+XErpt8LNuRbpDuFDPBg_kwPsmU8P0aGAtO27-xw6g@mail.gmail.com>
References: <CAMEGJJ2M+XErpt8LNuRbpDuFDPBg_kwPsmU8P0aGAtO27-xw6g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+M3Vl2rFnkgdS2p8DTdj"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-+M3Vl2rFnkgdS2p8DTdj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-01-28 at 14:26 +0000, Phil Elwell wrote:
> Hi,
>=20
> Commit [1] - an optimisation of the PIO transfers loops of spi-bcm2835
> - causes lockups if a zero-length transfer is attempted. The commit
> message says that "[t]he blind and counted loops are always called
> with nonzero count", which is technically true but ignores the fact
> that count can be reduced to zero before entering the loop if tfr->len
> is zero.
>=20
> A workaround has been added in the raspberrypi/linux repo that
> explicitly checks for zero-length transfers in
> bcm2835_spi_transfer_one, but perhaps it would be better to catch this
> degenerate case in the common framework code - I'm not an SPI expert.

Me neither to be honest, but I'll have a look at it. Thanks for the heads-u=
p.

Regards,
Nicolas


--=-+M3Vl2rFnkgdS2p8DTdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmASyzkACgkQlfZmHno8
x/6oPwf/VgwftU8QtvHo1Xf4B7fZj4ovtfaBYMeyT+/VFC/t3IxuA5Jnc3cQF7Oa
RciE12Ua43AACklu3+m0HnzAgTyh7Rr3Bj/nbbAoP31kA6xgdLiYgSqTQJNuCuAH
m0TAEi3Zz5U63C5PQ2IpKs/qi033piAaJP+Wl0NEMuw67obP7OKICVPKxwDVQHHi
fmUApdTjJrcp1KXi+xSJ//egwzyPhrbvaduu4OVpOvkN7Z8P7ZwSjGnMxcy1oZP8
zzHxPGdu9tm0gMvGbzZgPAm3f+5jaRYcdHM3jgVsWPAtxBBh0COzSFNblZ/ytWFx
eZuA8v6Sg1snDyMZET8c7tt4Z6Aguw==
=N3ze
-----END PGP SIGNATURE-----

--=-+M3Vl2rFnkgdS2p8DTdj--

