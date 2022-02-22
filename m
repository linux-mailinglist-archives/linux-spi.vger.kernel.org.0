Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A636F4BF650
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiBVKm3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 05:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBVKm2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 05:42:28 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3185EDF0C
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 02:42:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E7D8620005;
        Tue, 22 Feb 2022 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645526519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZ42NyxEmt0CuMFV9FTwX0iyn7TfTnG5TAcnR3dovOY=;
        b=UD0NyR3PvT/bfnygLpBlca2nq1ckk2Wl1M3RnfRasEc4I3tRtT0FG6zCl1mwz2V7F7FpLh
        rEznwqyLyNLhlXUh3OUVGS5pAGKQNxJscyrwy00RenzINt32cedmGINxVVnVW+v+PxzisF
        R/laSIk6r89x/dCSnrOS6eHJIJoy0j7sd6f0ibrVZa2NNWnhv7UygOlw2f//LGRfhvAZ47
        jk6YRJygS+WRA72swsPDiSQJzgsiEeUizoC1xkgIfxgFV0tISZiQPoOFc6d9pK53virVhM
        uT6fakSBrtHTmnPhKzps9xKJdLo1w8oKLR6+c62aAe21uo03HiYFKDgJmByu7Q==
Date:   Tue, 22 Feb 2022 11:41:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 14/28] mtd: nand: mxic-ecc: Add Macronix external ECC
 engine support
Message-ID: <20220222114153.4dfaf0b8@xps13>
In-Reply-To: <CAMuHMdXJHAx4HptRRqfhe74mkfm+-oKp0qtd9Ns7Moh5omWehg@mail.gmail.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
        <20211216111654.238086-15-miquel.raynal@bootlin.com>
        <CAMuHMdXJHAx4HptRRqfhe74mkfm+-oKp0qtd9Ns7Moh5omWehg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Tue, 22 Feb 2022 11:39:34 +0100:

> Hi Miquel,
>=20
> On Thu, Dec 16, 2021 at 12:48 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > Some SPI-NAND chips do not support on-die ECC. For these chips,
> > correction must apply on the SPI controller end. In order to avoid
> > doing all the calculations by software, Macronix provides a specific
> > engine that can offload the intensive work.
> >
> > Add Macronix ECC engine support, this engine can work in conjunction
> > with a SPI controller and a raw NAND controller, it can be pipelined
> > or external and supports linear and syndrome layouts.
> >
> > Right now the simplest configuration is supported: SPI controller
> > external and linear ECC engine.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -46,6 +46,12 @@ config MTD_NAND_ECC_SW_BCH
> >           ECC codes. They are used with NAND devices requiring more tha=
n 1 bit
> >           of error correction.
> >
> > +config MTD_NAND_ECC_MXIC
> > +       bool "Macronix external hardware ECC engine"
> > +       select MTD_NAND_ECC
> > +       help
> > +         This enables support for the hardware ECC engine from Macroni=
x. =20
>=20
> I guess this is a licensable IP core, which can appear anywhere, so
> we don't have a proper platform dependency to add here?

Yes, I am not aware of any limitation on that side.

Thanks,
Miqu=C3=A8l
