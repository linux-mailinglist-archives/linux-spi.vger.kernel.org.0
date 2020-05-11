Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA51CD57D
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEKJkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 05:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgEKJkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 05:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589190017;
        bh=ajejly8Bc1PRxUAB+SYp5t2s7yYVLVHtAgQVoDaEkug=;
        h=Subject:From:Date:To:From;
        b=Yr6ulJveK95R9rAAMt3c07YgUSNj8M91iv6Rir22x5i6Gh1mP58+br3I2RNQ1pgYW
         WsJI/G1Vwf6iI0xCag9ftf4oGUPVtMRtSsvHJ7A6V3sbKt2Qzlp/3AFLSBe7VYn90/
         kUnvdLInX557pbvgBcgNAYWUM+JHj2+U9qQO2dgY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158919001743.20654.11877090903689634315.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 May 2020 09:40:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] add ecspi ERR009165 for i.mx6/7 soc family (2020-05-11T17:32:23)
  Superseding: [v7] add ecspi ERR009165 for i.mx6/7 soc family (2020-03-11T16:36:23):
    [v7,01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v7,02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v7,03/13] Revert "dmaengine: imx-sdma: fix context cache"
    [v7,04/13] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v7,05/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [v7,06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v7,07/13] spi: imx: fix ERR009165
    [v7,08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v7,09/13] spi: imx: add new i.mx6ul compatible name in binding doc
    [v7,10/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v7,11/13] dma: imx-sdma: add i.mx6ul compatible name
    [v7,12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v7,13/13] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
