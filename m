Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5C397B02
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFAUMQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAUMO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 16:12:14 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50AC061574
        for <linux-spi@vger.kernel.org>; Tue,  1 Jun 2021 13:10:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso455363otu.7
        for <linux-spi@vger.kernel.org>; Tue, 01 Jun 2021 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVzJbLz4avCQ6iqrDP+6FIaD1/lSBVo1cZUC0xRIGSg=;
        b=MGSQa6HI1+FfVt33IV019bZ9jcReWkaWmALHx9O1efEdzlLjhTkkZr4p8g2hpx/X9f
         MDDJQbFRwlW81g5nu9+s/FnF+EL+7aTgZoXAZYHKR63tdQDDh9VF1Dw2NVo0jDi1J+U9
         8A6M3HHFo1CwU2fDHNq0wJfEbtShF0C9Pwj/TSUbTgSqRp9vwnL+cmi/lVJoGYb3r4yj
         YnV4htVFYCvLKkJR+J5muOPIhG2wRusY7FybrdV5lTsY3cfx1vt3sr+qQEia6XlXkpwP
         Xsb6i8OEHotaM0Zp8P7Vj3sObNdJpw04N9pHYfe7VWBpkBbjmLn0beTXIVJfX+nuxUKa
         /sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVzJbLz4avCQ6iqrDP+6FIaD1/lSBVo1cZUC0xRIGSg=;
        b=mdO4XzBvcNr8Jp06kMe5rs8GMPZcwVbtcRZ0SgQrKbl+yIllli1dwuGYxU+trLRrQZ
         7vNEc+JHFWiqqqN9ESwuskdOLUGVgfRhUDIBmm4zB5U0PRqsENjnjB6YhtLKlydwl5pi
         bLqIj39oPh1ZfJlcMgx1rOUyPvIMqlLXF0GoGeQpvN5u5oURCq6FjqcC6T1lu47drPdg
         h7MNYvaFdUjJXQ27YBdWoaxuF47PCT+i5toEzs9lIK4FSsaGHpwee7p1GKZo1arQ2S/v
         x27E8M4k/8CJ+/HKBvMy1Pn9CcIh/Ay1c86FVRWII8u1iqH8I0XAai7Mzf5U981l+PcG
         v4bg==
X-Gm-Message-State: AOAM532p6r54Wc8+L/+odBeqpSjn4tjWLnNtOSVah380L14D2VMqrTX5
        TqGvtkVJoEyMZHB76kh778ROVdm6+WQ=
X-Google-Smtp-Source: ABdhPJy27nnsH60MFLgfdysVusgNgz+AOH7FfCeHXGCEMhWPeuQy5PQF5oTBspIRGQnxMdGHv/NrGQ==
X-Received: by 2002:a05:6830:838:: with SMTP id t24mr21941698ots.119.1622578229060;
        Tue, 01 Jun 2021 13:10:29 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p25sm468118ood.4.2021.06.01.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:10:28 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 0/4] Add Rockchip SFC(serial flash controller) support
Date:   Tue,  1 Jun 2021 15:10:17 -0500
Message-Id: <20210601201021.4406-1-macroalpha82@gmail.com>
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

Chris Morgan (4):
  dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash
    controller
  spi: rockchip-sfc: add rockchip serial flash controller driver
  arm64: dts: rockchip: Add SFC to PX30
  arm64: dts: rockchip: Enable SFC for Odroid Go Advance

 .../devicetree/bindings/spi/rockchip,sfc.yaml |  87 ++
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  38 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  16 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rockchip-sfc.c                | 861 ++++++++++++++++++
 6 files changed, 1012 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip,sfc.yaml
 create mode 100644 drivers/spi/spi-rockchip-sfc.c

-- 
2.25.1

