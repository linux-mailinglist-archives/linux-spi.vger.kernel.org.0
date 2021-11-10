Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37DD44C501
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhKJQaU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhKJQaT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Nov 2021 11:30:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0233260E8D;
        Wed, 10 Nov 2021 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636561652;
        bh=qpDllwM+fvEUE1SQHUjjUyeOL8u2sxQ8LifgIN3WRo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDHL9Hf+8tL3QKWK0bgNJH8QD/Lzox7CEYqUXVVn07gCSoV4bCbfE1A8b12CBM3H5
         5GLwEz6s+HhRtPeM18wK2eSESUjSOIXBgaEbVlN8iZqf6KLmCVg35rwwhX/vI2N3OX
         gTvZz3qihOd1vm7dFibcyQrAYmCkWfP7ChIXlo6GWaVKzRq35+/YQK2y5mOoiRhE/D
         VFgW8QQb9LHZes+I0QI/zKAQqHorklQeYWI4krBEO+59eu1AN6TMeqKaugvUWoQGn4
         rnL7l+Ik9DgKIBsKM1HYabJPzZS3NtibbKoMPomGv9PEui/gG09W2uFLtMVMAS7ilo
         IGUP2zQQxPhjQ==
Date:   Wed, 10 Nov 2021 16:27:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
Message-ID: <YYvy79HfTvy8hC5/@sirena.org.uk>
References: <20211110160836.3304104-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PeOhnV+CH9K7nNWV"
Content-Disposition: inline
In-Reply-To: <20211110160836.3304104-1-michael@walle.cc>
X-Cookie: You have junk mail.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PeOhnV+CH9K7nNWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 05:08:36PM +0100, Michael Walle wrote:
> Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
> SPI buses") introduced a per-controller mutex. But mutex_unlock() of
> said lock is called after the controller is already freed:
>=20
>   spi_unregister_controller(ctlr)
>    -> put_device(&ctlr->dev)
>     -> spi_controller_release(dev)
>   mutex_unlock(&ctrl->add_lock)
>=20
> Move the put_device() after the mutex_unlock().

Do we even need to unlock the mutex here?

>=20
> For reference, the kernel oops is:
> [   20.242505] Unable to handle kernel paging request at virtual address =
0042a2203dc65260
> [   20.250468] Mem abort info:
> [   20.253270]   ESR =3D 0x96000044

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--PeOhnV+CH9K7nNWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGL8u8ACgkQJNaLcl1U
h9ARQAf/QJ1CMUYtqZJT5IKWPYvlRJ9hbMIp39/Bidz/cPAyf3uR6csWmKleqMJo
ZBoHP4N0wujtU1gGubHMvXkw2lUfTmSwYfxIoL8eocL28OMWbfNIVArMDCPa4SCI
WlUlgxJ7sMbjdDsB/Amsme2buFWLetDcYx+7iztRj7mizSmRGgeP9NB2+HuuRRjQ
vxG4sADx5bi6zbJS4c5dCr7jpl5/jBzHnk7NPDIuRvIGp4KPMcMQ3ilMb+X87wlL
G/IyRKpN1aauDko7FHmYJTBhNP10el5TWGSs+T5sNMDLchq+1J7pWLE0aRKIWixQ
4o8b/yj0xosjTaf3rvoD3h2GQyj+jQ==
=Ks+F
-----END PGP SIGNATURE-----

--PeOhnV+CH9K7nNWV--
