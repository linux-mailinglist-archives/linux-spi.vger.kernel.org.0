Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55FC3F4337
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhHWB41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhHWB41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:56:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C783C061760
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:55:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u14so8767450ejf.13
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tz31Ip+d88q4notp2SJUNTDQ11/lHsjf6zS5pkBEzRM=;
        b=X77g2JFcmN9ReUaC1GUwBLrk97TiOf4784B5Aq01SQ3KP4uasQf+RjpZ9cRrJ+PB+n
         gOA0cwcz0BHkZLQyhlN7rQB0lr4PPnpSIRRaLMp3KWWNz2oInfxj97zFRR1aaYtfjj0+
         NRwsv4beCFTxC7Ym5mSgf+CCji1Ylvff4+2ssuWtv4TTUGqFxZNAgjn2AXhWu8xp0Bud
         eXUOYT1ip06L/spnrndG4aYBPULkNPRuuzKOiCp4DZKC8RKmfawYNs5HFrAgM50xo2v8
         jQaDWoZekHC2guKCcy+se7bvVUdpKiGLzH6IkPzthHOxhWQcvZsvY3dPOZkEY2EyTExi
         fGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tz31Ip+d88q4notp2SJUNTDQ11/lHsjf6zS5pkBEzRM=;
        b=m8bxPDIFcqOfKrOJb+ad76b+9IR8gg53aU3v9YPxyvKWg+/UWOV6urVf3PFQv4oDsK
         JkJEh+OF9U0vp0UKLfRUqtQNAkUcII7W3SJQ4Kywpa5091DlcoR7h/PK5PZ1dezSiFmd
         vKyGWUVyAX4VUCk+hY5T8RmdCvCsvENxhZZgeCSbXawf3v/0Z+No4B7xx2EKxSqJ7lfe
         BNFfqQ4+cM8xWhlooATC8n0SlLdEb4JRTuk4rXi3op3OPkhWwbsCgfQ0Tio5IFnRDlDq
         MWyGqf4o8LCmUXuMw/tdf4Pbi/EvAiIyUmv5iJNi2NJwJRd7DJ2KD4fGTGrsxmGtLCXF
         Q+5Q==
X-Gm-Message-State: AOAM531oQk7tqfgjwKQfIIY4UXUm3erzRa12p3gptzCq9a1lKHZGojox
        pTTGSpKgTD4WpDjHLUoFmia/NlYBQv/c3P2yseZgMQ==
X-Google-Smtp-Source: ABdhPJyHPzxNPnHQM6zwsVpAgSZKmdLIp7fNDAUA/Rnx1mUlz0Ajztr5YkW8HM5iXXVjpW15H3Vc+5ea769kyjz6DfE=
X-Received: by 2002:a17:906:2305:: with SMTP id l5mr33543905eja.72.1629683743423;
 Sun, 22 Aug 2021 18:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-8-brad@pensando.io>
 <20210331175130.mhub5yxc3szfsl5q@mobilestation>
In-Reply-To: <20210331175130.mhub5yxc3szfsl5q@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:55:32 -0700
Message-ID: <CAK9rFnxX+AOkZ6TWogG7G=FqMs_JhH2RUDw=8gZ=Gsf=Vk+9aw@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] arm64: dts: Add Pensando Elba SoC support
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergey,

On Wed, Mar 31, 2021 at 10:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Rob,
> Could you give your opinion on my comment regarding the nodes
> layout in this dts-file. I was told to fix a similar problem in one of
> patches submitted by me some time ago. Please see my last comment in
> this message.
>
> On Sun, Mar 28, 2021 at 06:59:32PM -0700, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
[...]
> > +
>
> > +             // CLUSTER 0
>
> What does chackpatch.pl tell you about C++ comment?

I don't recall a warning for this but I think I forgot to use W=1 to
check dtbs.  Will make sure it's clean before submitting the v3
patchset.

[...]
> > +             // CLUSTER 1
>
> ditto

I've changed all C++ comments to C syntax

