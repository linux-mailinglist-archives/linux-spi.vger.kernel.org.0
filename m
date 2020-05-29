Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143C1E7483
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgE2EVD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgE2EU0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 00:20:26 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590726021;
        bh=1ScgQflyD0YBwK3kfp27yQcGKMoYYSsSkleWWkNyaqA=;
        h=Subject:From:Date:To:From;
        b=kDFbCOZeXXZJ/u7c48JsHliYxVp7ZWMBVnkVjLg1jZwZHj20MSwEakoUV4m3ThsLv
         6DcSz62whCQbjc9i37IW0fxsRQpEhKFCQrSOJ3zPKeUo9151/XS5UlTByF2LbMvhFa
         DtTp3AhbgHawwPsblUHgrMv7rBhOqL26V9QI7N8U=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159072602135.10228.5026713577643037478.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 29 May 2020 04:20:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: dw: Add generic DW DMA controller support (2020-05-29T03:58:59)
  Superseding: [v1] spi: dw: Add generic DW DMA controller support (2020-05-08T13:29:25):
    [01/17] dt-bindings: spi: Convert DW SPI binding to DT schema
    [02/17] dt-bindings: spi: dw: Add DMA properties bindings
    [04/17] spi: dw: Cleanup generic DW DMA code namings
    [06/17] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on DW SPI core
    [08/17] spi: dw: Clear DMAC register when done or stopped
    [09/17] spi: dw: Enable interrupts in accordance with DMA xfer mode
    [10/17] spi: dw: Parameterize the DMA Rx/Tx burst length
    [12/17] spi: dw: Fix dma_slave_config used partly uninitialized
    [13/17] spi: dw: Initialize paddr in DW SPI MMIO private data
  Superseding: [v2] spi: dw: Add generic DW DMA controller support (2020-05-15T10:47:40):
    [v2,01/19] dt-bindings: spi: dw: Add Tx/Rx DMA properties
    [v2,03/19] spi: dw: Clear DMAC register when done or stopped
    [v2,05/19] spi: dw: Enable interrupts in accordance with DMA xfer mode
    [v2,09/19] spi: dw: Parameterize the DMA Rx/Tx burst length
    [v2,10/19] spi: dw: Use DMA max burst to set the request thresholds
    [v2,11/19] spi: dw: Initialize paddr in DW SPI MMIO private data
    [v2,14/19] spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
    [v2,15/19] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
    [v2,17/19] spi: dw: Add DMA support to the DW SPI MMIO driver
    [v2,19/19] dt-bindings: spi: Convert DW SPI binding to DT schema
  Superseding: [v3] spi: dw: Add generic DW DMA controller support (2020-05-21T01:21:50):
    [v3,01/16] spi: dw: Add Tx/Rx finish wait methods to the MID DMA
    [v3,02/16] spi: dw: Enable interrupts in accordance with DMA xfer mode
    [v3,03/16] spi: dw: Discard static DW DMA slave structures
    [v3,06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
    [v3,07/16] spi: dw: Use DMA max burst to set the request thresholds
    [v3,11/16] spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
    [v3,12/16] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
    [v3,14/16] spi: dw: Add DMA support to the DW SPI MMIO driver
    [v3,16/16] dt-bindings: spi: Convert DW SPI binding to DT schema
  Superseding: [v4] spi: dw: Add generic DW DMA controller support (2020-05-22T00:07:51):
    [v4,02/16] spi: dw: Enable interrupts in accordance with DMA xfer mode
    [v4,04/16] spi: dw: Discard unused void priv pointer
    [v4,06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
    [v4,07/16] spi: dw: Use DMA max burst to set the request thresholds
    [v4,11/16] spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
    [v4,12/16] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
    [v4,14/16] spi: dw: Add DMA support to the DW SPI MMIO driver
    [v4,16/16] dt-bindings: spi: Convert DW SPI binding to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
