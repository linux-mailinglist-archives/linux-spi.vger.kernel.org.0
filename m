Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AB2E70CF
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 14:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgL2NOL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 08:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL2NOL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 08:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D092D207C9;
        Tue, 29 Dec 2020 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609247610;
        bh=F1E9cB5RvfAMSJ6P7U5Sn/01BAPEd+Mq8/e9iajd2qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkAPvYMbjLtMOPbrg842+X7xhFtp+35t4MWGNuATCZQzhPQifaaEYDnaqHI/QXLot
         QEppU0n/o1oYmqaoLbW5llYIlrQbVf5s3l0i4h9Emy8fj53vL3GfkyEjbepIVudWZ5
         GnNO6d4QKKYnaejd9nTY1lVsvs5ZvDUmyKT7IgToX3HnuQVwZyoiza4y7Aki+YKRgp
         myhlWCUpEgjMvcCOalbmxD8uL12J9FRrH2Q7PsY6MXTh2vB17X6cfL/RvhyQCLKJ2Z
         s7xHwpK+Sb7PGj7qTFD2LTHFM/sVKtt88GzUsg19N6hQ0b/49ryjcJiQ7KI4AcLinv
         jx/O/1MylT9kQ==
Date:   Tue, 29 Dec 2020 13:13:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer
 waiting time
Message-ID: <20201229131308.GE4786@sirena.org.uk>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
 <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
X-Cookie: Mother Earth is not flat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 01:27:42PM +0800, Xu Yilun wrote:
> The xfer waiting time is the result of xfer->len / xfer->speed_hz, but
> when the following patch is merged,
>=20
> commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's=
 max speed")
>=20
> the xfer->speed_hz may always be clamped to 0 if the controller doesn't
> provide its max_speed_hz. There may be no hardware indication of the
> max_speed_hz so the controller driver leaves it, but exception happens
> when it tries to do irq mode transfer.

Does this still apply with current code?  There have been some fixes in
this area which I think should ensure that we don't turn the speed down
to 0 if the controller doesn't supply a limit IIRC.

> This patch makes the assumption of 1khz xfer speed if the xfer->speed_hz
> is not assigned. This avoids the divide by 0 issue and ensures a
> reasonable tolerant waiting time.

It will cause absurdly slow transfers if the controller does actually
implement speed setting though, if we're going to pick a default value
I'd go for at least 100kHz. =20

>  	} else {
> +		speed_hz =3D xfer->speed_hz ? : 1000;

Please don't abuse the ternery operator, write normal conditional
statements to make things more legible.

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/rK2QACgkQJNaLcl1U
h9Dymwf/QLkOzrj6ACi6NcWjvIm1O33sTuJ1CrsrHVC9YTfzV+k6Ru9q0P8b0sNj
tFfX4dEh8017F6KgSSBt1Hj5nR+xD4RfkmNueV5BVEMj5C1g+wZbX+KvzGPdImk/
TRJ/oactqQ6oYHvbMkDGzIvh5WcPeAozmSe1yPLIBw1Y4Xihx8CHu4Vf/BrfS6rl
aK2jvKAN484thgw1J6hK7GXPSzBJZwifiaQivbJJ1OXv4BMfp79lorCQP1l0TDZk
9LGD9uFx6vytgtcBJp7MQASBbDKVMjJ0L6T5lfsqwiBD6lKt2Csh3pv51Fc/S+VQ
3MiHEJw90NDSVzzfy8VntUJDLreUeg==
=HVTS
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
