Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295BA3EE176
	for <lists+linux-spi@lfdr.de>; Tue, 17 Aug 2021 02:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhHQAww (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Aug 2021 20:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhHQAww (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Aug 2021 20:52:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA347C061764;
        Mon, 16 Aug 2021 17:52:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c5so23226781ybn.5;
        Mon, 16 Aug 2021 17:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HinwW8PEQ5TbL83px5ZX1LnwF3iy1N97HumVOQEeuS0=;
        b=Qv7l1OnPPmEjqSE03PxZdhP+8SGNkjQKJQdjg0iHsO/stBYHgcAtVCjxeNcJndtCIa
         4O/Qrm9MusETqQznj/842Y5fi+yJR94JfvJE4Om2M7TCiewcPXg+8VbqYSFAgLp5pXh7
         j3JcyUvpdvuR+NgJ5XcRUfE0UE6aDWHRd003YcVCI5jaFI17gEKoHN0OCyQSiNO1fNz2
         6Ijh9U/Kjeb/gkoCs2lyZA6wy6S+OqJJUUx/4OledGbI2q8oxnMFIw78qwTWbjbDqQ6B
         EFVYapxQkAGzPKhlCH/kTKf4pMTOS4PYTsbdpkSTsFwx6BV53IDcZ5qmsakSeF1pBSJN
         OnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HinwW8PEQ5TbL83px5ZX1LnwF3iy1N97HumVOQEeuS0=;
        b=FEtEGWltmTVyciPPM1YL9T8VVZrsFrSjrignHCww2e5Noqy2iIfDrHvWF4+tbX/ME2
         SC321eoSgv/xUoTMGEDVcYssfC9pZ+DsEd6HvL7bQFr5ZsyycFGXYXPOHtAuigOxJ/Zc
         WEzV0LSY2jGIeE4eaSBB/NsOPKd9n0jjY2/gIG9qxSGZeH9E3iW2qp3FkxMeWLETY6zh
         yU4eb6R+t12sFcEQasNIb9vuOfU51uZzkDGoG2axrckUCFdCTInLFejsS0gWXhv/UFPk
         G1MTVyyr6AxsOmBH0jc19/TIND4i3iJXMTwNu0oC1cFa/sA0HnlbfeXqbMZMGRMPXo+c
         en8Q==
X-Gm-Message-State: AOAM533az0bvhNq0S4lvIcEg5qKGjLEDm3yrHfWWuMl/OBGR6qFRQ8gy
        AexqfcnCSjRqbINRUcc5sTUXIIDGq1WeXg/4+vA=
X-Google-Smtp-Source: ABdhPJyvd+RlYj7zSTrYmgpFZ+h0LzvbUGhnoGD4IXYxW7eMQY/mIwx4HSolYlYkfx4EfX94jdzZBwmZLYdlWLjwYCg=
X-Received: by 2002:a25:3c5:: with SMTP id 188mr954399ybd.437.1629161538607;
 Mon, 16 Aug 2021 17:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210812134546.31340-1-jon.lin@rock-chips.com>
In-Reply-To: <20210812134546.31340-1-jon.lin@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 16 Aug 2021 20:52:07 -0400
Message-ID: <CAMdYzYobqhLAHhDU9E-iu-HMKSaGCDBMU-2OacGEZOQnF2ZyMw@mail.gmail.com>
Subject: Re: [PATCH v13 0/6] Add Rockchip SFC(serial flash controller) support
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, yifeng.zhao@rock-chips.com,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macroalpha82@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 12, 2021 at 9:49 AM Jon Lin <jon.lin@rock-chips.com> wrote:
>

Good Evening,

Tested successfully on the rk3566 based Quartz64 Model A.
Tested-by: Peter Geis <pgwipeout@gmail.com>

Very Respectfully,
Peter Geis

>
>
> Changes in v13:
> - Provide independent interfaces to obtain RX TX FIFO status respectively
> - Add more debug information
> - Depress DMA limitation
>
> Changes in v12:
> - Remove useless oneOf lable
> - Add sfc controller discription
> - Remove the limitation of SFC_MIN_SPEED_HZ
> - Add IRQ_NONE method for irq handler
> - Add SPI_MASTER_HALF_DUPLEX flags
> - Add sfc interrupt mask bits and status register initial progress
>
> Changes in v11:
> - The tx is set to 1 for Odroid Go Advance device
>
> Changes in v10:
> - Fix dma transfer logic
>
> Changes in v9:
> - Separate DMA IRQ setting and wait_completion from DMA fifo transfer
>   function to make dma_status_poll be possible(Which I will implement
>   in u-boot)
> - Add SFC Kconfig detail comment
>
> Changes in v8:
> - Fix indent 4 to 2 in yaml
>
> Changes in v7:
> - Fix up the sclk_sfc parent error in rk3036
> - Unify to "rockchip,sfc" compatible id because all the feature update
>   will have a new IP version, so the driver is used for the SFC IP in
>   all SoCs
> - Change to use node "sfc" to name the SFC pinctrl group
> - Add subnode reg property check
> - Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
> - Limit max_iosize to 32KB
>
> Changes in v6:
> - Add support in device trees for rv1126(Declared in series 5 but not
>   submitted)
> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
>   affect interpretation and has been widely used
> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
> - Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
>   in series 5 but not submitted)
> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
> - Change to use devm_spi_alloc_master and spi_unregister_master
>
> Changes in v5:
> - Add support in device trees for rv1126
> - Support sfc tx_dual, tx_quad
> - Simplify the code, such as remove "rockchip_sfc_register_all"
> - Support SFC ver4 ver5
>
> Changes in v4:
> - Changing patch back to an "RFC". An engineer from Rockchip
>   reached out to me to let me know they are working on this patch for
>   upstream, I am submitting this v4 for the community to see however
>   I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
>   soon and these are the ones we should pursue for mainlining. Jon's
>   patch series should include support for more hardware than this
>   series.
> - Clean up documentation more and ensure it is correct per
>   make dt_binding_check.
> - Add support in device trees for rk3036, rk3308, and rv1108.
> - Add ahb clock (hclk_sfc) support for rk3036.
> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
> - Change IRQ code to only mark IRQ as handled if it handles the
>   specific IRQ (DMA transfer finish) it is supposed to handle.
>
> Changes in v3:
> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
> - Changed the compatible string from rockchip,sfc to
>   rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
>   driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
>   RV1108 SoCs, and possibly more. However, I am currently only able
>   to test this on a PX30 (an RK3326). The technical reference manuals
>   appear to list the same registers for each device.
> - Corrected devicetree documentation for formatting and to note these
>   changes.
> - Replaced the maintainer with Heiko Stuebner and myself, as we will
>   take ownership of this going forward.
> - Noted that the device (per the reference manual) supports 4 CS, but
>   I am only able to test a single CS (CS 0).
> - Reordered patches to comply with upstream rules.
>
> Changes in v2:
> - Reimplemented driver using spi-mem subsystem.
> - Removed power management code as I couldn't get it working properly.
> - Added device tree bindings for Odroid Go Advance.
>
> Changes in v1:
> hanges made in this new series versus the v8 of the old series:
> - Added function to read spi-rx-bus-width from device tree, in the
>   event that the SPI chip supports 4x mode but only has 2 pins
>   wired (such as the Odroid Go Advance).
> - Changed device tree documentation from txt to yaml format.
> - Made "reset" message a dev_dbg from a dev_info.
> - Changed read and write fifo functions to remove redundant checks.
> - Changed the write and read from relaxed to non-relaxed when
>   starting the DMA transfer or reading the DMA IRQ.
> - Changed from dma_coerce_mask_and_coherent to just
>   dma_set_mask_and_coherent.
> - Changed name of get_if_type to rockchip_sfc_get_if_type.
>
> Chris Morgan (6):
>   dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash
>     controller
>   spi: rockchip-sfc: add rockchip serial flash controller
>   arm64: dts: rockchip: Add SFC to PX30
>   arm: dts: rockchip: Add SFC to RV1108
>   arm64: dts: rockchip: Add SFC to RK3308
>   arm64: dts: rockchip: Enable SFC for Odroid Go Advance
>
>  .../devicetree/bindings/spi/rockchip-sfc.yaml |  91 +++
>  arch/arm/boot/dts/rv1108.dtsi                 |  37 +
>  arch/arm64/boot/dts/rockchip/px30.dtsi        |  38 +
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  37 +
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  16 +
>  drivers/spi/Kconfig                           |  12 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-rockchip-sfc.c                | 694 ++++++++++++++++++
>  8 files changed, 926 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>  create mode 100644 drivers/spi/spi-rockchip-sfc.c
>
> --
> 2.17.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
