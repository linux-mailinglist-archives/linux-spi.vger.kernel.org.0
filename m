Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF853BE609
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGGJ7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 05:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhGGJ7e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Jul 2021 05:59:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A95761C82;
        Wed,  7 Jul 2021 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625651814;
        bh=MgHK8i+XwerqozJH4So+BwBqjS+MtNkDWeGvwKYsjps=;
        h=Subject:From:Date:To:From;
        b=EoHBsOGK+3b2b3uXavfb3getMiymNv0MDb/MG7kIKagm051T4Fh3kIBQpFoqRF6FP
         X1/GO9CwiZPBs++xg0W6ZUxsHVqdZK9fMGLU2JuVLzYUXJB1HajIlQgvWCea3dBoi4
         KmPV+ObOq3KHcT36cjmJIsIFYBm30F9y4RUsezzb5rU0GgvoCchFZgU93alJxTTYJ3
         w6KiT8ZFWqtk2Hki3VAj/9ZVYotZPIlS2vZXYOMOnh6BNvQ9me+V26YrwuOLw/mmne
         XUrl08mcc/hU6bZrWW0O2zhXnGdgg/0SL8HnsU2HSw3af8cHhLQ2RylBFD3YujThZb
         igmHDqp5J6M4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 04681609AD;
        Wed,  7 Jul 2021 09:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162565181401.23005.5393764581908635303.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 07 Jul 2021 09:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] Add Rockchip SFC(serial flash controller) support (2021-07-07T09:08:01)
  Superseding: [v10] Add Rockchip SFC(serial flash controller) support (2021-06-30T13:46:55):
    [v10,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v10,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [v10,03/10] arm64: dts: rockchip: Add SFC to PX30
    [v10,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [v10,05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
    [v10,06/10] clk: rockchip: Add support for hclk_sfc on rk3036
    [v10,07/10] arm: dts: rockchip: Add SFC to RK3036
    [v10,08/10] arm: dts: rockchip: Add SFC to RV1108
    [v10,09/10] arm64: dts: rockchip: Add SFC to RK3308
    [v10,10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
  Superseding: [v11] Add Rockchip SFC(serial flash controller) support (2021-07-07T09:00:20):
    [v11,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v11,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [v11,03/10] arm64: dts: rockchip: Add SFC to PX30
    [v11,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [v11,05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
    [v11,06/10] clk: rockchip: Add support for hclk_sfc on rk3036
    [v11,07/10] arm: dts: rockchip: Add SFC to RK3036
    [v11,08/10] arm: dts: rockchip: Add SFC to RV1108
    [v11,09/10] arm64: dts: rockchip: Add SFC to RK3308
    [v11,10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

