Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044DB1EB73F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBIVt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBIVt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 04:21:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1FC061A0E;
        Tue,  2 Jun 2020 01:21:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so11488085ljo.5;
        Tue, 02 Jun 2020 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FjBag7M9X3aH/ZEGPq07O51zdgo35JEFdqZ5HJOkkrY=;
        b=trqAUZ5/3aI8+fzxUeXYg9HQQREJNPKZygkPMG8OxgCxlHjocPZQUltnETkIeH93+x
         GlvbKY7vPkmozFCHoqeUJZt/LA4ILlc7q4q8w8RaZgwrHLs981qT/DOlGWbtbSuGsd6W
         GzipgCj7YaEfl0q5vDgePniFVNOi7X2IMK+FTlrMBvD/SQxvL5vlMyE6URYW5Rw8+LRB
         84edeF780OHnDzvL6K0FackZAXac+L+jbj+3PLOMs4RA6KhctEzjbQGpsnah12f5RHPj
         ZiQuO6IvA1ojr8tFR2/x08q35acbauyctmRta6izQdslhJvvVMzeBKkyFKdsdCq/Sjar
         HMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjBag7M9X3aH/ZEGPq07O51zdgo35JEFdqZ5HJOkkrY=;
        b=rcTnYSP+GCnhfwta9SyK0Rfne3U6xPbdKdeQMT7uoK4T7qEkoEO0EjU7p2rg+r8DmX
         KfhvWNyh/VwQsiu4sDJuFM1Gci4h4R8UHRFg3YmyE6aUuG02BXbA+ijug+ECx2WoBook
         n9vGV8TV7zcLCxhOhIkx2D3NkPAD5SFn+YmrzhZ1FqXb85vTS4fLiSkx+C0VrlCa+1XM
         xOppm+HFn4rp6R8lwNLmBHjJJSLoYKOAXC+5t4Eu2qW+c/+CoZ3yOiwHdgjVSJyBryws
         uZyPMY6QDvIEUoqhf3KVakyZmGGObfTms2nLN/YdvWZ8FbZkeEHFNYgPtRXISPDzzzpV
         tXYQ==
X-Gm-Message-State: AOAM531J6SxxjdpSyvQ9NPZEMd7OPs9akllNc7xN2qgG2rxeY8S+AJ/V
        Mhc1esVbKyh4SNgM4tA4+Mk=
X-Google-Smtp-Source: ABdhPJzDOQi6hmzqge53Xl5Zq7aD1IUTng25DanPHl/+hcvMgGV5LOyybYU5LKq4k+WpCS9xK0BI4w==
X-Received: by 2002:a2e:5c45:: with SMTP id q66mr7580829ljb.147.1591086107518;
        Tue, 02 Jun 2020 01:21:47 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id d22sm516778lfn.84.2020.06.02.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:21:46 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:21:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] spi: Adding support for Microchip Sparx5 SoC
Message-ID: <20200602082144.z2crru6uqoiyfj5k@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200529162130.hsjcde27xhohl6jl@mobilestation>
 <87img9q3sb.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87img9q3sb.fsf@soft-dev15.microsemi.net>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 02, 2020 at 10:18:28AM +0200, Lars Povlsen wrote:
> 
> Serge Semin writes:
> 
> > Hello Lars,
> >
> > On Wed, May 13, 2020 at 04:00:21PM +0200, Lars Povlsen wrote:
> >> This is an add-on series to the main SoC Sparx5 series
> >> (Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).
> >>
> >> The series add support for Sparx5 on top of the existing
> >> ocelot/jaguar2 spi driver.
> >>
> >> It spins off the existing support for the MSCC platforms into a
> >> separate driver, as adding new platforms from the MSCC/Microchip
> >> product lines will further complicate (clutter) the original driver.
> >>
> >> New YAML dt-bindings are provided for the resulting driver.
> >>
> >> It is expected that the DT patches are to be taken directly by the arm-soc
> >> maintainers.
> >
> > Regarding our cooperation. It can be implemented as follows. Since your patchset
> > is less cumbersome than mine and is more ready to be integrated into the generic DW
> > APB SSI code, it would be better to first make it through Mark', Andy' and my reviews
> > to be further merged into the kernel version of the driver. After that I'll have
> > my code altered so it could be applied on top of your patches. When everything
> > is done we'll have a more comprehensive DW APB SSI driver with poll-based
> > PIO operations support, new features like rx-delay, etc.
> >
> 
> Hi Serge!
> 
> I think I would be able to work on the SPI patches this week. Should I
> base it on the current spi-next or 5.7? Then address the comments and
> send out a new revision?
> 
> Thanks for reaching out.

Sorry for a delay. I had to finish urgent tasks first. I'll give my review comments
shortly today.

-Sergey

> 
> ---Lars
> 
> > Thank you one more time for the series you've shared with us. Let's see what can
> > be done to improve it...
> >
> > -Sergey
> >
> >>
> >> Lars Povlsen (10):
> >>   spi: dw: Add support for polled operation via no IRQ specified in DT
> >>   spi: dw: Add support for RX sample delay register
> >>   spi: dw: Add support for client driver memory operations
> >>   dt-bindings: spi: Add bindings for spi-dw-mchp
> >>   spi: spi-dw-mmio: Spin off MSCC platforms into spi-dw-mchp
> >>   dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
> >>   spi: spi-dw-mchp: Add Sparx5 support
> >>   arm64: dts: sparx5: Add SPI controller
> >>   arm64: dts: sparx5: Add spi-nor support
> >>   arm64: dts: sparx5: Add spi-nand devices
> >>
> >>  .../bindings/spi/mscc,ocelot-spi.yaml         |  89 ++++
> >>  .../bindings/spi/snps,dw-apb-ssi.txt          |   7 +-
> >>  MAINTAINERS                                   |   2 +
> >>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |  37 ++
> >>  .../boot/dts/microchip/sparx5_pcb125.dts      |  16 +
> >>  .../boot/dts/microchip/sparx5_pcb134.dts      |  22 +
> >>  .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 +
> >>  .../boot/dts/microchip/sparx5_pcb135.dts      |  23 +
> >>  .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 +
> >>  arch/mips/configs/generic/board-ocelot.config |   2 +-
> >>  drivers/spi/Kconfig                           |   7 +
> >>  drivers/spi/Makefile                          |   1 +
> >>  drivers/spi/spi-dw-mchp.c                     | 399 ++++++++++++++++++
> >>  drivers/spi/spi-dw-mmio.c                     |  93 ----
> >>  drivers/spi/spi-dw.c                          |  31 +-
> >>  drivers/spi/spi-dw.h                          |   4 +
> >>  16 files changed, 644 insertions(+), 107 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
> >>  create mode 100644 drivers/spi/spi-dw-mchp.c
> >>
> >> --
> >> 2.26.2
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> Lars Povlsen,
> Microchip
