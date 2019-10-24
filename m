Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06BDE3B67
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504155AbfJXSzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 14:55:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32993 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504145AbfJXSzn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 14:55:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so18480214wro.0
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2019 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Lz/4c5N/+tK+P2F720qDu3yXEoKFp1xfJLAN9hBBat4=;
        b=HuINXuV6Uwb8i0G2RVa9Ff5FL1Ugvyc+QYfJJpljOVD5rB+4Z7LAGqgfsYBg5tSGRR
         5PPBNH1cUIrg4BgNqfYP8SP8ymdXx+fs7QbvN/92zOii99heIEvImnIilLEcVGVMDZHc
         cb1ot0s4AonWt/XPxRLJh9IM6wZyfPzCUHZThsNe3t03xECsyRaLK/vsWEUtq3NHqu6c
         cv7Lgu0rB0xb/w+3vgxE2Cm8O5N72DvwAMOg6Ujkm+pVDxUTP8yxhXKzcePcSmdaaqOw
         FNDF9YwM3oriHUSK5cSdLu/Tl7CKSSq3sebLHORjn7uIXUIIJw09P0/iFbcQdvXm1Ohl
         u7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Lz/4c5N/+tK+P2F720qDu3yXEoKFp1xfJLAN9hBBat4=;
        b=aqr3QRFeVg4LXnyr+ZUcJHFIvdVaiqAng4c8d80lBIjuR9RHsHj69jqgoZW1qJa113
         p/wRWye8A8cwnpd2duz9De7UqmAqLI0NeZcvZ2cFcXtIB2tpGeWBvSRQXELIGLIc0LGO
         LttNiLV/gRTpbUtfm6PZ7jnIs81S9JCoUfjZiRweFxQhEZ1VujBFMKz6qV/xT9FSQd1G
         LLapz5PtJ3YyupX1zQzTqnbRmbc0//qqGtYISsnGErRJpFSrblXdKwmeUAgCklGzn+tn
         B9dEP+NW23RgeJUvBn/qhh0prqgCxRkxRUNAGgCwjOPsr98WlfUGukvZl5oS0I9k6tB6
         VkKg==
X-Gm-Message-State: APjAAAUoF2AFxTgK1J/BhR8O4p644voMQpschg7kt2HlnoMKTSSMudJq
        TrZR0TdncHB5L0keNd7EK/V3fw==
X-Google-Smtp-Source: APXvYqzfjP3r+jamaPhkAjsEwMmebvFljdyXm+auitsaDfqbbooQ7JJqCcEMVsDsG1pUpFbI9PzkvA==
X-Received: by 2002:adf:9381:: with SMTP id 1mr5210405wrp.10.1571943340329;
        Thu, 24 Oct 2019 11:55:40 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 74sm37224239wrm.92.2019.10.24.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 11:55:39 -0700 (PDT)
Message-ID: <5db1f3ab.1c69fb81.5387b.d1fa@mx.google.com>
Date:   Thu, 24 Oct 2019 11:55:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc4-82-ge025ec2b58a5
X-Kernelci-Tree: broonie-spi
X-Kernelci-Branch: for-next
X-Kernelci-Lab-Name: lab-collabora
Subject: broonie-spi/for-next boot bisection: v5.4-rc4-82-ge025ec2b58a5 on
 jetson-tk1
To:     Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-spi/for-next boot bisection: v5.4-rc4-82-ge025ec2b58a5 on jetson-tk1

Summary:
  Start:      e025ec2b58a5 Merge remote-tracking branch 'spi/topic/ptp' int=
o spi-next
  Details:    https://kernelci.org/boot/id/5db1a0fe59b514fcda201eeb
  Plain log:  https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc4-8=
2-ge025ec2b58a5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-jetso=
n-tk1.txt
  HTML log:   https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc4-8=
2-ge025ec2b58a5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-jetso=
n-tk1.html
  Result:     3e5ec1db8bfe spi: Fix SPI_CS_HIGH setting when using native a=
