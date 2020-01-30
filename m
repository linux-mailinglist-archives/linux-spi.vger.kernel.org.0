Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9214DD06
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2020 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3OqM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jan 2020 09:46:12 -0500
Received: from foss.arm.com ([217.140.110.172]:53854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3OqM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jan 2020 09:46:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA6B81FB;
        Thu, 30 Jan 2020 06:46:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C943F68E;
        Thu, 30 Jan 2020 06:46:11 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:46:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Message-ID: <20200130144609.GD6682@sirena.org.uk>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2020 at 02:08:24PM -0600, Eddie James wrote:

Overall this looks good, some comments below but they're all fairly
minor.

> +++ b/drivers/spi/spi-fsi.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) IBM Corporation 2020
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +
> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> +{
> +	int i;
> +	int num_bytes = len > 8 ? 8 : len;

Please write normal conditional statements to improve legibility, the
ternery operator isn't really needed here.

> +static int fsi_spi_reset(struct fsi_spi *ctx)
> +{
> +	int rc;
> +
> +	dev_info(ctx->dev, "Resetting SPI controller.\n");

This should be lowered to dev_dbg() at most, it's not really adding
anything otherwise.

> +static int fsi_spi_remove(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions, if they can safely be empty then it should be
possible to omit them.

> +static const struct fsi_device_id fsi_spi_ids[] = {
> +	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
> +	{ }
> +};

This needs a MODULE_DEVICE_TABLE annotation.

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4y7DAACgkQJNaLcl1U
h9A9TAf+MkugoZ6sUpGxBfx/kkjLIYhw0zx+HOwK7LSA++HLwW76LEm+KamfSANm
7g9UhKQUdHhBs2ahWu+pZwF39cd4HgoQqCSe6iW42IUWvh5XVXlTYrDqnh3zoqYX
V1NjkEDzs+50zaJIJWAMAZmQ6vZYupmDEtVO6oeAa1Q2GlhZbYgEkpLrEuXQFm35
dyfhAZTN6VICNPaUZXzZdg+5lFm7wskffv0RQhUUxo+5aPoa/o8EIEqHRb3emjvS
nHcoisf9jxj8YJWkpzCJ5lOf+naaI0mENZa8k+Enbtkh8iktHNWp0tfPKmgEpMuF
4qfEnnMtc5U99fHkihfnLTy1Afzg2Q==
=Hyju
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
