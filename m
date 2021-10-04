Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E8421459
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhJDQtF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDQtE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 12:49:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33829C061745
        for <linux-spi@vger.kernel.org>; Mon,  4 Oct 2021 09:47:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so67106371edv.12
        for <linux-spi@vger.kernel.org>; Mon, 04 Oct 2021 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZ0v1u2tk23X5eUN5tNJiDFXAjN4+CmumgmY2tcIBG4=;
        b=RpLKd5VUguSaG7sbGMc3WPh6mT0KzRNou9Sj/ADgtL4EheWkrgXurqmaMbVHdVITzW
         KF+MR6qLNw8ZL60D81vZASo4gW6XTolLG/v+6dM4MKIdJGG7Ajp9/s1PFT8g+x7heccg
         OEaB2OJoyU93X6ebMP4zaFkwPc4vwNXC/faIKZXdTGjz7UU8EjvNz72NfJheb/qKZPnW
         +ZsSDcw/8UF9j5T7tn3AEbeGgsca6FECZr/HjPl1pm/68S3KpjDLVK1TyCQ3z+CKFgqD
         8qlNDkbTfNj37JE9RRuvtleXTuWUZOuTEEmIGkQCcQLm2AJPFGVzkvOCJr1kVJxwI2SC
         +4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZ0v1u2tk23X5eUN5tNJiDFXAjN4+CmumgmY2tcIBG4=;
        b=Q1w/lK5tHpqLgvqNOd4tjQHf2YRd2T8KVPi20/HkTOPD3f+Lvtdz64qlMC36+sM45G
         vIPqSjyUe54sDcPQowOjPnYeeFE9PqFHAhMFce9vKMNeoYkJ+xJNMblcOtE+gnzFjWex
         BQkO9mi+eXX+XYqGdNxZkKJbC2QH2rKC23JXHKu7a/HZGtwEO4s4vDV/a4953FAVQ+dW
         nAnYVxtZEJY59nqUnI1jRvRggXFG+6sQDZYd08qBNU2yF+8xQNLME6O1TUJF94P2Dy5m
         3CgBMxUlXWngQUvIsPj71A3BBKSDsrlbAv4H7YV66ymseM2bnaJ2dlS3dEKezAzbiKFr
         x5QA==
X-Gm-Message-State: AOAM531PEEP6fibeKepS66VeEMkp7Wk0ceAidtXQkvAtzRtQeJGG+NlH
        plwbdyQE59UhFf7IjBLd3m6YhpuaKi9TDCC4YKEq7Q==
X-Google-Smtp-Source: ABdhPJzjVM4V14h8OdtJUWCc39edoN+MVZ7X+KSuNidkbdX/lWnwMxkr2+OCau6qpimILQv/4qAfa5xdI8gET8cJFXM=
X-Received: by 2002:a50:9dca:: with SMTP id l10mr19480865edk.61.1633366000496;
 Mon, 04 Oct 2021 09:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com> <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
In-Reply-To: <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 4 Oct 2021 09:46:28 -0700
Message-ID: <CAK9rFnxuiAX2-5TFhfyTdpaY3BRysX_Q2sJkca4LhOLzapB83Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Aug 29, 2021 at 2:09 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Aug 23, 2021 at 3:06 AM Brad Larson <brad@pensando.io> wrote:
>
> > The gpio pins being used for the Elba SoC SPI CS are dedicated to this
> > function.  Are you recommending that the code in
> > drivers/gpio/gpio-elba-spics.c be integrated into
> > drivers/spi/spi-dw-mmio.c?
>
> That makes most sense does it not?
>
> Special purpose pins should be managed by that special purpose
> hardware driver, DW SPI in this case.
>
> The compatible string etc should be enough to determine that we
> need some extra GPIO control here, possibly specify extra registers
> for the SPI host etc.
>
> The struct spi_master has a special callback .set_cs() and you
> should make this behave special for your special hardware.
> In the case of the DW driver it appears that even subdrivers can
> pass a custom version of this call in struct dw_spi.
>
> Yours,
> Linus Walleij

Yes that works, please see the diff below where the file
gpio-elba-spics.c goes away.  The original implementation was
motivated by gpio-spear-spics.c.

Best,
Brad

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d3b509e175e47..14751c7ccd1f4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -240,11 +240,6 @@ config GPIO_EIC_SPRD
  help
   Say yes here to support Spreadtrum EIC device.

-config GPIO_ELBA_SPICS
- bool "Pensando Elba SoC SPI Chip Select as GPIO support"
- depends on ARCH_PENSANDO_ELBA_SOC
- def_bool y
-
 config GPIO_EM
  tristate "Emma Mobile GPIO"
  depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO


diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
index a59405dc5676d..17dfb0c91f84c 100644
--- a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
+++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
@@ -66,8 +66,8 @@

 &spi0 {
  num-cs = <4>;
- cs-gpios = <&spics 0 GPIO_ACTIVE_LOW>, <&spics 1 GPIO_ACTIVE_LOW>,
-   <&porta 1 GPIO_ACTIVE_LOW>, <&porta 7 GPIO_ACTIVE_LOW>;
+ cs-gpios = <0>, <0>,
+ <&porta 1 GPIO_ACTIVE_LOW>, <&porta 7 GPIO_ACTIVE_LOW>;
  status = "okay";
  spi0_cs0@0 {
  compatible = "pensando,cpld";


diff --git a/arch/arm64/boot/dts/pensando/elba.dtsi
b/arch/arm64/boot/dts/pensando/elba.dtsi
index 029dd5f0045f3..3ff4c39815639 100644
--- a/arch/arm64/boot/dts/pensando/elba.dtsi
+++ b/arch/arm64/boot/dts/pensando/elba.dtsi
@@ -127,6 +127,7 @@
  spi0: spi@2800 {
  compatible = "pensando,elba-spi";
  reg = <0x0 0x2800 0x0 0x100>;
+ pensando,spics = <&mssoc 0x2468 0>;
  clocks = <&ahb_clk>;
  interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
  #address-cells = <1>;
@@ -257,13 +258,6 @@
  reg = <0x0 0x307c2080 0x0 0x4>;
  };

- spics: spics@307c2468 {
- compatible = "pensando,elba-spics";
- reg = <0x0 0x307c2468 0x0 0x4>;
- gpio-controller;
- #gpio-cells = <2>;
- };
-
  pcie@307c2480 {
  compatible = "pensando,pcie";
  reg = <0x0 0x307c2480 0x0 0x4 /* MS CFG_WDT */


diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..64644bae8923 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/gpio.h>
 #include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -53,6 +54,24 @@ struct dw_spi_mscc {
        void __iomem        *spi_mst; /* Not sparx5 */
 };

+struct dw_spi_elba {
+       struct regmap *regmap;
+       unsigned int reg;
+       unsigned int ctl;
+};
+
+/*
+ * ctl:              1               |               0
+ * cs:       1               0       |       1               0
+ * bit:  7-------6-------5-------4---|---3-------2-------1-------0
+ *      cs1   cs1_ovr   cs0   cs0_ovr|  cs1   cs1_ovr   cs0   cs0_ovr
+ *                  ssi1             |            ssi0
+ */
+#define ELBA_SPICS_SHIFT(ctl, cs)      (4 * (ctl) + 2 * (cs))
+#define ELBA_SPICS_MASK(ctl, cs)       (0x3 << ELBA_SPICS_SHIFT(ctl, cs))
+#define ELBA_SPICS_SET(ctl, cs, val)   \
+                       ((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(ctl, cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -237,6 +256,74 @@ static int dw_spi_canaan_k210_init(struct
platform_device *pdev,
        return 0;
 }

+static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
+{
+       regmap_update_bits(dwselba->regmap, dwselba->reg,
+                          ELBA_SPICS_MASK(dwselba->ctl, cs),
+                          ELBA_SPICS_SET(dwselba->ctl, cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+       struct dw_spi *dws = spi_master_get_devdata(spi->master);
+       struct dw_spi_mmio *dwsmmio = container_of(dws, struct
dw_spi_mmio, dws);
+       struct dw_spi_elba *dwselba = dwsmmio->priv;
+       u8 cs = spi->chip_select;
+
+       if (cs < 2) {
+               /* overridden native chip-select */
+               elba_spics_set_cs(dwselba, spi->chip_select, enable);
+       }
+
+       /*
+        * The DW SPI controller needs a native CS bit selected to start
+        * the serial engine, and we have fewer native CSs than we need, so
+        * use CS0 always.
+        */
+       spi->chip_select = 0;
+       dw_spi_set_cs(spi, enable);
+       spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+                           struct dw_spi_mmio *dwsmmio)
+{
+       struct of_phandle_args args;
+       struct dw_spi_elba *dwselba;
+       struct regmap *regmap;
+       int rc;
+
+       rc = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+                                             "pensando,spics", 2, 0, &args);
+       if (rc) {
+               dev_err(&pdev->dev, "could not find pensando,spics\n");
+               return rc;
+       }
+
+       regmap = syscon_node_to_regmap(args.np);
+       if (IS_ERR(regmap)) {
+               dev_err(&pdev->dev, "could not map pensando,spics\n");
+               return PTR_ERR(regmap);
+       }
+
+       dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
+       if (!dwselba)
+               return -ENOMEM;
+
+       dwselba->regmap = regmap;
+       dwselba->reg = args.args[0];
+       dwselba->ctl = args.args[1];
+
+       /* deassert cs */
+       elba_spics_set_cs(dwselba, 0, 1);
+       elba_spics_set_cs(dwselba, 1, 1);
+
+       dwsmmio->priv = dwselba;
+       dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+       return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
        int (*init_func)(struct platform_device *pdev,
@@ -351,6 +438,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
        { .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
        { .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
        { .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+       { .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
        { /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