nd GPIO CS

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-spi
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.g=
it
  Branch:     for-next
  Target:     jetson-tk1
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     tegra_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 3e5ec1db8bfee845d9f8560d1c64aeaccd586398
Author: Gregory CLEMENT <gregory.clement@bootlin.com>
Date:   Fri Oct 18 17:29:29 2019 +0200

    spi: Fix SPI_CS_HIGH setting when using native and GPIO CS
    =

    When improving the CS GPIO support at core level, the SPI_CS_HIGH
    has been enabled for all the CS lines used for a given SPI controller.
    =

    However, the SPI framework allows to have on the same controller native
    CS and GPIO CS. The native CS may not support the SPI_CS_HIGH, so they
    should not be setup automatically.
    =

    With this patch the setting is done only for the CS that will use a
    GPIO as CS
    =

    Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs=
")
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
    Link: https://lore.kernel.org/r/20191018152929.3287-1-gregory.clement@b=
ootlin.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f8b4654a57d3..d07517151340 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1711,15 +1711,7 @@ static int of_spi_parse_dt(struct spi_controller *ct=
lr, struct spi_device *spi,
 		spi->mode |=3D SPI_3WIRE;
 	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |=3D SPI_LSB_FIRST;
-
-	/*
-	 * For descriptors associated with the device, polarity inversion is
-	 * handled in the gpiolib, so all chip selects are "active high" in
-	 * the logical sense, the gpiolib will invert the line if need be.
-	 */
-	if (ctlr->use_gpio_descriptors)
-		spi->mode |=3D SPI_CS_HIGH;
-	else if (of_property_read_bool(nc, "spi-cs-high"))
+	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |=3D SPI_CS_HIGH;
 =

 	/* Device DUAL/QUAD mode */
@@ -1783,6 +1775,14 @@ static int of_spi_parse_dt(struct spi_controller *ct=
lr, struct spi_device *spi,
 	}
 	spi->chip_select =3D value;
 =

+	/*
+	 * For descriptors associated with the device, polarity inversion is
+	 * handled in the gpiolib, so all gpio chip selects are "active high"
+	 * in the logical sense, the gpiolib will invert the line if need be.
+	 */
+	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods[spi->chip_select])
+		spi->mode |=3D SPI_CS_HIGH;
+
 	/* Device speed */
 	rc =3D of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [7d194c2100ad2a6dded545887d02754948ca5241] Linux 5.4-rc4
git bisect good 7d194c2100ad2a6dded545887d02754948ca5241
# bad: [e025ec2b58a56f29813afe3b5a8b9d0170c84eb3] Merge remote-tracking bra=
nch 'spi/topic/ptp' into spi-next
git bisect bad e025ec2b58a56f29813afe3b5a8b9d0170c84eb3
# good: [6c613f68aabf33385c01e949204ac5ed30887161] spi: core,atmel: convert=
 `word_delay_usecs` -> `word_delay` for spi_device
git bisect good 6c613f68aabf33385c01e949204ac5ed30887161
# good: [585d18f7ebd1dba7400dcc7189a5f7223b821374] spi: atmel: Configure GP=
IO per CS instead of by controller
git bisect good 585d18f7ebd1dba7400dcc7189a5f7223b821374
# good: [e58f7d15e6beb255b3907054a0536db77c979a31] spi: xilinx: Add DT supp=
ort for selecting transfer word width
git bisect good e58f7d15e6beb255b3907054a0536db77c979a31
# bad: [fed8d8c7a6dc2a76d7764842853d81c770b0788e] spi: atmel: fix handling =
of cs_change set on non-last xfer
git bisect bad fed8d8c7a6dc2a76d7764842853d81c770b0788e
# bad: [3e5ec1db8bfee845d9f8560d1c64aeaccd586398] spi: Fix SPI_CS_HIGH sett=
ing when using native and GPIO CS
git bisect bad 3e5ec1db8bfee845d9f8560d1c64aeaccd586398
# good: [b2662a164f9dc48da8822e56600686d639056282] spi: pxa2xx: Set control=
ler->max_transfer_size in dma mode
git bisect good b2662a164f9dc48da8822e56600686d639056282
# first bad commit: [3e5ec1db8bfee845d9f8560d1c64aeaccd586398] spi: Fix SPI=
_CS_HIGH setting when using native and GPIO CS
---------------------------------------------------------------------------=
----
