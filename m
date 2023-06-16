Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95725733650
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbjFPQnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFPQnO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 12:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8002A2D6A
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 09:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C72D60DBD
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 16:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B1DC433C8;
        Fri, 16 Jun 2023 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686933791;
        bh=HT42g2t7717Q/RKHY/oNnf8A2EyW+5GaFEj+IXG0Xd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gW3UhKe6uJbZNpACpt31I8n5Xa73zWi928oOOb1MULZiquNFFzK8eIMUTMZ5TEx8q
         nInxrPDks0UqEGESUGOhyYWndN0/KM+LkwZIRgSsFuip4XM67Yhykt3vbTarM1YRMA
         aZSc9fow3nfylQ0DjxpOav27V4tYtdkLngrOcvF0LwBOzaSO8R/0PLwMpsaWl8flml
         0jbkcCON9Z4ZC2J9qaM1k2z9QS+QFU4vQkprKmNr33slQwHpbJ3qfm5cYzd63g7Qqh
         yOW7M93UjJmFmvmc3E0ajjAJjxPvo59kAxQlwm+ElN51V3H/HizFRV5OEy6qAWelNC
         KSOy7mHSjN0rg==
Date:   Fri, 16 Jun 2023 17:43:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <4054360c-b942-4761-a03f-e4d50a328ec0@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
 <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
 <20230616181535.032bf9de@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZiX4AfYcSU6RaVnm"
Content-Disposition: inline
In-Reply-To: <20230616181535.032bf9de@xps-13>
X-Cookie: P-K4
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZiX4AfYcSU6RaVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 06:15:35PM +0200, Miquel Raynal wrote:
> broonie@kernel.org wrote on Fri, 16 Jun 2023 15:20:27 +0100:

> > On Fri, Jun 16, 2023 at 04:12:25PM +0200, Miquel Raynal wrote:

> > > -#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
> > > +#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
> > > +#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4)) =20

> > Given that we know the bus speed can't we just calculate this like other
> > drivers do (we should probably add a helper TBH)?

> I agree we should probably have some kind of easy-to-use helper to
> derive a decent timeout value. How do sound the heuristics
> proposed here to you ? That would be:

> 	timeout =3D 1s + 4ms/10k

Like I say we should know the transfer speed so we can do better than
4ms/10k - we know how long it takes to clock out each byte, we can just
multiply that by the size of the transfer then add some fudge factor for
setup/teardown overhead.  1s feels pretty generous too.  The sun6i
driver for example does=20

   max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U)

and just doubles the length based timeout with a minimum of 100ms which
seems reasonable.

--ZiX4AfYcSU6RaVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMkRkACgkQJNaLcl1U
h9D0uAf/bbS8Go71qnOOnRCFmgFRGit6s7gsUo54BRoVK0nTDyK+6i9/1Kuu26I/
iSXquTSe3468S87ynnLxSVZXrnFfj8PgobFCI/hSyRPuCUXUOIgluQ/27NSAPIQh
nD++svaJXy7NAt6gNmnwCeAJWx104t/jGPoPvYHjYJwmEeFveICcJZ2l28GVMkRY
4su7RA8waXoPOtEn5qVD/ssLdIfHHOQDTPTUmNEcgHR9MqeKOFrPjOihW+yHOu+E
MgDvsrUFUcxWaqNE7sikjdQlaU25nDNBGyYQJ/Rbk5mgRrXl3qdkIy867Rnq432z
0URG7xSmmtgLxSJYvpniVSKdtLK+dQ==
=hYDG
-----END PGP SIGNATURE-----

--ZiX4AfYcSU6RaVnm--
