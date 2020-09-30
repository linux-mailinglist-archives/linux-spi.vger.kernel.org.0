Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258EA27F1FD
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgI3S5k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgI3S5k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 14:57:40 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492259;
        bh=RuigJMb5MKiIsroV2IFnKh2SOc5m4VVtz0pT3P/ufY0=;
        h=Subject:From:Date:To:From;
        b=Lc8r+/eoARtyPljC6cy9bwh1tY2IuCWXS2sXnzl7jWdWPaI7BYaWT7ppcRMZLOyxW
         QEdgo6EEZsX+24UF3J4JObphgTQKhqpGBwg2e5o9I9OEfun/9eHR5g3wcguwivOgoh
         Z9dWOsea3MfpgkuwN2zhDapWqgvRm1eHjCgCJ3Os=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160149225936.9864.7965741160127372180.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 30 Sep 2020 18:57:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-09-30T18:55:25)
  Superseding: [v1] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-09-20T11:28:45):
    [01/30] spi: dw: Discard IRQ threshold macro
    [02/30] spi: dw: Use ternary op to init set_cs callback
    [03/30] spi: dw: Initialize n_bytes before the memory barrier
    [04/30] Revert: spi: spi-dw: Add lock protect dw_spi rx/tx to prevent concurrent calls
    [05/30] spi: dw: Clear IRQ status on DW SPI controller reset
    [06/30] spi: dw: Disable all IRQs when controller is unused
    [07/30] spi: dw: Use relaxed IO-methods to access FIFOs
    [08/30] spi: dw: Discard DW SSI chip type storages
    [09/30] spi: dw: Convert CS-override to DW SPI capabilities
    [10/30] spi: dw: Add KeemBay Master capability
    [11/30] spi: dw: Add DWC SSI capability
    [12/30] spi: dw: Detach SPI device specific CR0 config method
    [13/30] spi: dw: Update SPI bus speed in a config function
    [14/30] spi: dw: Simplify the SPI bus speed config procedure
    [15/30] spi: dw: Update Rx sample delay in the config function
    [16/30] spi: dw: Add DW SPI controller config structure
    [17/30] spi: dw: Refactor data IO procedure
    [18/30] spi: dw: Refactor IRQ-based SPI transfer procedure
    [19/30] spi: dw: Perform IRQ setup in a dedicated function
    [20/30] spi: dw: Unmask IRQs after enabling the chip
    [21/30] spi: dw: Discard chip enabling on DMA setup error
    [22/30] spi: dw: De-assert chip-select on reset
    [23/30] spi: dw: Explicitly de-assert CS on SPI transfer completion
    [24/30] spi: dw: Move num-of retries parameter to the header file
    [25/30] spi: dw: Add generic DW SSI status-check method
    [26/30] spi: dw: Add memory operations support
    [27/30] spi: dw: Introduce max mem-ops SPI bus frequency setting
    [28/30] spi: dw: Add poll-based SPI transfers support
    [29/30] dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
    [30/30] spi: dw: Add Baikal-T1 SPI Controller glue driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

