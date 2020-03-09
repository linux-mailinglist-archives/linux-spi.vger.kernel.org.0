Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F817EACA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCIVIp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53932 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVIp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id g134so1070268wme.3;
        Mon, 09 Mar 2020 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+kMv15yJUTEdNPrEZ0z7ORWq3Tt1uXx0pRgX3Sxz6MY=;
        b=jfRwWnu0XJu4lBt57XtZvLsh3KSPGbukCDMT//jHqaa2rhkmArh/mxjA2HP1RR76LW
         lAayDslY1iBBJGOOvXPL/0rjP1epF3rdC/zgyxVh4tqGjvt9Sm0PbH4vtM0Ip0qsoH8I
         reCHYam7ryG+dZkD76WVLZ0aDG1ckt25u9YsIK65fN6qjmyWr9sdr+G5XHzuNx6L7EFT
         w4DyETuQvZ4C1m0FmVRytoecUz2ef3bP53nBqyxJd7xmm+5zu11MS9d0XyhRYeWCIBGG
         ZNFvDuxHkJaTvULHZib1bo4wJGv7RPKGhacUvlzCmDM+UemM/hH5ynejst+gC2/hyxIg
         BLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+kMv15yJUTEdNPrEZ0z7ORWq3Tt1uXx0pRgX3Sxz6MY=;
        b=BTweVPK84qCu50A7PhMPenu7ahsPZbh3n38VgYHktUEzwhM/+48I60H2gWZO3iEH2F
         cUlSuwW/bAteKPTZy0E8fwAZZbgTv2L7idH8Aq0vm7J7MYOpuPVxZ1wpETcw2nPGGMbr
         f/+ovMNPHhyiDFgbvaTxssv/eLqRK/uLcTw3vwnAWnaAwkSkYcOMLoX1fRrX0H2FShSI
         RCg2fZSBGPtNxkk0pgG9SXAhTlel49fJ3TOGnCG2VvfgVY9X4zDoaUKlQNrdmFOBwETz
         R4+j8TwdcRiRHPUOfI7BE+5RY+euD7a0aaljC2dHVGqm9s54A+YRo/lvgG9wNP+mBp20
         oFKA==
X-Gm-Message-State: ANhLgQ2tjbnMPdlkBH8hLUKAUX2iI47Ce8N6AI2xPJJ2HrcA6j8SPfB6
        DdcVWVug7YoktqTIpAfthB8vkdcVPAM=
X-Google-Smtp-Source: ADFU+vuKHbngmBiwEfQY4TReuY49PKt2j7g7NspKCa21VTD882ngCnQipd4A6DaTIWLvjKT+IMUMLw==
X-Received: by 2002:a1c:a345:: with SMTP id m66mr1153698wme.114.1583788122973;
        Mon, 09 Mar 2020 14:08:42 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:42 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 0/6] NXP DSPI bugfixes and support for LS1028A
Date:   Mon,  9 Mar 2020 23:07:49 +0200
Message-Id: <20200309210755.6759-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (6):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 ++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
 drivers/spi/spi-fsl-dspi.c                    | 50 +++++++++++++++----
 3 files changed, 60 insertions(+), 10 deletions(-)

-- 
2.17.1

