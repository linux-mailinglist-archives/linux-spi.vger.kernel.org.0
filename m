Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC32DD6EB
	for <lists+linux-spi@lfdr.de>; Sat, 19 Oct 2019 08:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfJSGYR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Oct 2019 02:24:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfJSGYR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Oct 2019 02:24:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so8332705wrw.9
        for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2019 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=NaB317VPEWYoyCGfauf4XqD6zwPbIGUmflkZmicnPS8=;
        b=YbLnBkcTmO9kH2rGbc7u6GFXiaa7dIYcNYn9BAtlqlGUuyV+V4IWG3nWOYeC4px9Oj
         iqUS9AZ2IoytDFN37+dS2zP5xfkR+7d+kiLTAWX+JKE+E5O/NZt31rCPl79/tAQesSf1
         pxb7wAYiIchzjqonPfKuKR21VwY5KXLqXlNJAqaX0fn94nCJvVGakiJhcI9EzIICckqZ
         /YDkX++zmLoT0fN0YLXbkZy1ezi8SASkViEFw5jDsGj3w8dR2lYscZ9FJfh0bU6b9nLx
         iVGnF67CcFQLU/CPSkvDGpF7BSDusQ6cc2+ME9fEC083UJkf8QtTrrHeDoE9avumggJ9
         nS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=NaB317VPEWYoyCGfauf4XqD6zwPbIGUmflkZmicnPS8=;
        b=RWq6LD7HVtrUc9CcKwjGI9cRFR6aM2DpRml/V3qviKc9HpSY9N6A3g6o6Ucamuee7s
         CAZTCj290aaLL+nY+k2daEx4aM4kGEhf2PNVRF3Phv5es0e0HGwI+Ydw2uHELkuLMlXX
         QHio5bw2Ceqe/Ys9qHqp+MnNEHINcFuljDPUhcPcE9R6v+TfnKOsAdxa7CZNXeXb8sip
         eDWFTzl2oM4AQXlFLmZB4PJj0eXy/9kMzkil7c/7d/YFmPFE568zXg4GKQntWuTEaeEB
         xJLmx8gqOs1wXzDcNeq+wnSCrYZm8INzu9TtNO2Xr4m+Anmu1kz/ZuQ/ceAI/Uze9od8
         /CHg==
X-Gm-Message-State: APjAAAVmzGWH65J27DmBhwFjXENa5xZpKHPSdIBguSvsIEaNj8BRqPKC
        KazYN/q70CVZ4EkSw/oHg7534Q==
X-Google-Smtp-Source: APXvYqxbRXnH9dhmc0b7p235t7/I3YoheY6CeABtmWPImtm2uAGk8R19vGzSr5lr/aNIHxPiNaL+7w==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr4905652wrr.42.1571466254197;
        Fri, 18 Oct 2019 23:24:14 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a14sm6594678wmm.44.2019.10.18.23.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 23:24:13 -0700 (PDT)
Message-ID: <5daaac0d.1c69fb81.12761.2a24@mx.google.com>
Date:   Fri, 18 Oct 2019 23:24:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: for-next
X-Kernelci-Tree: broonie-spi
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc3-73-gc673f2d99c3d
Subject: broonie-spi/for-next boot bisection: v5.4-rc3-73-gc673f2d99c3d on
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

broonie-spi/for-next boot bisection: v5.4-rc3-73-gc673f2d99c3d on jetson-tk1

Summary:
  Start:      c673f2d99c3d Merge remote-tracking branch 'spi/topic/ptp' int=
o spi-next
  Details:    https://kernelci.org/boot/id/5daa485f59b5142f647525a0
  Plain log:  https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc3-7=
3-gc673f2d99c3d/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/b=
oot-tegra124-jetson-tk1.txt
  HTML log:   https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc3-7=
3-gc673f2d99c3d/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/b=
oot-tegra124-jetson-tk1.html
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
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
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
# good: [4f5cafb5cb8471e54afdc9054d973535614f7675] Linux 5.4-rc3
git bisect good 4f5cafb5cb8471e54afdc9054d973535614f7675
# bad: [c673f2d99c3d644733cc1b0ceabdec47047bbe80] Merge remote-tracking bra=
nch 'spi/topic/ptp' into spi-next
git bisect bad c673f2d99c3d644733cc1b0ceabdec47047bbe80
# good: [b2c98153f45fc17b9fcb241000f2d131ddea6030] spi: introduce spi_delay=
 struct as "value + unit" & spi_delay_exec()
git bisect good b2c98153f45fc17b9fcb241000f2d131ddea6030
# good: [4f3d957718e7f0ac2b033dbf48c7cddecd0a8dd3] spi: pxa2xx: No need to =
keep pointer to platform device
git bisect good 4f3d957718e7f0ac2b033dbf48c7cddecd0a8dd3
# good: [1cb84b02bf130f34ee81f99bc7dee5bca2943ed7] spi: atmel: Remove platf=
orm data support
git bisect good 1cb84b02bf130f34ee81f99bc7dee5bca2943ed7
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
