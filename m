Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E23B3FDC
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFYI7P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 04:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhFYI7P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Jun 2021 04:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 250256141F;
        Fri, 25 Jun 2021 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611415;
        bh=W5oAA+8CY8CJLxIaFG+iqGadEPUMezBHgbQhGO0x8iw=;
        h=Subject:From:Date:To:From;
        b=i4Id5HS6IXrbWPx1gSfjt9/39voLspCLxscdAGPnP5biP74G/9QtzYuje7vFrV535
         ATdE4sz93EXs5n6L0RJr0545CWkNjDqUVUtRAnQgCG+CvHQpeffsbltyYdkK33l1CL
         ntTPdJ1n3vjWhOqQsYwRM36mzYCfZQDP/Apk81omObFJi/9F2mIlHpGgN9xMLteSlp
         CcDCmn3sS+1/6NIR+FAWzhYbGYqID2NBhIiKb7GGFA03DzOvC3dtxCQmHIl5H468HC
         W9L2q8CAb+reycg4gD1teI0yONIbsGdLXaD0GV6PGnvABV1AutI6YVEhc95fnBNwvJ
         ol56h+iJrK8yw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 118D460A3C;
        Fri, 25 Jun 2021 08:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162461141501.31711.2156310925459958333.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 25 Jun 2021 08:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] Add Rockchip SFC(serial flash controller) support (2021-06-25T08:39:50)
  Superseding: [v9] Add Rockchip SFC(serial flash controller) support (2021-06-25T07:16:52):
    [v9,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v9,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [v9,03/10] arm64: dts: rockchip: Add SFC to PX30
    [v9,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [v9,05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
    [v9,06/10] clk: rockchip: Add support for hclk_sfc on rk3036
    [v9,07/10] arm: dts: rockchip: Add SFC to RK3036
    [v9,08/10] arm: dts: rockchip: Add SFC to RV1108
    [v9,09/10] arm64: dts: rockchip: Add SFC to RK3308
    [v9,10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
  Superseding: [v9] Add Rockchip SFC(serial flash controller) support (2021-06-25T08:26:29):
    [RFC,v9,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [RFC,v9,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [RFC,v9,03/10] arm64: dts: rockchip: Add SFC to PX30
    [RFC,v9,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [RFC,v9,05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
    [RFC,v9,06/10] clk: rockchip: Add support for hclk_sfc on rk3036
    [RFC,v9,07/10] arm: dts: rockchip: Add SFC to RK3036
    [RFC,v9,08/10] arm: dts: rockchip: Add SFC to RV1108
    [RFC,v9,09/10] arm64: dts: rockchip: Add SFC to RK3308
    [RFC,v9,10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

