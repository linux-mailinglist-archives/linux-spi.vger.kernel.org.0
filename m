Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4113C766E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGMS3Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 14:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMS3Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 14:29:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 485A961369;
        Tue, 13 Jul 2021 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626200785;
        bh=g95LM+OolBt7yWYEf70Dzg9NWPjNuRJ/AH7jnCQZfEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVUB4Wz6wjTGmES9MYG0VFvTNbL1NlU54nGkaw6hEA2EeNKF7S6KbJGvQEtfDVH4A
         jqihZKr1W8jiBh8L4T6VW+lDYxtVXwJSyMV5nSiqwtxlefYSzBjGPM6dcbTyAuW4/2
         rSNy7MIpc8QgDM2Y9K9bB7Lc+/SwbSihmrKb9sx/5z2UBmw8gTWgNxaiWbs282gu5z
         YQeJSt/rFJb4kig0oWQiFZvu/3urutLXi1+m3z59C05GF9sb+GTLH22L7QOQEOFhK5
         dFujAgf7mhky2KU5J2Ru1LDp0W94KfT7HqwFd9fKugfONMrDyGFNAO9WXHB56CRxKt
         +j1lvxLp7Tl0g==
Date:   Tue, 13 Jul 2021 19:25:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Message-ID: <20210713182550.GG4098@sirena.org.uk>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <20210713125743.1540-2-a-nandan@ti.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 12:57:41PM +0000, Apurva Nandan wrote:

> cadence-quadspi controller doesn't allow an address phase when
> auto-polling the busy bit on the status register. Unlike SPI NOR
> flashes, SPI NAND flashes do require the address of status register
> when polling the busy bit using the read register operation. As
> Auto-HW polling is enabled by default, cadence-quadspi returns a
> timeout for every write operation after an indefinite amount of
> polling on SPI NAND flashes.

> Disable Auto-HW polling completely as the spi-nor core, spinand core,
> etc. take care of polling the busy bit on their own.

Would it not be better to only disable this on NAND rather than
disabling it completely?

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDt2q0ACgkQJNaLcl1U
h9B1lgf+J1v27tBOtxEJOZLkUtw7AtbmKuxiGKj8+uF+cLD7iLuSHU+tefh/czz4
Go/usaLS3jzWxw3lcdLE4NMGYokrUxUG56bQykwzpJwt8m++FDCgbTJqqo0wyljw
qqVXyLUQEBb7G3GbISgnmQosb8wNmfyNryyk+CMODfCL3Xy/TUdZYVgBV435CmZk
7FOYNynb0Z9fl/stGxTOmHcuUdh6hWoXI49/be+1o0FlqeUZ3kolJuSIPAfIj69Z
QRDkXExOY/PrOpo7AkAW3s+Z8ynXnMtPlMYZODBoj/viGo44wYlIkrQie+ZrERWj
z2Z1yiKmR1zjMW7CHGyeoMpjc6lHtw==
=yN9D
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
