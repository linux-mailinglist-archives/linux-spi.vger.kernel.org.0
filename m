Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55037684C
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhEGPvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 11:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhEGPvm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 11:51:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E4A5610E7;
        Fri,  7 May 2021 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620402642;
        bh=R50tC1p5k/fPOb8d3kN+2f3M0GETRvSe71x08MfhO6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGlDfGcXmDAWISdtPRP5bhOPYFFhqUAcejbB5mKHf1pyc5HUww39ATEyEXWtaGdLh
         QeFyhjSY0cV5nj0HQRrfXXmBNkbsYCUFE2BpKyEm5aJyf/rR41KjCiby5h4rCfvVTf
         gaQjK8C1seVeTXuxNZZkTFJTIw60XtvBu1eG6QKe6ScB/vPdIpObN2Pq68wz+0JTnt
         2+VUynf9i9JxYdPFwzS8tK6dDYjgZ5bs0iMLFlGnRz/6q/EcMq1cPp8K4B/zY55j7X
         ku2QTDhOqplJ6c60NdnUs4gg7N4udi/gWNfN/DzN66TfP9kxK1bekupfCDICBgS8Ig
         Hl8fI+n6b5pdg==
Date:   Fri, 7 May 2021 16:50:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/6] Avoid odd length/address read/writes in 8D-8D-8D
 mode.
Message-ID: <20210507155004.GF6383@sirena.org.uk>
References: <20210506191829.8271-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <20210506191829.8271-1-p.yadav@ti.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2021 at 12:48:23AM +0530, Pratyush Yadav wrote:

> Patch 4 should go through the SPI tree but I have included it in this
> series because if it goes in before patches 1-3, Micron MT35XU and
> Cypress S28HS flashes will stop working correctly.

It probably makes sense to apply these to the MTD tree and then send me
a pull request to avoid any future conflicts with SPI.

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVYasACgkQJNaLcl1U
h9Cixgf9Eaf2a++Xk1MHN7iG0wzgm8We/j3PyiWfvSK9MSUK0Lh0walcRHzraZE3
Jv7OZrDcVwJ5hfho7LWkTQPxny69b8E0bvm96G6FfSQYoVDtkrLi97/cQfWsgrln
ujFsaAMy/fIZNu9CVkdspvfdY/BeVdeD3LhXkDWEkR5KfUz67g0ReT2jSqILU3pj
QFQnwIoY+ZuUPoTajkyedL4YN86TJkKi17j5giHhDGblQVdYPhNKUIuv4ieaoLhF
s/28bYtKWAnwtXMNUQ6q4XAT/jdEo/MBMU7vxzWRfE1hNEBtYlrX82EurTIP+1b7
DVWuFR9d8sry4oe19mg9xkMQNHC6TQ==
=zcei
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
