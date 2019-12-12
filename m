Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE37411D39F
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfLLRTZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 12:19:25 -0500
Received: from foss.arm.com ([217.140.110.172]:54264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbfLLRTZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 12:19:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C24430E;
        Thu, 12 Dec 2019 09:19:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF2B83F6CF;
        Thu, 12 Dec 2019 09:19:23 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:19:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
Message-ID: <20191212171922.GM4310@sirena.org.uk>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-5-afaerber@suse.de>
 <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
 <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Content-Disposition: inline
In-Reply-To: <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 04:14:59PM +0100, Andreas F=E4rber wrote:
> Am 12.12.19 um 09:40 schrieb Geert Uytterhoeven:
> > On Thu, Dec 12, 2019 at 4:41 AM Andreas F=E4rber <afaerber@suse.de> wro=
te:
> >> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST m=
ode.

> >> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
> >> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".

Separate patch for this?

> So from that angle I don't see a better way than either duplicating the
> functions or using some macro magic to #include the header twice. If we
> wanted to go down that path, we could probably de-duplicate the existing
> two functions, too, but I was trying to err on the cautious side, since
> I don't have setups to test all four code paths myself (and a ton of
> more relevant but less fun patches to flush out ;)).

Yeah, I don't think there's any great options here with the potential
performance issues - probably the nicest thing would be to autogenerate
lots of variants but I think that's far more trouble than it's worth.

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ydpkACgkQJNaLcl1U
h9Crxwf9Hh/o+0lRcCax6Pd2t3iPgF+uG4xJ6LUUNfzNsOdYWHhRoEJC3NQAdbh+
erqhW4a1HuHtkFy9hM1gCLsfRyr9eA3x0+xVgj9WsbOe11mebr08oS+BaPHU2yUT
4XgXr/Fyi1s2x6q3R9C48jEGRyKy6nCKC9Lkh8dXitfznpmufSAEKzkYxZLo8hPs
At9L7La3QdwGjOTgHJ0DZD9Q6gQpsjhzWA8fkgHwzwjGsaw6pZair0XkaBPcg3/q
xyZyIzQejgHy5DhWRg9m+WSsoARvtMwSGv+061AOmafWOPBgAWM2z1wCH/+F0jqM
q/B0X6vyCHo7spdDxq+dhgsXrkrcBQ==
=OqPq
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--
