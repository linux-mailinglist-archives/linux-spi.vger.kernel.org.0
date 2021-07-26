Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC313D590E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhGZLUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 07:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhGZLUs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Jul 2021 07:20:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4153F600D1;
        Mon, 26 Jul 2021 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300877;
        bh=mfA9twdoBH7ucE/S/FL/eMhfGa6oul+5cO3xSBOIXp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKIU6zqLCOagCdDtEEDpR1F3q8Fy1YVhPq0xaPdhiD9vdwc4CgGKCDjpAnw9TITSL
         l0il+VRzwcg1sONxWSKxUUme8UZRqcAfFsabf4prwihg/D1WqsrK2Hpb2LLPAyaPXZ
         K6S0rXHKzNakJbEasgLjZDrKp7rZrbRFfKbBfPIpjnJwh5clU4PSjDSc7+G2G0fb89
         Ofj6zo6clXV3Im2eTMMQLeczHdje3pPZUyIGpaI902QHEEQsK6yyQ+XcMgYaoqHOA/
         iTx1zIpBeA4LEeH9YvHBMuIj6jnNCwaU9VNNvMTjBMB10mPx6clnpsCwlGTEZz+nrR
         fDdugHMFV6bOQ==
Date:   Mon, 26 Jul 2021 13:01:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] spi: spi-ep93xx: Prepare clock before using it
Message-ID: <20210726120108.GG4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726115058.23729-3-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20210726115058.23729-3-nikita.shubin@maquefel.me>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 02:50:46PM +0300, Nikita Shubin wrote:
> spi_master spi0: failed to prepare transfer hardware: -108
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  drivers/spi/spi-ep93xx.c | 4 ++--

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+pAQACgkQJNaLcl1U
h9Ds0Af/YqBqi8mEdjKXQOnAEbj8+eYJTBOZhq1614yibGpSMSVzXvFx7PMrn3WS
emIZUz4bPaMd2k3sbuHLfz4kOGR9lsf+q92HIfHdMscLYpxfQLjIieUO+dy59LlD
X4A746ImqKqe/r+0gelxqr3ZYP6q8bElYZMSTh2GQ1X21PlXHJetZ+XQShpwlcqx
jlCZ1vsCeyeaorEzzgdT8rfgLyMYs5pcKSNqD7oAWJLZmDrGakVWihe9fWzUVuO8
mDNZAbZZJOpbQVmZUNIwRvS5PN9TzdgFBzgz6XJ5wgTZC2Os/wFNlH1AhXR1g5qP
4plqDUZ+65iDg2zrB1e4KFx8zk38DQ==
=Arp6
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
