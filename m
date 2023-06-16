Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D57336FA
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbjFPRAu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbjFPRAS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 13:00:18 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212A3596
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 09:59:09 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686934748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Pg0XuDgLFN/BwT4f28YkKD1PxgA7At/HyEnsuhSmTg=;
        b=LicYLH/4xpSYAncPrkvE96hdUBeIShvfpfLPkcHO1ByyrWnHwHTQBuQiEUUxfw8tr4kDzM
        lvlBLTcvh0P9NT79cO6imIzI9698NYpBdFEr97Ega3swNmJNBDwBo+bDiIpzN3QCHfO+Nm
        SWXtWeryzYV4ywuxxiuXRho4C+GCocWiffej1euUQV2hrPVHXoFEJh+xg7/F1q/h20LEpr
        x9ksb6Fh5x1p+Izn+Y3nJy16aLUd1AMGwip8n7sCaA0OtsRBcxHd8XYe/xJIcQRKDGDtcR
        7UR7AK2mb28vkxvd9grAXfkN50m5alXjwyda18Lgzch6oKp1SHSDcErF15LdCw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58B33FF805;
        Fri, 16 Jun 2023 16:59:07 +0000 (UTC)
Date:   Fri, 16 Jun 2023 18:59:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <20230616185906.04c4a869@xps-13>
In-Reply-To: <4054360c-b942-4761-a03f-e4d50a328ec0@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
        <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
        <20230616181535.032bf9de@xps-13>
        <4054360c-b942-4761-a03f-e4d50a328ec0@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 16 Jun 2023 17:43:06 +0100:

> On Fri, Jun 16, 2023 at 06:15:35PM +0200, Miquel Raynal wrote:
> > broonie@kernel.org wrote on Fri, 16 Jun 2023 15:20:27 +0100: =20
>=20
> > > On Fri, Jun 16, 2023 at 04:12:25PM +0200, Miquel Raynal wrote: =20
>=20
> > > > -#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
> > > > +#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
> > > > +#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))   =20
>=20
> > > Given that we know the bus speed can't we just calculate this like ot=
her
> > > drivers do (we should probably add a helper TBH)? =20
>=20
> > I agree we should probably have some kind of easy-to-use helper to
> > derive a decent timeout value. How do sound the heuristics
> > proposed here to you ? That would be: =20
>=20
> > 	timeout =3D 1s + 4ms/10k =20
>=20
> Like I say we should know the transfer speed so we can do better than
> 4ms/10k - we know how long it takes to clock out each byte, we can just
> multiply that by the size of the transfer then add some fudge factor for
> setup/teardown overhead.  1s feels pretty generous too.  The sun6i
> driver for example does=20
>=20
>    max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U)
>=20
> and just doubles the length based timeout with a minimum of 100ms which
> seems reasonable.

I already had issues with ~0.1s timeouts on NAND controllers, just
because the machine was heavily loaded. I believe we should avoid too
small timeouts, it does not make sense and make things worse under load.

I'll have a look.

Thanks,
Miqu=C3=A8l
