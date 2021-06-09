Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037403A14B1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhFIMoU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 08:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234092AbhFIMoS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 08:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0588F6139A;
        Wed,  9 Jun 2021 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623242543;
        bh=vhthPvN4SbfeT6gkUtHzXTCMycYQGIxRI4dMcim0R44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHU1o3laSZ3HNiecimURPirmf5RQ1zOhnOdCtEcLJ9WRNOuheJ7R1qlD1BgV+AFp8
         nTmkL8yhvJ5tTGPGx8Dmy1hlb/KqsdNy/DDusiPl2kAfo5O7oQpes9DW4V3zwiaiVo
         Vo0pkv/uswOY51kzgVWIT5ifLunXgMZdgBDXzBlgVRIgFxAZ/NUDuJVtlwhIOV/FKl
         lB/WupAHmjf4GIVSH8X+H6x+7LbY0vwK4lWHE/hZpYUf9Op+YswepV4kHFwgIC7qxH
         7/V199dgfu2Rt84F5rUOt/XYLo/jIX3h4qxH/AXb/2amHOc5/faMMIQeHbBqvMJhcd
         7sBRbBGXqBQ6Q==
Date:   Wed, 9 Jun 2021 13:42:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 5/5] misc: gehc-achc: new driver
Message-ID: <20210609124208.GA5052@sirena.org.uk>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20210528113346.37137-6-sebastian.reichel@collabora.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 01:33:47PM +0200, Sebastian Reichel wrote:

>  drivers/misc/Kconfig                     |  15 +
>  drivers/misc/Makefile                    |   2 +
>  drivers/misc/gehc-achc.c                 | 160 ++++++++
>  drivers/misc/nxp-ezport.c                | 476 +++++++++++++++++++++++
>  drivers/spi/spidev.c                     |   7 +-
>  include/linux/platform_data/nxp-ezport.h |   9 +
>  include/linux/spi/spi.h                  |   5 +

This clearly seems to be something that should be split into separate
patches, even without getting as far as the code it's hard to see how
changes to spidev.c wouldn't be standalone changes that should be split
out from what looks like adding two new drivers.

> +static int gehc_achc_probe(struct spi_device *spi)
> +{

=2E..

> +       ret =3D spidev_probe(spi);
> +       if (ret)
> +               return ret;

This isn't integrated at all with the flashing code, userspace might be
trying to do something with the device while flashing happens.  I would
expect at a very minimum that we'd be hot unplugging the spidev while
the flashing is in progress. =20

> -static int spidev_probe(struct spi_device *spi)
> +int spidev_probe(struct spi_device *spi)
>  {
>  	struct spidev_data	*spidev;
>  	int			status;
> @@ -789,8 +788,9 @@ static int spidev_probe(struct spi_device *spi)
> =20
>  	return status;
>  }
> +EXPORT_SYMBOL_GPL(spidev_probe);

This really looks like a very, very bad idea in general - attempting to
combine the unmediated userspace access that spidev offers with an in
kernel driver seems like it's not going to go well, as with the flashing
issue.  Really this looks like two marginally related devices that are
getting glued together which is abot the best case for this being
supportable and even then it'd need more work.  I'm not keen about
providing the interface at all as it's the sort of thing people are
going to get wrong a bunch.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDAtx8ACgkQJNaLcl1U
h9ADPAf9EZGtH51/7NaoU0frDOEWgaHmDK2sCIFNXeQnJ2qk5/aC19fI1piHKARl
Zk+qyQmBi0wYcStGbDztvvNjw4H0JT8kh1jFtZlIYbPWTPLXoDyElP/WVYRazXsI
yO+f37gmyTLl/u5h52dzk/wmLD0d2P4Lhv8ADb/Fx6hIclr41AKsjd7E2HYrn8Fk
aafJgW0tiP7TFRzeBKFNdYjHt4CipbdTB2vid42NkOHsKi95g+gwku4jNrVBCZ31
mmMKNWJTD+psrnwWtRvmW3gtxr9pkg5OrRDMshKfPUBoBYDSXwwheQa4xGJvgUN1
NCy6YnQx3t7LXdAa1H03sg0byA1/jg==
=uTrl
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
