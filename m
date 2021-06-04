Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31839BB74
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFDPM4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPM4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:12:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557EC061766
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 08:11:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9414303otg.2
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppRRLB38UTuWhGEhKC3SY9qyf2rsvmW+MM1dUDebls0=;
        b=hOgna6zkVU4wXH8jevecj0q5+QxsEnJtw9WkBZHLVhAkxPBoZI1j49RRi5V1e2IcnR
         yNAeMKRLRa8Aq6RiNPPMJB3C2IsVWjkNS6d3VM9ErYAnX+OMkaYgB+tHKF99//Exb4K2
         GN6iCsXSAwU0W1t4f5iwIHsKdnff28EU/ZjhPpD5VPZ23dyRWz2AaTRP7tQWN4VY+uCs
         6sSGTFhq4LXjwuhWzCXhC1xLPQ6EvAP7NuzxWKFD8ED1PFdnhrdsciIHKsQKFw0R6Onv
         xXGyRaaqeO9SYmznskY7P+B0TvsaNvHyFv9jU3VTB0TpF4ZM+cAfbLD/p3+HPQ/9BzYW
         X92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppRRLB38UTuWhGEhKC3SY9qyf2rsvmW+MM1dUDebls0=;
        b=Fcs7MVknB00zvAneK7lyH9cxxjFbY+cQiCQoDyRQdmQ7Kf6brZWmkK8/NUPIne8x1o
         3mZ2wA6m6xoNWbRIUqGGxPcW4Xe9MbEeEheRKPd1wjqIGZSWzfBtwbNmcl+UjpaiS1/G
         D4zv3pBFsyPv0Han/1MR1d/p0peCNUatr8G3RPX2RTsD8jpweaSgp57IecTiOrqM9NpY
         vlwkDPU/9h31aIjGvPSRmZDduSg0aN1tA6RHZly2HIQLKVKLYoHF2iiqBrJ9fJGoG+14
         yKZYYrdld4QA7eRhRfXnA7faA2RQzI8whqKo/LekI1GUOq69+87Q5U1++iKPl3E7Gk5g
         ifBA==
X-Gm-Message-State: AOAM531wIOJRa+INvDYxE0OCZ02H8sooOvRtjMJJhuzbgolTwH6Dj7Aq
        UFDAPP5/05hzG5UBpQ6yEbFndaIuPds=
X-Google-Smtp-Source: ABdhPJz01kpqvBNgZxfHoPu+Z0Ul/ll7ydKxV2Tuebpp5JjQPpb3Nu1amkxRwSQaIRPqMlgM6SRnmw==
X-Received: by 2002:a9d:6457:: with SMTP id m23mr4036429otl.11.1622819468676;
        Fri, 04 Jun 2021 08:11:08 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:08 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 0/8] Add Rockchip SFC(serial flash controller) support
Date:   Fri,  4 Jun 2021 10:10:47 -0500
Message-Id: <20210604151055.28636-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

I'm trying to revive an abandoned patch series for the Rockchip serial
flash controller (SFC) found on the Rockchip PX30 SOC, as well as other
SOCs by Rockchip. I'm picking this up from version 8 of the patch
series located from here:

http://patchwork.ozlabs.org/project/linux-mtd/cover/1518091958-3672-1-git-send-email-andy.yan@rock-chips.com/

Changes made in v4:
 - Changing patch back to an "RFC". An engineer from Rockchip
   reached out to me to let me know they are working on this patch for
   upstream, I am submitting this v4 for the community to see however
   I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
   soon and these are the ones we should pursue for mainlining. Jon's
   patch series should include support for more hardware than this
   series.
 - Clean up documentation more and ensure it is correct per
   make dt_binding_check.
 - Add support in device trees for rk3036, rk3308, and rv1108.
 - Add ahb clock (hclk_sfc) support for rk3036.
 - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
 - Change IRQ code to only mark IRQ as handled if it handles the
   specific IRQ (DMA transfer finish) it is supposed to handle.

Changes made in v3:
 - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
 - Changed the compatible string from rockchip,sfc to
   rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
   driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
   RV1108 SoCs, and possibly more. However, I am currently only able
   to test this on a PX30 (an RK3326). The technical reference manuals
   appear to list the same registers for each device.
 - Corrected devicetree documentation for formatting and to note these
   changes.
 - Replaced the maintainer with Heiko Stuebner and myself, as we will
   take ownership of this going forward.
 - Noted that the device (per the reference manual) supports 4 CS, but
   I am only able to test a single CS (CS 0).
 - Reordered patches to comply with upstream rules.

Changes made in v2:
 - Reimplemented driver using spi-mem subsystem.
 - Removed power management code as I couldn't get it working properly.
 - Added device tree bindings for Odroid Go Advance.

Changes made in this new series versus the v8 of the old series:
 - Added function to read spi-rx-bus-width from device tree, in the
   event that the SPI chip supports 4x mode but only has 2 pins
   wired (such as the Odroid Go Advance).
 - Changed device tree documentation from txt to yaml format.
 - Made "reset" message a dev_dbg from a dev_info.
 - Changed read and write fifo functions to remove redundant checks.
 - Changed the write and read from relaxed to non-relaxed when
   starting the DMA transfer or reading the DMA IRQ.
 - Changed from dma_coerce_mask_and_coherent to just
   dma_set_mask_and_coherent.
 - Changed name of get_if_type to rockchip_sfc_get_if_type.

Chris Morgan (8):
  dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash
    controller
  spi: rockchip-sfc: add rockchip serial flash controller
  arm64: dts: rockchip: Add SFC to PX30
  clk: rockchip: Add support for hclk_sfc on rk3036
  arm: dts: rockchip: Add SFC to RK3036
  arm: dts: rockchip: Add SFC to RV1108
  arm64: dts: rockchip: Add SFC to RK3308
  arm64: dts: rockchip: Enable SFC for Odroid Go Advance

 .../devicetree/bindings/spi/rockchip-sfc.yaml |  85 ++
 arch/arm/boot/dts/rk3036.dtsi                 |  42 +
 arch/arm/boot/dts/rv1108.dtsi                 |  37 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  38 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  37 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  16 +
 drivers/clk/rockchip/clk-rk3036.c             |   2 +-
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rockchip-sfc.c                | 863 ++++++++++++++++++
 include/dt-bindings/clock/rk3036-cru.h        |   1 +
 11 files changed, 1130 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
 create mode 100644 drivers/spi/spi-rockchip-sfc.c

-- 
2.25.1

