Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011573AB72
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVVSJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVSI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 17:18:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AFF1
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 14:18:07 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687468686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek7fz96w8JqxmY6wCHpt2UWYO66vJbxa3jnC//WlTjA=;
        b=GFwY1CmHPJzZcfOsrttsXnXEs24uyqga1dJa3jvYoamq1tUVLVzzl3MK4F4aNWa/X3lQSC
        YlJMn+cRPUQZWPkoMPm/CH9AbUFdjkV2lTbXdzwd/EfMcDI0WhTpFOHmJyChUVljtzsQkl
        mgOWCkhkoaL6xhsTkGYisIZwUrlajtJmFq55Oobm7+PQZ/5C1zYtFgoVIQBpsjPuoM/h9H
        yprErbM1mHHBJy6PCmnls+moqzBu2NkhTFC1rbjAb+0el2TBCmmDu/8NVTgh4KDlo8cAc/
        XI6mcivB0WX6beOpA7PBu+CdrE9P7Q4sMH1tdxm8YWvr5rxSx4Tu3o6mNyaSpg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 836B7C0002;
        Thu, 22 Jun 2023 21:18:04 +0000 (UTC)
Date:   Thu, 22 Jun 2023 23:18:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] spi: Helper for deriving timeout values
Message-ID: <20230622231802.42b38b96@xps-13>
In-Reply-To: <2686152.mvXUDI8C0e@jernej-laptop>
References: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
        <2686152.mvXUDI8C0e@jernej-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jernej,

jernej.skrabec@gmail.com wrote on Thu, 22 Jun 2023 18:46:27 +0200:

> Dne =C4=8Detrtek, 22. junij 2023 ob 11:06:31 CEST je Miquel Raynal napisa=
l(a):
> > Hello,
> >=20
> > I recently came across an issue with the Atmel spi controller driver
> > which would stop my transfers after a too small timeout when performing
> > big transfers (reading a 4MiB flash in one transfer). My initial idea
> > was to derive a the maximum amount of time a transfer would take
> > depending on its size and use that as value to avoid erroring-out when
> > not relevant. Mark wanted to go further by creating a core helper doing
> > that, based on the heuristics from the sun6i driver.
> >=20
> > Here is a small series of 3 patches doing exactly that.
> >=20
> > Cheers,
> > Miqu=C3=A8l
> >=20
> > Changes in v3:
> > * Collected a tag. =20
>=20
> Did you? I don't see my a-b at patch 3.

I thought I did, sorry if I missed it. Do you mind re-sending it?

>=20
> Best regards,
> Jernej
>=20
> > * As my platform runs on 6.1 currently, I cherry-picked a mainline patch
> >   changing s/master/host/ in the atmel controller driver and modified t=
he
> >   series to fit the new naming. I then cherry-picked my three patches a=
nd
> >   verified it compiled correctly against a v6.4-rc1.
> >=20
> > Miquel Raynal (3):
> >   spi: Create a helper to derive adaptive timeouts
> >   spi: atmel: Prevent false timeouts on long transfers
> >   spi: sun6i: Use the new helper to derive the xfer timeout value
> >=20
> >  drivers/spi/spi-atmel.c | 18 +++++++++++-------
> >  drivers/spi/spi-sun6i.c |  2 +-
> >  include/linux/spi/spi.h | 17 +++++++++++++++++
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> >=20
> >  =20
>=20
>=20
>=20
>=20

Thanks,
Miqu=C3=A8l
