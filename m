Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845A51E3AC4
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbgE0HkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387570AbgE0HkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 03:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590565217;
        bh=OjoDkGaGPzw1wn1zOmsriGtzUrahTuzZ100yKB5uXU8=;
        h=Subject:From:Date:To:From;
        b=Y+8JQiEgir9Rl3ZWxSbm6Esszitq5C/asxfDHPvtZX3Tzq2/ctVfeXbQhzof1WDSF
         bQuqkNg0AyQnCzfv3l0SdDjLzdmLHjrA8JQlxI4+Wri2CAA/ETQ/MPnxvTd3qhJN59
         +IFh8vg1Ogx5YiuUiCnScqQVpJOUm5t7DMayTLNg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159056521702.20802.2167859173884250219.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 27 May 2020 07:40:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Enable ili9341 and l3gd20 on stm32f429-disco (2020-05-27T07:27:24)
  Superseding: [v5] Enable ili9341 and l3gd20 on stm32f429-disco (2020-05-25T03:45:42):
    [v5,1/8] ARM: dts: stm32: Add dma config for spi5
    [v5,2/8] ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
    [v5,3/8] ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board
    [v5,4/8] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
    [v5,5/8] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate, fix duplicated ltdc clock register to 'clk_core' case ltdc's clock turn off by clk_disable_unused()
    [v5,6/8] drm/panel: Add ilitek ili9341 panel driver
    [v5,7/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
    [v5,8/8] spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't be coexit with 'SPI_3WIRE' mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
