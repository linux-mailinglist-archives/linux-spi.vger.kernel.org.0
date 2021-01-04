Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C842B2E9F98
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADVfp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 16:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbhADVfp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 16:35:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F83221919;
        Mon,  4 Jan 2021 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609796104;
        bh=p9hRd4ZU6GhtvzVJXohp3lv14K7e/yS4HdflvdROGmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIb7NdDPxXWguQfra/DwaPKwpBpTxf/2WRL0yTM6d4Tvq67xdw4LI91gdvDjIQZ13
         9e+rCMu5pKOlKhQwHvqKv3rzj0YVbgyxQ6kxg5+a/oBLYhFP+74iZ2AUkYS1cWoVj8
         jDdjeM7/yLD5CYCx0Ela4F7uvN1FqWWjm/UwqYJg94+m221TspUxczfecmi/XZMCe1
         Y4PnaFUYxYfJOC1rLLdevSqKMu6o/chTqhSRJ9c2dBn7pxaZcKtvw84sKAaxJl1821
         YGZxlvDMmVvF1or+zOohXv2EuVMn98WtRGk3zV/Y0/X35JjaCVNQX8MCG75JKIh1uA
         RhqcrVu/b6UMw==
Date:   Mon, 4 Jan 2021 21:34:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gustav Wiklander <gustav.wiklander@axis.com>
Cc:     kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Fix so the module is autoloaded when built
 as external
Message-ID: <20210104213437.GM5645@sirena.org.uk>
References: <20210104153436.20083-1-gustav.wiklander@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KSyhVCl2eeZHT0Rn"
Content-Disposition: inline
In-Reply-To: <20210104153436.20083-1-gustav.wiklander@axis.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KSyhVCl2eeZHT0Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2021 at 04:34:35PM +0100, Gustav Wiklander wrote:
> From: Gustav Wiklander <gustavwi@axis.com>
>=20
> The spi framework sets the modalias for the spi device to belong in
> either the acpi device table or the SPI device table. It can never
> be in the OF table. Therefore the spidev driver should populate the
> spi device table rather than the OF table.
>=20
> NOTE: platform drivers and i2c drivers support aliases in the
>       OF device table.

Why is this a good solution rather than ensuring the the OF IDs can be
used directly?

--KSyhVCl2eeZHT0Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zie0ACgkQJNaLcl1U
h9D5xAf+L4jboiQY2mS70nBESCg1h9cb/iMPsgozlHUTXreWtx68MCAiBSpjwJds
Dw7C3XGUPGgyIGdx+NJFugXkjUh9tz1znwVn8/1Tu3wT9nyX6Y4Pg47n4Vxzs8cy
IPxBqgdt0EgQvvuHVu+j+IG/AaTWBmT6mDwQJOLAKD/VgKmrFNqIGrxSuhCGSLjN
I8g+5KxO1Nm0ZLRAWqZI74aSMzjAfGKhTX8PxPEwK+HXO3AzZo7aeePTVl+LNjQ/
dplHJTfJkNnOoKkvWEjmmTc45AqEuelO7IUw8l3gHncVUxNp9oHcItDgB63V12pn
JZJ0i1y9Tqv4iC/Bo5oJQZF3cn3Gtw==
=AEaJ
-----END PGP SIGNATURE-----

--KSyhVCl2eeZHT0Rn--
