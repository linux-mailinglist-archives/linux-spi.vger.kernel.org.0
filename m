Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E217FD3A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCJN0m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:26:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56185 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgCJMzw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:55:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so1269978wmi.5;
        Tue, 10 Mar 2020 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ddx48D2gr10nMoG1C61HRni/V10Bu89hCsWOfewS3C4=;
        b=mclrgEFbgjuY+WFqJ+yAnwLTrQAeGXiC0Khzlfy+mgVHM1ed2h7pdu01MundlIfUOz
         lK1bvpqusxVftNGxvuDX8dIDOXjHVEUAr1+UmxkBK0E7cdjtLT09f9juyEOgCPeTGOHf
         dri3R4BLs5m2VACYXYbpduXDXQgMT6RyF1IuKHtrf8s07k/VzpcRttYBlxrS7+0m4Cuc
         0+emoIgUY+Hv9GEup174YOtN+nXnwG0164vMzM8KJi7UraKvZ5FLdiqPQtArsU3I4jbn
         AFyhQro+tSKtFVMPm2Qb8M+V/t8W6TluhBMQ5bgRH5JUjWtmM3q3erHjcumkmQ7ct7GQ
         200A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ddx48D2gr10nMoG1C61HRni/V10Bu89hCsWOfewS3C4=;
        b=kzU7Te13CnI92MbfifeH/92yu0hJ3Zogs3WNPfCwAO14zXHIksyGHc2tt2EXaJwA43
         zqSJWylBwNl/MmTcyw5ABW7aaB89kNuT0HcDYyRXSH2qPaWBliSOKVGQaqzET4+beNtN
         fNw7BKbvtmvVmjATbmg1ZdVAp3cFyApWwVlDWbE+J6EtIfHyNHbDZ5m+yW7K44437taa
         +tmZxgrCQKgcvfUSxEr/3wlx2XRj6RxLb/+0lvZiekc8dnczLkF2q/Jnk2Crfe9SIx66
         OMjHOKcFphHT3JrdtL24zJAzeGNC2rZmGMoET5SRLHK/LjoiGN4aysvN5dOI+XRTwvLW
         A1Uw==
X-Gm-Message-State: ANhLgQ3LYTQ02fT3qGDtxnZfMcqpWvRX6shRTQxnPzhIl3K5JkgGob3W
        B4RHRNgkTK4txMruxz8gay0=
X-Google-Smtp-Source: ADFU+vs/PIuMLTxZwNDZV1kMk1rEY1URgp5tFfXnru+tJtrPQsbTGmlA5/Sp7HQfDtoO2oX3XXcdlw==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr1970418wme.153.1583844950007;
        Tue, 10 Mar 2020 05:55:50 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:49 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date:   Tue, 10 Mar 2020 14:55:35 +0200
Message-Id: <20200310125542.5939-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This series addresses a few issues that were missed during the previous
series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
SoCs other than LS1021A and LS1043A. DMA mode has been completely broken
by that series, and XSPI mode never worked on little-endian controllers.

Then it introduces support for the LS1028A chip, whose compatible has
recently been documented here:

https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/

The device tree for the LS1028A SoC is extended with DMA channels
definition, such that even though the default operating mode is XSPI,
one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
devtype_data structure of the driver and use that instead.

I don't expect the "fixes" patches to reach very far down the stable
pipe, since there has been pretty heavy refactoring in this driver.

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (7):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
 3 files changed, 134 insertions(+), 74 deletions(-)

-- 
2.17.1

