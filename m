Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34DE1892C1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCRARJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53902 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgCRARJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so1323930wmk.3;
        Tue, 17 Mar 2020 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fa9G6pIxx2NTIh5BkG3oXN/ghLxEgalYJbU5H578aWc=;
        b=G1OdElj0Y+mBwqjWm8GvIJWfTdaN5fR5GGWEY5bndc4HWWiAisXHKpwOqdgE76JfDQ
         5Bc2E4N9rt+tX0hSL0yucaUMyoh1BkzAtDLMbYzF21ABqqx48k2FDUG3oG8W09nEbmE7
         znOWCwjnVRQm3dMNKwuiq+oxOYIjZIeT7AspRgMYfk3OPPsCFDobP1XxwhHC0uCeWjDz
         g62jQs5a+8wOVwHuWinLR/yVHhssJMl4Ux+ic/L0m5ps/Y3Pllnuvf/fgLdyJXIYniIv
         eBSYJNb5TdXpCeQJ3z++GmALr24dPlv7zgx6KrBJ8Sj3OopfcHPn9MUokFzKIbWUw1Cl
         ogDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fa9G6pIxx2NTIh5BkG3oXN/ghLxEgalYJbU5H578aWc=;
        b=QmUriMWzxB8wN60NgCVvLcVv2Lkl53YApWWmqlQPAhxBVvi4PSytWdw4SB4tEPnSi1
         8kUAYSxVwGmjdOTpKhGO9focGmlNQGkWWGWKOPKtalgVnt8utc8bf8avWV/UiX4wy0po
         eXBl6dZr6rloauOQdWLf0nF8mbuz8X0B7YqZnAvBU30Ud5dQRblyZcgloF5uNL5YfWly
         BesglVAnQyn6xidz++2CVIEBbLzceZs3N2n+7EVmBenGZ1cswO5QCY0dv7ZhWsMFi/YC
         EIxM8GoRoP6minK9Nf8nPyP6EoIMenEsph3K+XERiV7gMcNb3AN3/SgdUw88G9NYAByI
         8Abg==
X-Gm-Message-State: ANhLgQ1cnH9mXDATYVZR4JVm1hXq21M3GWbA5g5iM92KXCq1P+MDWzjg
        cgEqyadxoXxfD+sSj6DBijAg4wWdid+oMQ==
X-Google-Smtp-Source: ADFU+vsZqPe2+iAKhvGrnHm0r/RJLSRP73YwTPiKW2X9rUCdlyCgHUf2KcQEUPMIh03bZQDtCyandA==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr1659615wmf.50.1584490626934;
        Tue, 17 Mar 2020 17:17:06 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:06 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A
Date:   Wed, 18 Mar 2020 02:15:51 +0200
Message-Id: <20200318001603.9650-1-olteanv@gmail.com>
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

Compared to earlier v4, the only change is in patch 05/12 to fix a race
condition signaled by Michael Walle here:
https://lkml.org/lkml/2020/3/17/740

I don't expect the "fixes" patches to reach very far down the stable
pipe, since there has been pretty heavy refactoring in this driver.

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (12):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
  spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
  spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
  spi: spi-fsl-dspi: Replace interruptible wait queue with a simple
    completion
  spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA
    mode
  spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code
    path
  spi: spi-fsl-dspi: Move invariant configs out of
    dspi_transfer_one_message
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 +
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 drivers/spi/spi-fsl-dspi.c                    | 324 +++++++++---------
 3 files changed, 182 insertions(+), 162 deletions(-)

-- 
2.17.1

