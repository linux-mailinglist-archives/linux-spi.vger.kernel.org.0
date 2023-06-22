Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE79739966
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFVIZY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVIZX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 04:25:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151111BE1
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 01:25:21 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687422320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBdOX0LeNnwkBOCBXOc7fb8d7svam9mV/vJcgcYCVTc=;
        b=Kp1G3DlIOaC+Ej0eM1YZUrnwY12kXqOQjgVMVkBt33DFmUDfkzqz1OWjZ5LS2rZ/ig0f5m
        9g3lc9FjC4QJ3ACZIE/PoVmFbDmL30bc516+qpGojnTRRfyCw4Hdy+YHd2q5ioq3CDCgOC
        mjD+srj7TSVP5AommzCLAnIwD36DyysYfQ8k7kbmrOmwZDWH8FS0WbgmZsvZ0fY8tLztIh
        TUTdixx2KWHnj1X7KMULHm2lM+n3/32DS/sSx2BGX88m9iiYlij713XFYKttLbuKcNgeIw
        zpLQZSg9jOusjFqoHiVd//mSlz0jX892vk54GKVQAJJhurykBsMrOswl9/8iYw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE4CC1C0002;
        Thu, 22 Jun 2023 08:25:18 +0000 (UTC)
Date:   Thu, 22 Jun 2023 10:25:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] spi: atmel: Prevent false timeouts on long
 transfers
Message-ID: <20230622102518.0dd4c268@xps-13>
In-Reply-To: <9988258d-5797-402a-9d92-c7c9e1afa73c@sirena.org.uk>
References: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
        <20230619155349.3118420-3-miquel.raynal@bootlin.com>
        <9988258d-5797-402a-9d92-c7c9e1afa73c@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 21 Jun 2023 15:59:34 +0100:

> On Mon, Jun 19, 2023 at 05:53:48PM +0200, Miquel Raynal wrote:
> > A slow SPI bus clocks at ~20MHz, which means it would transfer about
> > 2500 bytes per second with a single data line. Big transfers, like when
> > dealing with flashes can easily reach a few MiB. The current DMA timeout
> > is set to 1 second, which means any working transfer of about 4MiB will
> > always be cancelled. =20
>=20
> This breaks the build:
>=20
> /build/stage/linux/drivers/spi/spi-atmel.c: In function =E2=80=98atmel_sp=
i_one_transfer=E2=80=99
> :
> /build/stage/linux/drivers/spi/spi-atmel.c:1338:76: error: =E2=80=98maste=
r=E2=80=99 undeclared (
> first use in this function)
>  1338 |                 dma_timeout =3D msecs_to_jiffies(spi_controller_x=
fer_timeo
> ut(master, xfer));
>       |                                                                  =
      =20
>    ^~~~~~
> /build/stage/linux/drivers/spi/spi-atmel.c:1338:76: note: each undeclared=
 identi
> fier is reported only once for each function it appears in

I am testing on a customer board which currently runs on 6.1, I lacked
398b6b310ec8 ("spi: atmel: switch to use modern name"). I'll send an update.

Thanks,
Miqu=C3=A8l
