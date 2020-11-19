Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4988C2B91FE
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgKSMC5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:02:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54227 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSMC5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605788062; x=1637324062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d+rcDHlcBJuON931nOZ+yql2UbfoPXEQIutZ5zLldMM=;
  b=TDO8FgCo2RnnJJyp0P8GzrHOGTV67Lpo8uiRs+RAhMQRKcUvmPaIp3Pd
   tzmk4Qw1fwKetyYzw76sNQ3J7AuEnnKpd0RlIoFuaHoQc+7n6t4qZb41y
   2GWQf7pGiz5k88AkxmFfkh2PjZb968koQ/IHUSPTAj6iGGbc3/0xSJuSB
   pZYjFAHxcWbk1AZckjqCu12lvKUZ+D7WmwD9jOfqUcJA9c0tWbAdRuJSb
   J+y/LQdRNeBvM11N5zMuuXTLlM6zWnf/tN96uOk/KjgZ8BEqlAnbY71xj
   jeWcJAMcyaHCrx/5+darRorRRwBLvWPfRMZAT9ngrzsxyIXx3jzZmL6gR
   Q==;
IronPort-SDR: VCj9/Hcd4LkEevUvbfYwjpy2o/bOOQZn0OTvGocKL2S0QJL8XiQXHrENHKqcA0WNHidIjXdnIu
 3XmxlxxYlsxnREcpN0HOJofGWX8xcXXTZRVCEfXbT0kTejTiCgDonKI4L1sleOFnMVI6nXc1JY
 GjLYP8evTc9G5FZEaTpwws8w0TALjqTjS8hIRtfDwtc0KC9EG1hpVWgfxLpRihv4AqcR4Jn7st
 Nnzb2UEAAzjZ0qLd8IFuk2cNl+KreETl1BjCpBQHxC4SoCp0VVXUhw/5yF92U9UnkfiZHYoPSp
 DwE=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256574387"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 20:14:22 +0800
IronPort-SDR: NwUi2MRzYiTsLm4o+FPUTAFn19iYul3R0Dc7fbgs6NHniNDXlJ4lsS71JItNIKUpQGNSg5M9HI
 e5vA0UgOYBddi0sEDtkcin24yZFvxVg2MuqMl4CIUM5W5zcNQqGFCAjmiWM3v4hNVRrPzfrmBF
 bCUaQ2q6QjRjKzSFkHUD6o9NuTvQw1hc9OT9tcEdGRKhMU9PS9z3tXTXGwSAq+tKp5SGKTTCuW
 XkaPoLhRjt9j7jsDRzFSD2GGu+zVORZWc0//TZBnRPWMLWqvCjd52s88OuhAjSpBVMu1UIxrOz
 8kfpUtUhwSrZBeI356yv+ZVc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:48:47 -0800
IronPort-SDR: p0qvW1NGlS96v1iQ7fqKsHBr+EZmLnxHjrCwWWueLa/j670bzmpyT6VGpOhNX/z9dl3XCZ7nwt
 uv9kU7WAiJdySp7eP1+DagNq1WyQPsbsORGnOvJvP96gZSBKMMNCWZVB3xnEean+eBDpKI0kN5
 dzGaQqMyIbF+oPHzY7pvF28N+EuGDRe3m8rVCSAPq0M0lqmmlKEy61NbIDEAYQTrNuOlL+77d8
 msJxLPRO5QpTVtlpY0M938CkVVxeGZkgIiRTeT8yKyfoqJAJePOlN0AO45o0MS6mjeafGoh4UD
 PxM=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 04:02:56 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/3] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC
Date:   Thu, 19 Nov 2020 21:02:50 +0900
Message-Id: <20201119120253.390883-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Canaan Kendryte K210 RISC-V SoC includes a DesignWare apb_ssi V4
SPI controller implemented with a maximum data frame size of 32-bits
(SSI_MAX_XFER_SIZE=32 synthesis parameter).

This series of patches adds support for this SoC by adding implementing
changes necessary to support the 32-bits xfer size configuration. This
is done in patch 1.

Patch 2 introduces a workaround for a HW bug on this SoC which triggers
RX FIFO overrun errors when the RX FIFO fills up to its maximum detected
depth of 32. The patch manually reduces the fifo depth to 31.

Patch 3 documents the new compatible string "canaan,k210-spi" used to
identify this SoC.

Damien Le Moal (3):
  spi: dw: Add support for 32-bits max xfer size
  spi: dw: Add support for the Canaan K210 SoC SPI
  dt-bindings: Update Synopsis DW apb ssi bindings

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 +
 drivers/spi/spi-dw-core.c                     | 40 +++++++++++++++----
 drivers/spi/spi-dw-mmio.c                     | 16 ++++++++
 drivers/spi/spi-dw.h                          |  8 ++++
 4 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.28.0

