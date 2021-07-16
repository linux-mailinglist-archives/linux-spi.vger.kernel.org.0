Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AC3CBBA1
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhGPSHu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 14:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPSHu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 14:07:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD0D6109E;
        Fri, 16 Jul 2021 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626458695;
        bh=svpmqUNLNI4uOXLl4ZjUdQzk1/u+Oq94ruw6eFuiKgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYbOHQ4smZYrmAxsTta9yeIr1xaIpXGBPr8yfmB9stqtDSxB7YGOFocPr3fRYuB/h
         J1AvKEuZZDaFqUUM3ITHW47CZC9J8+/hVmXL5c7h3E6DLxpob19nb/rp/HKHW7DiOB
         RRN9jiWdvk2nIvoMqhLKOBGZVkGV54dnCsQpoDlBfayFialQYeRqCW+fcMX74bkhZk
         yQQ9Xkp1ut38I04F8bsZ+WEQIxnX/NDsNep4jnTTaPZhqnZlWpkyWRHXpLs7ay4Kkc
         hU80kmOd1HN1o8ZA0nBxbzhNihT0UhmLOvWM/W4ycuNuBecGNLGN7lN5Ei21NP8cAP
         1WAZkElhsC1Ow==
Date:   Fri, 16 Jul 2021 19:04:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Apurva Nandan <a-nandan@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Message-ID: <20210716180452.GD4137@sirena.org.uk>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com>
 <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
 <20210714162805.GE4719@sirena.org.uk>
 <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
 <1cebc261-e0aa-572a-8083-1e3ec0d09195@ti.com>
 <20210715164142.GB27092@sirena.org.uk>
 <20210715183627.qtibbtrbsq7wsx42@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20210715183627.qtibbtrbsq7wsx42@ti.com>
X-Cookie: do {
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 12:06:29AM +0530, Pratyush Yadav wrote:
> On 15/07/21 05:41PM, Mark Brown wrote:
> > On Thu, Jul 15, 2021 at 09:57:51PM +0530, Apurva Nandan wrote:

> But then the problem is how to tell the caller whether the poll actually=
=20
> happened or not. The other option I see is:

>   ret =3D spi_mem_set_autopoll_op(mem, poll_op, mask, match, ...);
>   spi_mem_exec_op(mem, op);
>=20
>   if (ret =3D=3D -EOPNOTSUPP)
> 	poll_status();

> When spi_mem_set_autopoll_op() is called, the controller driver can=20
> check if it can autopoll with this op. It can configure its autopoll=20
> feature based on this, and can provide feedback to the caller about=20
> whether they will then have to poll themselves, or it has already been=20
> done for them.

I was more thinking about just having polling be a separate operation
entirely, but you're right that a controller might integrate polling
with the actual operation so that won't do and we need something more
like you suggest.

> I like the latter option more.

Yes.

> I think the question we need to answer first is whether doing all this=20
> is worth the hassle. Are there enough controllers with this auto polling=
=20
> feature to make it worth the bother?

If we build it they will come! :P  But yes, that's definitely a concern.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDxykQACgkQJNaLcl1U
h9DeYAf+M0UjynIJV53pmPWhtqKLcTYuUyAfzsq5KdUmQUygVseEKABeDjIdUHqY
zQHJ1kYD2L4AYcd2jl6sEZlHqQ+XSaF2KTUSmf6JlsKzMCeiN7Hj481jHPFfn9eH
LdzfpP4LmJnXEry7ousSMpSs5wDicMLEL31PnEgR3uKZBbvvNOvVZ+NhekgrAMCw
I2qLvz/aQr9IclDF8Fbt6jl9ftUqDlLsitqw+/ut4E2YMWMs9dJouyaPewE8Sq8Z
JtBdvaoJKIQ60gLqynKJ8Xkzsj67fA5A6su1FNcRAqRemQ7RhQlVCZKDDaOSUdVn
OcELnALtL2jgvUUW3vltWDj+kjVmPQ==
=BAdU
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
