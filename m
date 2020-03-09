Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D572017E2CD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCIO4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:56:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51210 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCIO4i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id a132so10280888wme.1;
        Mon, 09 Mar 2020 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EE7lvEiAG7C14PkVCMk9l0Wy5jQzPbqsBQS6amZKVCA=;
        b=vJ108Hz1XaAGKgv8VGLzMxri6bt2aM7Twgdn6jUMjw2aJkcE8o8fA99F2DDHsZYrDn
         rY6UjmyBrejKAxZXkJ985sa48Xfo+jp0fS39NhnCAhM7QspJ4O5hoHHq3VweFVLEeHYJ
         zD5Oaa+aD28JWLimjnborf3lmXX22r7Btitaf9QjQsAq9JmKMzbvAoo6qXaqBL5Of9iQ
         KPmMU0lejN4h3feV5OYjJix8clgE9Y3P0NIuWP9TdqjFMNjqyofnlsrZNXNBtU/tpqqJ
         Q2LUt6zvwfaTp6hmcV5upbV+ZZHIxeQLCi1ZdxkCkUrRluRFKhShK3TjeajHwzpnV5sp
         PC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EE7lvEiAG7C14PkVCMk9l0Wy5jQzPbqsBQS6amZKVCA=;
        b=P9S8Ry5UZcFCPhHfJrWLjX9yT38sLzBgiV8ihKhSoqYnX3MxMoFVd04Jy8B29h2yLI
         pwUr0N+ab2dnKog8jhNoooSqpmKr19EFaqc4p80923lU3hVD7IBTvCEPLWdzSMKHbnK1
         iatJHzHbBmuFO6ql8G21OL8WQw3xxZF5ndIhUkXRBhnjzx3JTGTTZ2eeFzNc7cAxylc2
         wAkkPkSUQGDiWtyo++ktdJOVRG5m+RO54uETL8o+wFsPAG5yOi0UGxwlb7F1R/UazeqF
         dTDNdEMwYN1Vv1cQCSHeeAD9cj4GMFfP6BNG6OdNuLtGN1202y+8h9M1IriGbno0gmJf
         A0nQ==
X-Gm-Message-State: ANhLgQ1rlkoMnJ0nNjHM+kWMR7/fVh1iP3E5G/qJ9vMnYdDDLyr/o893
        S1Ebe72+OylfNhHBR0k4/oc=
X-Google-Smtp-Source: ADFU+vuIcp4tUkeUBqFI3ifCMpSrEEeaioXn+XMby+pwukK2buFzSgc/j7BiGNz6APMkwbbRDtG06g==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr20109965wmk.19.1583765796955;
        Mon, 09 Mar 2020 07:56:36 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:35 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 0/6] NXP DSPI bugfixes and support for LS1028A
Date:   Mon,  9 Mar 2020 16:56:18 +0200
Message-Id: <20200309145624.10026-1-olteanv@gmail.com>
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

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (6):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 +++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
 drivers/spi/spi-fsl-dspi.c                    | 54 +++++++++++++++----
 3 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.17.1

