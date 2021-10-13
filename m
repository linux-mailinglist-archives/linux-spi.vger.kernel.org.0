Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB942C05E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJMMqg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 13 Oct 2021 08:46:36 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58993 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJMMqg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 08:46:36 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 361E160015;
        Wed, 13 Oct 2021 12:44:30 +0000 (UTC)
Date:   Wed, 13 Oct 2021 14:44:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        kernel@pengutronix.de, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 13/20] mtd: dataflash: Warn about failure to
 unregister mtd device
Message-ID: <20211013144429.65b294e5@xps13>
In-Reply-To: <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
        <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Tue, 12 Oct 2021 17:39:38 +0200:

> When an spi driver's remove function returns a non-zero error code

Should we s/an spi/a SPI/?

> nothing happens apart from emitting a generic error message. Make this
> error message more device specific and return zero instead.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mtd/devices/mtd_dataflash.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
> index 9802e265fca8..2691b6b79df8 100644
> --- a/drivers/mtd/devices/mtd_dataflash.c
> +++ b/drivers/mtd/devices/mtd_dataflash.c
> @@ -919,7 +919,10 @@ static int dataflash_remove(struct spi_device *spi)
>  	status = mtd_device_unregister(&flash->mtd);
>  	if (status == 0)
>  		kfree(flash);
> -	return status;
> +	else
> +		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
> +			 ERR_PTR(status));
> +	return 0;

As part of a recent NAND cleanup series we ended up adding WARN_ON() [1]
to make it very clear that if this happens, it's not expected at all (it
was Boris' advice).

I don't think there is only one good solution but perhaps its best to
keep it sync'ed with the other drivers in MTD?

Thanks,
Miquèl

[1]
d6e4fd522461 mtd: rawnand: nandsim: Stop using nand_release()
9fdd78f7bcda mtd: rawnand: xway: Stop using nand_release()
d9f2a1af817d mtd: rawnand: vf610: Stop using nand_release()
f6fc75978d88 mtd: rawnand: txx9ndfmc: Stop using nand_release()
f3e169f44bdb mtd: rawnand: tmio: Stop using nand_release()
ab135c51bb81 mtd: rawnand: tango: Stop using nand_release()
068d86ecd9d9 mtd: rawnand: sunxi: Stop using nand_release()
24acc3fa8b36 mtd: rawnand: stm32_fmc2: Stop using nand_release()
c121cb980c09 mtd: rawnand: socrates: Stop using nand_release()
35a37f9198e5 mtd: rawnand: sharpsl: Stop using nand_release()
50abacbb621f mtd: rawnand: sh_flctl: Stop using nand_release()
9748110bd22c mtd: rawnand: s3c2410: Stop using nand_release()
10b87750ae17 mtd: rawnand: r852: Stop using nand_release()
0a2bc9919cf7 mtd: rawnand: qcom: Stop using nand_release()
d1aae005a00e mtd: rawnand: plat_nand: Stop using nand_release()
23cf34615010 mtd: rawnand: pasemi: Stop using nand_release()
2d9cf6f129f8 mtd: rawnand: oxnas: Stop using nand_release()
f342df67b19a mtd: rawnand: orion: Stop using nand_release()
b4533679c958 mtd: rawnand: omap2: Stop using nand_release()
a9384f95fe77 mtd: rawnand: ndfc: Stop using nand_release()
8fd507bb4210 mtd: rawnand: mxic: Stop using nand_release()
c6dc082793d2 mtd: rawnand: mxc: Stop using nand_release()
1fec333aadc2 mtd: rawnand: mtk: Stop using nand_release()
1a36a7f78898 mtd: rawnand: mpc5121: Stop using nand_release()
5ecbba617446 mtd: rawnand: marvell: Stop using nand_release()
21b758277724 mtd: rawnand: lpc32xx_slc: Stop using nand_release()
5f3bce3a5275 mtd: rawnand: lpc32xx_mlc: Stop using nand_release()
28dcc4e8a831 mtd: rawnand: ingenic: Stop using nand_release()
71a4917b4d4b mtd: rawnand: hisi504: Stop using nand_release()
194f6c48cdd8 mtd: rawnand: gpmi: Stop using nand_release()
dbe0241570ed mtd: rawnand: gpio: Stop using nand_release()
9cc02f4c0a87 mtd: rawnand: fsmc: Stop using nand_release()
f6c4e661491a mtd: rawnand: fsl_upm: Stop using nand_release()
e9f2f5a80754 mtd: rawnand: fsl_ifc: Stop using nand_release()
128bbbf0ac4d mtd: rawnand: fsl_elbc: Stop using nand_release()
63a1460768a1 mtd: rawnand: diskonchip: Stop using nand_release()
009e2e1d8318 mtd: rawnand: denali: Stop using nand_release()
a9575c48e520 mtd: rawnand: davinci: Stop using nand_release()
970024f031ae mtd: rawnand: cs553x: Stop using nand_release()
544bac8999a6 mtd: rawnand: cafe: Stop using nand_release()
8b88f4e0a88b mtd: rawnand: cadence: Stop using nand_release()
937d039dfdcf mtd: rawnand: brcmnand: Stop using nand_release()
936904305928 mtd: rawnand: bcm47xx: Stop using nand_release()
4a3d21bc25c1 mtd: rawnand: au1550nd: Stop using nand_release()
08f25cd767e1 mtd: rawnand: ams-delta: Stop using nand_release()