[...]
> > diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> > new file mode 100644
> > index 000000000000..7de2c35e7fcc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> > @@ -0,0 +1,112 @@
> > +
> > +/ {
> > +     model = "Elba ASIC Board";
> > +
> > +     aliases {
>
> > +             serial0 = &uart0;
> > +                spi0 = &spi0;
> > +                spi1 = &qspi;
>
> Brad, if you checkpatch.pl'ed this patch, that would have told you
> regarding leading spaces here.

I did run it but must have missed that or used it incorrectly for the
dtsi files.

[...]
> > +             pxc0_intr: intc@20102200 {
> > +                     compatible = "pensando,soc-ictlr-csrintr";
> > +                     interrupt-controller;
>
> > +                     reg = <0x0 0x20102200 0x0 0x4>;
>
> Rob, please note the reg-space size here.
>
> > +                     #interrupt-cells = <3>;
> > +                     interrupt-parent = <&gic>;
> > +                     interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names = "pxc0_intr";
> > +             };
> > +
> > +             uart0: serial@4800 {
> > +                     device_type = "serial";
> > +                     compatible = "ns16550a";
> > +                     reg = <0x0 0x4800 0x0 0x100>;
> > +                     clocks = <&ref_clk>;
> > +                     interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +                     reg-shift = <2>;
> > +                     reg-io-width = <4>;
> > +             };
> > +
> > +             qspi: spi@2400 {
> > +                     compatible = "pensando,cdns-qspi";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     reg = <0x0 0x2400 0x0 0x400>,
> > +                           <0x0 0x7fff0000 0x0 0x1000>;
> > +                     interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&flash_clk>;
> > +                     cdns,fifo-depth = <1024>;
> > +                     cdns,fifo-width = <4>;
> > +                     cdns,trigger-address = <0x7fff0000>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             gpio0: gpio@4000 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     compatible = "snps,dw-apb-gpio";
>
>
> > +                     reg = <0x0 0x4000 0x0 0x78>;
>
> Brad, are you sure the reg-space is just 0x78 bytes in this DW GPIO
> module? Normally the system bus blocks are aligned to something
> no less than 1KB...

In the memory map the devices stride 1KB but the last register for
this IP is at 0x74..0x77.  Looks like this will need to be revisited
should a working syscon usage be discovered.

>
> > +                     status = "disabled";
> > +
>
> > +                     porta: gpio-controller@0 {
>
> Brad, I'd prefer to name the sub-nodes as "gpio-port" for DW APB GPIO
> because hardware considers each of them as dedicated port of the
> GPIO controller. I know the bindings file permits using "-controller"
> suffix, but that is allowed only because the bindings file was submitted
> much later than the driver was. So I didn't want to have the dtbs_check
> printing errors for already available dts-files.
>

Named these sub-nodes "gpio-port"

> > +                             compatible = "snps,dw-apb-gpio-port";
> > +                             reg = <0>;
> > +                             gpio-controller;
> > +                             #gpio-cells = <2>;
> > +                             ngpios = <8>;
> > +                             interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> > +                             interrupt-controller;
> > +                             interrupt-parent = <&gic>;
> > +                             #interrupt-cells = <2>;
> > +                     };
> > +                     portb: gpio-controller@1 {
> > +                             compatible = "snps,dw-apb-gpio-port";
> > +                             reg = <1>;
> > +                             gpio-controller;
> > +                             #gpio-cells = <2>;
> > +                             ngpios = <8>;
> > +                     };
> > +             };
> > +
> > +             i2c0: i2c@400 {
> > +                     compatible = "snps,designware-i2c";
> > +                     reg = <0x0 0x400 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     i2c-sda-hold-time-ns = <480>;
> > +                     snps,sda-timeout-ms = <750>;
> > +                     interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             /* UIO device using interrupt line PCIEMAC */
> > +             pciemac@20102200 {
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     #interrupt-cells = <3>;
> > +
> > +                     compatible = "pensando,uio_pciemac";
> > +                     register-type = "csr-interrupt";
> > +                     interrupt-parent = <&pxc0_intr>;
> > +                     interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +                     reg = <0x0 0x20102200 0x0 0x10>; /* pxc0_intr */
> > +
> > +                     enable_csr_paddr = <0x0 0x20102200 0x0 0x10>;
> > +                     enable_mask = <(1 << 0)>;
> > +             };
> > +
> > +             /* MSI UIO device 1 */
> > +             uio_penmsi1@520000 {
> > +                     compatible = "pensando,uio_penmsi1";
> > +                     reg = <0x0 0x520000 0x0 0x10000>;
> > +                     msi-parent = <&its 0xa>;
> > +                     num-interrupts = <16>;  /* # MSI interrupts to get */
> > +             };
> > +
> > +             spics: spics@307c2468 {
> > +                     compatible = "pensando,elba-spics";
>
> > +                     reg = <0x0 0x307c2468 0x0 0x4>;
>
> Rob, please note the reg-space base address and size here.
>
> > +                     gpio-controller;
> > +                     #gpio-cells = <2>;
> > +             };
> > +
> > +             spi0: spi@2800 {
> > +                     compatible = "pensando,elba-spi";
> > +                     reg = <0x0 0x2800 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     num-cs = <2>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             wdt0: watchdog@1400 {
> > +                     compatible = "snps,dw-wdt";
> > +                     reg = <0x0 0x1400 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +             };
> > +             wdt1: watchdog@1800 {
> > +                     compatible = "snps,dw-wdt";
> > +                     reg = <0x0 0x1800 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +             };
> > +             wdt2: watchdog@1c00 {
> > +                     compatible = "snps,dw-wdt";
> > +                     reg = <0x0 0x1c00 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +             };
> > +             wdt3: watchdog@2000 {
> > +                     compatible = "snps,dw-wdt";
> > +                     reg = <0x0 0x2000 0x0 0x100>;
> > +                     clocks = <&ahb_clk>;
> > +                     interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             emmc: mmc@30440000 {
> > +                     compatible = "pensando,elba-emmc", "cdns,sd4hc";
> > +                     clocks = <&emmc_clk>;
> > +                     interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +                     reg = <0x0 0x30440000 0x0 0x10000
>
> > +                            0x0 0x30480044 0x0 0x4>;
>
> Rob, please also note the reg-space base address and size here.
> Brad just writes some magic numbers to this register in the MMC drive.
> The field is named as "ctl_addr" in the driver.
>
> > +                     cdns,phy-input-delay-sd-highspeed = <0x4>;
> > +                     cdns,phy-input-delay-legacy = <0x4>;
> > +                     cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> > +                     cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> > +                     cdns,mmc-ddr-1_8v;
> > +                     status = "disabled";
> > +             } ;
> > +
> > +             pcie@307c2480 {
> > +                     compatible = "pensando,pcie";
>
> > +                     reg = <0x0 0x307c2480 0x0 0x4   /* MS CFG_WDT */
>
> Rob, please note the reg-space base address and size here.
>
> > +                            0x0 0x00001400 0x0 0x10  /* WDT0 */
> > +                            0x0 0x20000000 0x0 0x00380000>; /* PXB Base */
> > +             };
> > +
> > +             panic: panicdump@0 {
> > +                     compatible = "pensando,pen-crash";
> > +                     status = "disabled";
> > +             };
> > +
> > +             bsm@307c2080 {
> > +                     compatible = "pensando,bsm";
>
> > +                     reg = <0x0 0x307c2080 0x0 0x4>;
>
> Rob, please see here having a small sized reg-space one more time.
> Having so many small-sized registers scattered around the dts file
> makes me thinking that most of them likely belong to some bigger
> block like "System Controller". If so then there must be a main node
> compatible with "syscon" device, which phandle would be referenced in
> the particular device nodes. Like this:
>
> \ {
>         soc {
>                 syscon: syscon@307c0000 {
>                         compatible = "pensando,elba-sys-con", "syscon", "simple-mfd";
>                         reg = <0x0 0x307c0000 0x0 0x10000>;
>
>                         spics: spics@307c2468 {
>                                 compatible = "pensando,elba-spics";
>                                 gpio-controller;
>                                 #gpio-cells = <2>;
>                         };
>                 };
>
>                 pcie@307c2480 {
>                         compatible = "pensando,pcie";
>                         reg = <0x0 0x20000000 0x0 0x00380000>; /* PXB Base */
>
>                         syscon = <&syscon>;
>                 };
>
>                 /* etc */
>         };
> };
>
> Rob, what do you think about that? Correct me if I am wrong.
>
> Brad, it's not about "To us it was more understandable" like you
> responded to my comment in v1, but about having the DTS correctly
> describing the hardware. Splitting the system controller registers up
> isn't good in that regard even if you think it makes the driver code
> more "understandable" and so on.
>
> Also Brad, don't hurry with re-sending the patchset before finishing
> all the discussions. I'd understand you doing so if noone would have
> given you any comment in a long time, but you've got tons of them
> nearly within one-two days after the v1 patchset submission. So you
> should have answered to the comments first, settled all the issues,
> then respined the series. Otherwise it seems as if you just disregard
> all the work the reviewers did giving you the comments.

Yes I appreciate the feedback and only recently had time to go through
all of the input, refactor, clean-up, and test on our 5.10 production
server.  Once all issues are resolved and tested on 5.10 and works
then I can redo the series using the latest linux-next.  Syscon in the
DT as mentioned above I've taken a few passes at with DT and
accompanying device driver changes and no joy yet.

Regards,
Brad
