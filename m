Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56F01856C5
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCOB3v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:29:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33917 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCOB3v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:29:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id x3so10618607wmj.1;
        Sat, 14 Mar 2020 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MdAMJmGRrUWNR3TnrWQJWlEsL/rPdcDMZT589VL4k7k=;
        b=PolnriIplP1QDNROgQ1dylop9To27slCK5uqrKfKdBbekoCNFT/OLobU7dG3cKboYB
         MU//eTuoUI7T5i6B7tydGtvTtdwVEeeBUH/B16G1i4RoBfv85xUuFVKcWLI8vRHOqfdU
         a867e7aScshL4JXEnVY4fjZMn6Ahnmk8Y9FMgiYOf58dR0IurMsoeDR/xAC1S4Kw+Z9m
         xpxFpOAQiXatccTeSP5z1XJcQ0HC9wYS8RDfsP0nNw5hukMh/DxuixTkfAjF4Ra0Ph5T
         rM83BdLg9zVYPe04jdDDFKTmxclPcGE9Y1u3zmdosgo8AfsqTATZB3Yn2YJgphZ4c7/1
         0kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MdAMJmGRrUWNR3TnrWQJWlEsL/rPdcDMZT589VL4k7k=;
        b=cnlPkWcwA6A1V5ePFLa15CkIgjrseAFNaj+bgRdQBVp68a2xKK5tHBAs4XLCsCtHqC
         NWxkBoSimXeqqEYGXIsXeamnYlkoEG8DG6M2Xlfx9L3nbbqlx9+YYuDrmrIu99jt4WHu
         oftBZM94er3EhalptzBnsvIr88fdn0fnz5NZeyVFKIFU++PehGoUiTWh1Vidbr/4uxnY
         J+fMM3iIbBzxICRwo/EeKSpE0T/et+fYRg34zaNJuyuoGaOhw6HBQ5BEiuusoRYqQTPj
         ezuDObwJry+ijseMW31u/t18wUvdhLvdXcNEdt0U9iEOmlErdhfxAvaHuh5YPlsKvZw5
         0oTQ==
X-Gm-Message-State: ANhLgQ05UT1khs5JEnfxIYQ4Z7O68GbvYwPxqJ+Xp5/iZuerphxSEmdP
        6S7yWU7hIBd+++npjS0oV2GoOA6Blbk=
X-Google-Smtp-Source: ADFU+vtfdljSeqJJQhrgJp7NKZswNejaixyPKYbgD/BUJCJpyQFZKprGJFjj+IOtZPh/8qFRtbdXMw==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr18285028wmk.101.1584225836482;
        Sat, 14 Mar 2020 15:43:56 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:43:55 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 00/12] NXP DSPI bugfixes and support for LS1028A
Date:   Sun, 15 Mar 2020 00:43:28 +0200
Message-Id: <20200314224340.1544-1-olteanv@gmail.com>
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

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 drivers/spi/spi-fsl-dspi.c                    | 227 +++++++++---------
 3 files changed, 138 insertions(+), 109 deletions(-)

-- 
2.17.1

