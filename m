Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655794651E9
	for <lists+linux-spi@lfdr.de>; Wed,  1 Dec 2021 16:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhLAPov (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 10:44:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52668 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbhLAPot (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 10:44:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4424B81DF7
        for <linux-spi@vger.kernel.org>; Wed,  1 Dec 2021 15:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93FAC53FCC;
        Wed,  1 Dec 2021 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638373286;
        bh=8afl9RC76irW22Aoqi4EZBWsAvd5L8Q+12CUW00/ufY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLQ8Zb9k+HIZ5yeC5X9koxlku4Y/gYwUOdwuFijQycjI+v/YUp9IEhmpEHMNe6HrD
         dGklyN5BqftndmLvvmtedWE3hL1TWzYsxsp57ii8Fs8xWJZzCxmEFKUv/3Inti9Oo8
         zO5epUuDBjOOUcVmmXyXlE9IHjE1Q2PZGDeuhwgTTGx6KziVlCgQ8Dd0nvm/3JRNwo
         aP7yZ/73/OfUmKd6a7fO1aFPPRDD4pb/bhnYDCj78/GDUU3VZXiViYm0M8ZvlDt+or
         fhNTLIF4mVPiVyf/c43t/RnhB6FgQTqt2E6bg+IO/0AU+RRcEf9nTnilHRYNHzFoka
         XfjWFyaIAE7yw==
Date:   Wed, 1 Dec 2021 15:41:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: fix erroneous logic inversion in spi_match_id()
 usage
Message-ID: <YaeXoiFRAcxVG3I3@sirena.org.uk>
References: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xY5nXMwOp7b+XbvL"
Content-Disposition: inline
In-Reply-To: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
X-Cookie: All true wisdom is found on T-shirts.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xY5nXMwOp7b+XbvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 09:13:35PM +0100, Heiner Kallweit wrote:

> We want to continue in case of a match. Fix the erroneously inverted
> logic.

We do?  Why?  I can't tell from this changelog what the problem is or
why the patch would fix it.

> @@ -471,10 +471,7 @@ int __spi_register_driver(struct module *owner, stru=
ct spi_driver *sdrv)
>  				of_name =3D of_id->compatible;
> =20
>  			if (sdrv->id_table) {
> -				const struct spi_device_id *spi_id;
> -
> -				spi_id =3D spi_match_id(sdrv->id_table, of_name);
> -				if (!spi_id)
> +				if (spi_match_id(sdrv->id_table, of_name))
>  					continue;
>  			} else {
>  				if (strcmp(sdrv->driver.name, of_name) =3D=3D 0)

This appears to correspond to the current code anyway?

--xY5nXMwOp7b+XbvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGnl6EACgkQJNaLcl1U
h9CJzgf/dpe7rjHaPFn57DqMHVkdS6TFfqmZOeOdZDn3P2ZwFDwxYGmz04nni6cD
t0YXQ/HAYiBzb3Os41JTqAjD2jsu5qXoRzV4wrldOAfV6mDuEQHcEUnAA19lIse+
mZ6lGZ/5mUtbljl0vUQEt+UC1u4Idcx9Xoev3Qcmzt6zAeOtwPFbWgL7iFxjUOhi
FF7MzbkWyOQl3gSWKtLkRCF3iKhjg2SMlQ98BnzCtUOKqyDmUA5d6ttb120mHfrR
KhaLvl3r1quQAYx6KFWffnblEiDriepjkqvIHoxUB+QznIuCamAmNjgoKAWE2qEN
aOUYGINN74dhkQfdSF5/Mlkxjx2aJA==
=YmXl
-----END PGP SIGNATURE-----

--xY5nXMwOp7b+XbvL--
