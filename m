Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC826B9554
	for <lists+linux-spi@lfdr.de>; Tue, 14 Mar 2023 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNNFF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Mar 2023 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjCNNEj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 09:04:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E82A2C2F
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 06:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAF74B811F5
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 13:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE18CC4339B;
        Tue, 14 Mar 2023 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678798804;
        bh=JKZcG52nxc6PnQXj2135tN/CylKY5M6+sI7Y8ubhkOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qmjd7SzCKTLs0Q/WnD9KauPr51nvkLrlonbSGdbRj5sVGuh+ljgEsjQNh2emX3PeD
         2Fzjhcq64skDiKqTsBWVJ1il4EhVvn1RbuIiWlHAyvJp5Wyc6nFyh1pCcW7hYo0sAK
         FE8EhO1flhRes9MHjXfLJouBpylm4/Dwe5lJvShCbF7PS7n2Ls3matPpFbA33IyfIo
         7ADT97jdeztt9lNOm14g6SE8Io36fGJZkpsn/D4qgagz9EYjYvny9H0L7FwEtto2c6
         ntksTTbJPRkjEo/Myd7w98d+rw1qx+N+9ZTHAvw/FMC/nmP/5ZnLEa81B0d40/6hw/
         ynNkYyA2SBVBA==
Date:   Tue, 14 Mar 2023 13:00:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <c4d651cf-ed23-4d5c-9536-40f70fd52a6f@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
 <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
 <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
 <4c46ffe5-6793-4149-998d-d76c37fca7aa@sirena.org.uk>
 <69b1b437-1e8c-1854-a036-5cbc8a81cbab@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ICJxC532CPfoxgBT"
Content-Disposition: inline
In-Reply-To: <69b1b437-1e8c-1854-a036-5cbc8a81cbab@csgroup.eu>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ICJxC532CPfoxgBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 10:33:10PM +0000, Christophe Leroy wrote:

> Looking at another driver I'm even more puzzled. That's driver=20
> drivers/leds/leds-dac124s085.c

> It also sets spi->bits_per_word =3D 16 , but is uses cpu_to_le16() to=20
> prepare that data. So this one should then work with any host=20
> endianness, but why the hell is it doing cpu_to_le16() if the data=20
> should be big endian ?

I wouldn't take some random client driver as being particulary
meaningful - people often abuse APIs.  I wouldn't be sure that that
endianness conversion was doing anything on the system that the driver
was developed on.

> To be honnest, I'm really not sure anymore what is the way to go.

The expected behaviour is very clearly documented, I've quoted that
documentation at you and recommended that anything being done for
performance reasons be done in the controller driver.  I'm really not
sure what else to tell you, especially given that if the client driver
uses a byte stream (which is what it wants) this all becomes purely
internal to the controller
driver.

--ICJxC532CPfoxgBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQQb88ACgkQJNaLcl1U
h9Cyzgf9GWyfJ6s6RGY7MlHZUYowsJrJgBXNg2NGOFUzlTQtAXOFWM/hy+ca00xK
Jln8cw+L3W9R5d5F5VV8i5RCtLSKJfQeV4oH+LGFPFtIgRLDtZpP8eTIdI1/Qxns
sjj+sMje+htJb3LVKS+xO/ieLKxdMD3rxXToa5pLYh3A9xAl9f7CARBGuGZD1xdT
JEfWbR3VXsk+Q5MOU2C9Fz8d9M46N8e3a48bxgpy5CoA2O4PiSAHA4UgjyptPWYp
fBPkWPwdoxu7GNWbf0FH4p/m+tc9P6scKRHM0HpRQvJ+fWCaqV5RlU92sOBC2/Zn
Dtcvd4uVeLTmDtKJbu/arwNoTZtnag==
=j1hI
-----END PGP SIGNATURE-----

--ICJxC532CPfoxgBT--
