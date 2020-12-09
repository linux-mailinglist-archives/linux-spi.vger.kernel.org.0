Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F42D4B16
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgLITzI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 14:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbgLITzI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 14:55:08 -0500
Date:   Wed, 9 Dec 2020 19:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607543667;
        bh=U6M7AWAv6/CKWCwL3u7zyzCT2QpPcnIsDTnxCILhtoE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5oePjpSYh/pjaTGOBdUkD/N7rmXPeOGWuunrd7QJVC9tLjyz3Gu+CnZOXuqP2JDd
         f7t1X14sl/CQtxf/+P/TN2h1DDCIbfBYvWFJl0Fv8c3rHGS3pZf6H8aDwUa8+Q7Qhq
         0G21lwqvUiJjyiVhgX9p/0HIeFGKwazd2PzjLYv1iBV+4T31h6qF7pg/HSPshlUk7H
         tGgCc+GIG4NDEeKu6GcUoT+AtckMhzVhXQw+niZS76SAwF72Zyx7BowkZle4akVw87
         TXxBbXhHQXS8b6YknfSt56wB8/uT/t2KUmaat/YT48sUXK3w+15Sa1hk7rA9JXeWN1
         eCoiWm2cN6RCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201209195420.GD4790@sirena.org.uk>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <20201209194636.32f4ioxxdggezklr@mobilestation>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2020 at 10:46:36PM +0300, Serge Semin wrote:

> On Wed, Dec 09, 2020 at 07:35:14PM +0200, Tudor Ambarus wrote:

> > Make sure the max_speed_hz of spi_device does not override
> > the max_speed_hz of controller.

> I have doubts that's right thing to do. It seems better to let
> the controller driver to handle the speed clamping itself, while
> to leave the SPI client device max_speed_hz field describing the
> device speed capability. Moreover the SPI-transfers passed to the
> controller will have a SPI-bus speed fixed in accordance with the
> controller and client device capabilities anyway.
> See the __spi_validate() method for details:
> https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/spi/spi.c#L3570

Right, in general we aim to do this sort of fixup on the transfers
and messages rather than the devices, I guess we might be missing
validation in some of the flash acceleration paths or was this an issue
seen through inspection?

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/RK2sACgkQJNaLcl1U
h9AOogf/bm8GIbL9U7qDE6v/ghRo5Tj9+6YBvMNAsTKtmGctQqMB2AYegZ2VEeHQ
9EuV70kEux34udEG4pgmOqcSyZOt1WWgkkE6BvEHQHONgZ9y75JkyIfBk3/iuwpN
HIOugg60B1ZaJShUIQynQj5RWKlgZ/T4ksR+v5BGB30kZzirOgtSKEQ7o0bDKyAy
1q1RK9r9ycVfWsqHQz9aFEoYWBmC9i/qyUxD0enjx+BjTEar7daNI1XrG4z5Bnzl
6TpHTUSdFa+RLQP0gQ7/ltCBca2z9jDd96xk6jNTcjrEJhXSbuIA/BhCUDjG7WtY
13AEwYvRAZMXSkYSuiNoXA9Y6S/N+g==
=TYn1
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
