Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125935045A
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhCaQSO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhCaQRm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Mar 2021 12:17:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA45C061574;
        Wed, 31 Mar 2021 09:17:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b4so29948986lfi.6;
        Wed, 31 Mar 2021 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPTB0etVorroutByXiQaQbWMvlGDX7gocxxMDABfiMQ=;
        b=LcoO4OJ7AQzT3kBgCDGn0fHviE3dj8uDS24GDl2D2cIEG7wSrbY6TJWL+qBxfmlmJX
         nRiKrsHvsi/vXgTg8KmA+cx8yf20qkNC7Vk0sTofQzX/u3ymQuNj8AxBt7NPtINcjZA8
         lv55AsAP14CqbLsL1NgeP0Fz0hnpmchjKrYQhugqIOU1r8kdV0OOy8yX4rs7foxC/i+O
         /OphruhiZsauPLa6yV5yJHxnAcqi0GnSR13BGrjb3Wl6wV/MUBzlcocJ0g5voZX7p8cA
         4O3n6ZTEHXTqXHqjrY2AxfN+U6h8/mIS9fMZS+U+bHgGBQkYov6j3oFHB1lwQa51XS0E
         01iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPTB0etVorroutByXiQaQbWMvlGDX7gocxxMDABfiMQ=;
        b=gK+9HG0FzmpPMPh27LcvcnhnYKcv/dZ/uYWGOZzqpN5RMm6dU8wQggPV2e6RYHnGic
         bk0ppdIX8WPLWq+w5NM4CfzhvzAI6+BoaqPjuzlDKsUyMvt2lBgehpoYTwc2lh+4noN7
         t+h+m2btr+GlBZ/wqlidQpUHHT4O0uIpIxwfJyML6R6vZJmUDhz0E4RDDnbhsNSyOcP8
         BhBJd2XDM5S2OENLnEKlbdxwcaJlfFKoDqarg8OvWkcZxLiiXXjiu15YAWMJv2lunfDM
         etfZCOE+ChWzGWh04pJ8eLpbB3mEfWl3ypBd+zJMROeprw4lGNBx/PEps29zngbVEkro
         UzCA==
X-Gm-Message-State: AOAM530/hJhCm9qY0DZOHj2YRQJqvUdfcMqkGnllOlZyxb9/LiMiIYb4
        hc79jngsE05JHkRCWFjRl8g=
X-Google-Smtp-Source: ABdhPJyQewBVQCg+Ta5PS76RCRFrtQh/QvHmjcX+75R3stv2JOAmUc3tfyHrjK4nXfUQ+eWgbC/9aA==
X-Received: by 2002:a19:430e:: with SMTP id q14mr2869941lfa.374.1617207460678;
        Wed, 31 Mar 2021 09:17:40 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id b34sm281772ljf.137.2021.03.31.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:17:40 -0700 (PDT)
Date:   Wed, 31 Mar 2021 19:17:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Support Pensando Elba SoC
Message-ID: <20210331161738.rc6oecz25z6ywqhl@mobilestation>
References: <20210329015938.20316-1-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brad

On Sun, Mar 28, 2021 at 06:59:25PM -0700, Brad Larson wrote:
> This series enables support for Pensando Elba SoC based platforms.
> The Elba SoC has the following features:
> 
> - Sixteen ARM64 A72 cores
> - Dual DDR 4/5 memory controllers
> - 32 lanes of PCIe Gen3/4 to the Host
> - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
>   also a single 1GE management port.
> - Storage/crypto offloads and 144 programmable P4 cores.
> - QSPI and EMMC for SoC storage
> - Two SPI interfaces for peripheral management
> - I2C bus for platform management
> 
> See below for an overview of changes since v1.
> 
> == Patch overview ==
> 
> - 01    Fix typo, return code value and log message.
> - 03    Remove else clause, intrinsic DW chip-select is never used.
> - 08-11 Split out dts and bindings to sub-patches
> - 10    Converted existing cadence-quadspi.txt to YAML schema
> - 13    New driver should use <linux/gpio/driver.h>

That would be super-useful if each changelog entry was also added to the
individual patches below "---" splitter.

-Sergey

> 
> Brad Larson (13):
>   gpio: Add Elba SoC gpio driver for spi cs control
>   spi: cadence-quadspi: Add QSPI support for Pensando Elba SoC
>   spi: dw: Add support for Pensando Elba SoC SPI
>   spidev: Add Pensando CPLD compatible
>   mmc: sdhci-cadence: Add Pensando Elba SoC support
>   arm64: Add config for Pensando SoC platforms
>   arm64: dts: Add Pensando Elba SoC support
>   dt-bindings: Add pensando vendor prefix
>   dt-bindings: mmc: Add Pensando Elba SoC binding
>   dt-bindings: spi: cadence-qspi: Add support for Pensando Elba SoC
>   dt-bindings: gpio: Add Pensando Elba SoC support
>   MAINTAINERS: Add entry for PENSANDO
>   gpio: Use linux/gpio/driver.h
> 
>  .../bindings/gpio/pensando,elba-spics.yaml    |  50 +++
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   1 +
>  .../bindings/spi/cadence-quadspi.txt          |  68 ----
>  .../bindings/spi/cadence-quadspi.yaml         | 153 +++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   9 +
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   6 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 170 ++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   | 112 +++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |   7 +
>  .../boot/dts/pensando/elba-flash-parts.dtsi   |  78 +++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 310 ++++++++++++++++++
>  drivers/gpio/Kconfig                          |   6 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-elba-spics.c                | 113 +++++++
>  drivers/mmc/host/Kconfig                      |  15 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-cadence-elba.c         | 137 ++++++++
>  drivers/mmc/host/sdhci-cadence.c              |  81 +++--
>  drivers/mmc/host/sdhci-cadence.h              |  68 ++++
>  drivers/spi/spi-cadence-quadspi.c             |   9 +
>  drivers/spi/spi-dw-mmio.c                     |  28 +-
>  drivers/spi/spidev.c                          |   1 +
>  25 files changed, 1321 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/pensando,elba-spics.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
>  create mode 100644 drivers/gpio/gpio-elba-spics.c
>  create mode 100644 drivers/mmc/host/sdhci-cadence-elba.c
>  create mode 100644 drivers/mmc/host/sdhci-cadence.h
> 
> -- 
> 2.17.1
> 
