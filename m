Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257711CB603
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHRbh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgEHRbh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:31:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F0E2184D;
        Fri,  8 May 2020 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588959096;
        bh=WRzoALlV7ZN2GHdbZQhsE+HYWowuvtNz9dMDDXuhI88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5naS5m/e40q+uLMWZT2ttFDa7TnLxzUiR71erzt4j7XYt5I6AOb2wMcM6kEGONTP
         hw8OrJzgPzqmGwSbg9tIvYEwaV4mFe55M5HRNvvpzJrdEEnnbI7Smr1TNaGoHC8m6a
         YH64UJVl1r2J0MtcG5ZYmGVX5V3q/ct1aI5IAh1I=
Date:   Fri, 8 May 2020 18:31:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200508173134.GP4820@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BnCwdHgQ2ZomtW9r"
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-9-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BnCwdHgQ2ZomtW9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 04:29:33PM +0300, Serge Semin wrote:
> If DMAC register is left uncleared any further DMAless transfers
> may cause the DMAC hardware handshaking interface getting activated.
> So the next DMA-based Rx/Tx transaction will be started right
> after the dma_async_issue_pending() method is invoked even if no
> DMATDLR/DMARDLR conditions are met. This at the same time may cause
> the Tx/Rx FIFO buffers underrun/overrun. In order to fix this we
> must clear DMAC register after a current DMA-based transaction is
> finished.

This also looks like a bugfix so should be pulled forwards to the start
of the series if possible.

--BnCwdHgQ2ZomtW9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61l3UACgkQJNaLcl1U
h9BYHgf9Fl+KkM9DAYgx9AGChw/IYpN7v0C5DO9u46ti7pzCXkna45nllKWyJ+W6
/IBw7tAETN0X3Oeg7yrgik/DAKX58MapNxW3Iq3iYa/RBX/2Lkxqb441hmmNFgOp
g8lI/G8gh9WkKF1E7lVqqBScEwiRbGDWTHWM2WuYSr8mAnK5FL+HLvF5YQKvAcHm
1TD3/v8ckN2iTXWH8IWjBdqJI7Y+2TXXz1Xr13/laIDvDq51xtJk0YXUstdLcSnq
sPwjaTA+RTDZKCa2NsFKx04M3JYrJMIq8YjAoCjhKOKBJf3EaJ/EalmfaTucfs0O
NwU9G+7xV1+6hlkILdXn+sStvR7LTQ==
=TR5g
-----END PGP SIGNATURE-----

--BnCwdHgQ2ZomtW9r--
