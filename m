Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453891804D4
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJRbd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 13:31:33 -0400
Received: from foss.arm.com ([217.140.110.172]:39918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJRbd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 13:31:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD561FB;
        Tue, 10 Mar 2020 10:31:32 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8C53F67D;
        Tue, 10 Mar 2020 10:31:32 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:31:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Otavio Salvador <otavio.salvador@ossystems.com.br>
Cc:     kernel@esmil.dk, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: SPI irq regression
Message-ID: <20200310173130.GN4106@sirena.org.uk>
References: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Content-Disposition: inline
In-Reply-To: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 03:54:20PM -0300, Otavio Salvador wrote:

> [   46.186916] spidev spi0.0: SPI transfer timed out
> [   46.187435] spi_master spi0: failed to transfer one message from queue

> Reverting this commit makes SPI to work again.

> Any ideas on how we can properly fix this regression?

Does the interrupt ever fire?  I'm wondering if the DT is wired up
correctly for the particular SoC you have, or if it's even wired up at
all in the hardware.

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nzvIACgkQJNaLcl1U
h9ABYAf6AgPrfiW0av9gNqZxLk4dWqC5oYRZeRAbDPi3S87jWIw46KQjnNvkBwTQ
Tx5gTJGr7SlHLj4XskYbMsAipmYxY++Q/t63Jt5ICVavbAAi0WDw0x1blnxHRoMq
/Mt1kjlOFXMwMyJGcx7kXMQZDCE/YetifA3xBhUCnzWcIuau3D0JEmMxIsAig7tt
mSCaUQdpVhdA+AgIFVg0XQjgPZa8tZ2rWhD29mLg7EILVc+y6BaAKWLbQlZjZIm5
/OZmPZ9SC4Ro67Byb+Jedj1zGVU1yv62aaqrH0EOvPWj5Hfl3QFjWPVMBXuc+ucL
2XiZ8E4ea73h59Lrp5wIaOJVcZncQw==
=zCzy
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
