Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00921E7E82
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2NUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 09:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgE2NUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 09:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590758419;
        bh=UnULZ0qca8/7ColomoTALe+PNfVxyYxNcfBwhXciPGU=;
        h=Subject:From:Date:To:From;
        b=sJmbrtWItDhTtzzXgvB76RUNXZJ077NwJRF+vgW9vRoEq1DuIfNjHUJrhpGFfKmrF
         h7YQ0cDCvd9TbvbbHoUJRfQOVLBc2VGTZu0ldG2lMovglrkFh87jcrut/Xmbr0qTd2
         9rIgmeIRUxxqkKbtQ6BFZB7fTVVHdRdyOqHma5ms=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159075841913.30977.3438128059806660119.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 29 May 2020 13:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: dw: Add generic DW DMA controller support (2020-05-29T13:11:53)
  Superseding: [v5] spi: dw: Add generic DW DMA controller support (2020-05-29T03:58:59):
    [v5,01/16] spi: dw: Set xfer effective_speed_hz
    [v5,02/16] spi: dw: Return any value retrieved from the dma_transfer callback
    [v5,03/16] spi: dw: Locally wait for the DMA transactions completion
    [v5,04/16] spi: dw: Add SPI Tx-done wait method to DMA-based transfer
    [v5,05/16] spi: dw: Add SPI Rx-done wait method to DMA-based transfer
    [v5,06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
    [v5,07/16] spi: dw: Use DMA max burst to set the request thresholds
    [v5,08/16] spi: dw: Fix Rx-only DMA transfers
    [v5,09/16] spi: dw: Add core suffix to the DW APB SSI core source file
    [v5,10/16] spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
    [v5,11/16] spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
    [v5,12/16] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
    [v5,13/16] spi: dw: Cleanup generic DW DMA code namings
    [v5,14/16] spi: dw: Add DMA support to the DW SPI MMIO driver
    [v5,15/16] spi: dw: Use regset32 DebugFS method to create regdump file
    [v5,16/16] dt-bindings: spi: Convert DW SPI binding to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
