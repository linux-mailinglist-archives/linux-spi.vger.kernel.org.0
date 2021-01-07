Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B982ED39B
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAGPg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 10:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbhAGPg5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 10:36:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8CBA23428;
        Thu,  7 Jan 2021 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610033776;
        bh=nf9ZDJUWZ91Pr9DLAW/Srg3b6tZhGcc403BBHh5TTiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyZlEooieL/PC2dcKuNzDEEi+tpx6NlTlr5JWB0LCYjPqqz6iFHSI+S6zUv420kVF
         zbFLnwmoqK2/ztqq4kS/jpPswv8GvM+DdGkbEN7LhSVgq7bm1XkZ7b/tUPbnEmqPa2
         quMG8IayuCsX4GfYUX8Mnnox/DkONaSVIFbSg6HKu28+sYCUOmiXu3FnbzNzFI6i2D
         mmn9GzKN0KggJwFnYiD40zIRpQ56YC8nwz9yv/mh4jgQT9fDtG+iOYt5/9AE+CRt3v
         8ZuK4eX+lh+l+n0wuLFwb9VjmHr5JEley9h/T5J5ODtdsCvqtUWQctFMN4CxWMCtWR
         QlIqqPqeSFlVQ==
Date:   Thu, 7 Jan 2021 15:35:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
Message-ID: <20210107153546.GD4726@sirena.org.uk>
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
 <20210106130049.GC4752@sirena.org.uk>
 <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
 <20210106173759.GF4752@sirena.org.uk>
 <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2021 at 09:57:01AM +0900, Vincent Pelletier wrote:

> I've started reading spi-bcm2835.c, and while I cannot claim that I under=
stand
> everything I'm reading, it raises some flags:

Copying in a bunch of people for that driver.

> - it does not use "spi_finalize_current_transfer(...)" at all, but rather
>   "complete(&...->xfer_completion)". The former only calls the latter,
>   so this code seems technically correct, but this looks like an
>   abstraction layer bust.

Yes.

> - while it uses "complete(...)" on its IRQ and DMA transfer codepaths,
>   I do not see it being called on its polled codepath
>   (bcm2835_spi_transfer_one_poll).

I'd not expect this to be required with a polled path, it's only needed
if the transfer function returns a positive value indicating that the
transfer is still in progress which shouldn't be the case when things
are polled.

> - ...polled codepath which checks bs->rx_len to tell when it's done,
>   independently of transfer direction. And while tx_len and rx_len are
> initialised
>   to the same value, only the field actually corresponding to the
> actual transfer
>   direction will be updated within this polling loop.
>   So maybe some transfers could timeout in the polled codepath and would
>   still end up in the IRQ one which would end up calling "complete", but =
this
>   looks suspicious.
>=20
> Checking on 5.10.4, I see:
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer=
_dma
> 2
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer=
_irq
> 1
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
> count_transfer_polling
> 27
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
> count_transfer_irq_after_polling
> 0
>=20
> so I am apparently not triggering the poll-then-IRQ case, but am
> triggering the others
> on this kernel version.
>=20
> On 5.11, this becomes:
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer=
_dma
> 2
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer=
_irq
> 24
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
> count_transfer_polling
> 0
> root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
> count_transfer_irq_after_polling
> 0
>=20
> so somehow this is not triggering polling transfers anymore, so the
> maybe-missing
> completion call would probably not matter.
>=20
> Also, it sets can_dma with a function pointer, but ends up only
> checking can_dma as
> a boolean and then calls the function by name rather than using the
> value stored in
> can_dma. Again this looks technically correct (and is very much
> unrelated to my issue)
> as can_dma does not take any other value and a valid function address wou=
ld not
> evaluate as false, but it is surprising to my naive reading.
>=20
> I'll continue poking around later (especially checking computed timeout v=
alues),
> should I submit patches for s/complete/spi_finalize_current_transfer/ ?

Probably send the completion patch, yes.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3KlEACgkQJNaLcl1U
h9Avxwf+POcQ9p9Im5CRxIDy09z0IDLF9fu0nV06tFo02qT6OkhdYZREwQvViVHl
hJGDzdO6utIfY2dij61yum0o+l/7k4NK3tX1ttsnBqgzjsHyhbGvnJrTXew0bpgs
zgXLRqnxZSP85uEHalLYeiCwilg2NMRnXpRZ5b11DmmbOPlFE8/st3R1SFEluwKq
POdEX1QyBfFUOiuxIfIbulXJlIDa+csIw/ZyUWk6eOPXnO4eb5gH1Pi2LZ6n9ZUy
/lWtVBIQauhjo1I8SuJ/KTDD8lX1JEu5HTtAjk25Sn/97PxhCcGJQk3RH4c47slc
fdx2LlbxiE155KhiLf6PKXQU++dNcg==
=xgEY
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
