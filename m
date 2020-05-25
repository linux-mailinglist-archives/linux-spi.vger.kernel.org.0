Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571C41E05B6
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 06:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgEYEAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 00:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgEYEAS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 00:00:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590379217;
        bh=LxfIbbg1MoCqbVFU7t9oGAlVbxqW68r/xkjTODgmteA=;
        h=Subject:From:Date:To:From;
        b=E3zXnmmAroyhTHNGUeZTF8io5BVeh9KE95eXBoWu/VYkothzI9tnhuRggXQWQ0GFU
         yLclefNn8kf/VJU3J2QU0MrjK+ZXGzqO3yumeqgJFFGFyQAIQ6OOyl8OzQGWh1dZuO
         8A3cJXzzNTh+ueLRfMMdQAy5Vi8CacI6J6SVKZe8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159037921767.11023.7430012641237446191.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 25 May 2020 04:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Enable ili9341 and l3gd20 on stm32f429-disco (2020-05-25T03:45:42)
  Superseding: [v4] Enable ili9341 and l3gd20 on stm32f429-disco (2020-05-18T11:09:17):
    [v4,1/8] ARM: dts: stm32: Add dma config for spi5
    [v4,2/8] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
    [v4,3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
    [v4,4/8] ARM: dts: stm32: Add pin map for ltdc on stm32f429-disco board
    [v4,5/8] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
    [v4,6/8] ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco board
    [v4,7/8] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate.
    [v4,8/8] drm/panel: Add ilitek ili9341 panel driver
  Superseding: [v5] Enable ili9341 and l3gd20 on stm32f429-disco (2020-05-25T03:40:54):
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
