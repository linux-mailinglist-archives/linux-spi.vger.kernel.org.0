Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA52D8280
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 00:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436947AbgLKW57 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 17:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394011AbgLKW5n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 17:57:43 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607727420;
        bh=99u6RP6VZ5Md29t6O0rMCUiv7T1/90ETvH2QX/K494Q=;
        h=Subject:From:Date:To:From;
        b=Wd9U3kPTqdy5P4NWhZx30N8y7q2g8P/bgOwFYI44mwq01Rt84yl3AKyZD26rG2V6N
         2pevFkCq2cCIYbOd7Lcv5aZSLmVy6gacJE5WuoOsYRQNNysYATGqEPO8fEHe7EmX9n
         u/wsoL7heA8erxB/xSs3+zMJraW3MhH5NGpbXtkdlmW7SmyWTh/RtRDKguZzEK93mW
         LmSDn3ozOpo3Jgicxf2yi17AWj7VxOAuZEc6cBtQQ4psiI1hELTCEnP+W/JeakPyd9
         eqTeY8ik3C60hfg7DKGo++Z4vWsyx3GgS/tKIevwpB6++fDwvrH/lQN0auZrznQL+C
         KcMBTL1Km+/gA==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160772742068.19058.3871630177138759204.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Dec 2020 22:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add Tegra Quad SPI driver (2020-12-11T21:15:55)
  Superseding: [v2] Add Tegra Quad SPI driver (2020-12-11T17:01:17):
    [v2,1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
    [v2,2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
    [v2,3/9] MAINTAINERS: Add Tegra QSPI driver section
    [v2,4/9] spi: tegra210-quad: Add support for Tegra210 QSPI controller
    [v2,5/9] spi: spi-mem: Allow masters to transfer dummy cycles directly by hardware
    [v2,6/9] spi: tegra210-quad: Add support for hardware dummy cycles
    [v2,7/9] arm64: tegra: Enable QSPI on Jetson Nano
    [v2,8/9] arm64: tegra: Add QSPI nodes on Tegra194
    [v2,9/9] arm64: tegra: Enable QSPI on Jetson Xavier NX


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

