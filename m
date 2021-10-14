Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515C042E269
	for <lists+linux-spi@lfdr.de>; Thu, 14 Oct 2021 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhJNUJK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhJNUJJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Oct 2021 16:09:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD48C061753
        for <linux-spi@vger.kernel.org>; Thu, 14 Oct 2021 13:07:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so29035454edc.13
        for <linux-spi@vger.kernel.org>; Thu, 14 Oct 2021 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOC9prHZYIEZh+iOSkgASgqcP4dzHU1Vi2nx843IsCk=;
        b=NL0BrbBgqbeg+0k1NdyHAoUworVxwn/bPXtWcOyPrJjiIpNlT1faHXA45eyP9NndQ8
         GY6YgAmOHLAZ/tAmiSlkjl6N8hPbdMSxqgVNlAkQWq4zFMK0JLWO7AArMg2YnWWk2jSp
         k3WkVkHvKn3O99QXT7K3GiVbGxYD/qzA3Bw94Yswc2z3skllu6r8XA+f/34SzUTYrVno
         +RIWyNtx2rCeOe/yliw4fna8bHmSd0oZjw9hN+mJnzJL47/a/yr3XjQDu7aRj4zYWWVv
         4EypWFYkT+zi4P4XBv6M0hYyyXU8d9p2vYXwozwbXGocu6QkkGopMHu6J9GPflpKU/6N
         gtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOC9prHZYIEZh+iOSkgASgqcP4dzHU1Vi2nx843IsCk=;
        b=oMOS8DLr7to/hy+AIqJXvmyVudAG5YNGJjiaEV7e2aaZuKp1YHqzK5grf1Xwk8r1zC
         hW2qznv6h3PKOh15pyVKvvwhFE0hqDcB85Au/6WTISVGY6Or+jciPpQlEOyS8nlt/aee
         f55AWHGgXGzLI/BIo24Y998TNG6NOZ/qB25rDmPxkYab+0OKwWoPHv8G/rt2aZiLr2bO
         fz6+myr+4wSDc7Ce8j7XeYTPtJDBbKo3rOFjjb0CpLy+ikrn4QRt3ljDgsN/9erRC3jD
         S8kiVVtbHas0rGccDrQBcwQ/lfoK4gjOe5xkVnzBqwOmK7qyZ7DgbGTmTR3e9F2RdToG
         9NXA==
X-Gm-Message-State: AOAM532MsY8pFmFnK9AzGKXDemadL/f2H0rKY+VoZ1C3qbd28DTvmPoo
        y7s0rEvGvsRAgd+ItLlMFzW73pepn/BY1YRCS6L1ww==
X-Google-Smtp-Source: ABdhPJxD9UzCWfjeFxRsC1YkcQ1vTaG6mft6f+Mucv9VjzzB99L17qlsFkC2Y1a/7iwSh5iOwxPa20nY0PCyjOOngtw=
X-Received: by 2002:a17:906:b19:: with SMTP id u25mr1397747ejg.36.1634242022767;
 Thu, 14 Oct 2021 13:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
 <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
 <CAK9rFnxuiAX2-5TFhfyTdpaY3BRysX_Q2sJkca4LhOLzapB83Q@mail.gmail.com> <CACRpkdbF3oXec-8Z-1fNVL47mfYo2TW8WTDxzpwaR2YqLaTdAQ@mail.gmail.com>
In-Reply-To: <CACRpkdbF3oXec-8Z-1fNVL47mfYo2TW8WTDxzpwaR2YqLaTdAQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Thu, 14 Oct 2021 13:06:52 -0700
Message-ID: <CAK9rFnx1NN92coAgUC7douF+ny8dCL5uoFopBaWAE_q02-XWyg@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 4:52 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Oct 4, 2021 at 6:46 PM Brad Larson <brad@pensando.io> wrote:
>
> > Yes that works, please see the diff below where the file
> > gpio-elba-spics.c goes away.  The original implementation was
> > motivated by gpio-spear-spics.c.
>
> This looks good to me :)
>
> Yours,
> Linus Walleij

Hi Linus,

:-)  It's better to not have to look at a related gpio driver file to
the spi-dw-mmio.c
driver and think it could possibly be used as general purpose gpio.

Here is a response summary per patch.  Should I start respinning the
patchset against
the latest linux-next tag?  The changes are merged to our production
5.10.28 kernel
and the next step is to re-spin the set against the latest linux-next
which has a newer dtc,
run checkpatch, etc.  For reference as this has been cooking for
awhile here is the
overview from V2 patchset cover letter.

This series enables support for Pensando Elba SoC based platforms.

The Elba SoC has the following features:
- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

Summary of response to V1/V2 patchset
0001-gpio-Add-Elba-SoC-gpio-driver-for-spi-cs-control.patch
- This patch is deleted.  Elba SOC specific gpio spics control is
  integrated into spi-dw-mmio.c.

0002-spi-cadence-quadspi-Add-QSPI-support-for-Pensando-El.patch
- Changed compatible to "pensando,elba-qspi" to be more descriptive
  in spi-cadence-quadspi.c.

- Arnd wondered if moving to DT properties for quirks may be the
  way to go.  Feedback I've received on other patches was don't
  mix two efforts in one patch so I'm currently just adding the
  Elba support to the current design.

0003-spi-dw-Add-support-for-Pensando-Elba-SoC-SPI.patch
- Changed the implementation to use existing dw_spi_set_cs() and
  integrated Elba specific CS control into spi-dw-mmio.c.  The
  native designware support is for two chip-selects while Elba
  provides 4 chip-selects.  Instead of adding a new file for
  this support in gpio-elba-spics.c the support is in one
  file (spi-dw-mmio.c).

0004-spidev-Add-Pensando-CPLD-compatible.patch
- This patch is deleted.  The addition of compatible "pensando,cpld"
  to spidev.c is removed.

0005-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Ulf and Yamada-san agreed the amount of code for this support
  is not enough to need a new file.  The support is added into
  sdhci-cadence.c and new files sdhci-cadence-elba.c and
  sdhci-cadence.h are deleted.
- Redundant defines are removed (e.g. use SDHCI_CDNS_HRS04 and
  remove SDIO_REG_HRS4).
- Removed phy init function sd4_set_dlyvr() and used existing
  sdhci_cdns_phy_init(). Init values are from DT properties.
- Replace  devm_ioremap_resource(&pdev->dev, iomem)
     with  devm_platform_ioremap_resource(pdev, 1)
- Refactored the elba priv_writ_l() and elba_write_l() to
  remove a little redundant code.
- The config option CONFIG_MMC_SDHCI_CADENCE_ELBA goes away.
- Only C syntax and Elba functions are prefixed with elba_

0006-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Added a little more info to the platform help text to assist
  users to decide on including platform support or not.

0007-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Node names changed to DT generic names
- Changed from using 'spi@' which is reserved
- The elba-flash-parts.dtsi is kept separate as
  it is included in multiple dts files.
- SPDX license tags at the top of each file
- The compatible = "pensando,elba" and 'model' are
  now together in the board file.
- UIO nodes removed
- Ordered nodes by increasing unit address
- Removed an unreferenced container node.
- Dropped deprecated 'device_type' for uart0 node.
- Added syscon usage

0010-dt-bindings-spi-cadence-qspi-Add-support-for-Pensand.patch
- Updated since the latest documentation has been converted to yaml

0011-dt-bindings-gpio-Add-Pensando-Elba-SoC-support.patch
- This patch is deleted since the Elba gpio spics is added to
  the spi dw driver and documented there.

Best,
Brad
