Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA69B4081B6
	for <lists+linux-spi@lfdr.de>; Sun, 12 Sep 2021 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhILU6G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Sep 2021 16:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhILU6F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 12 Sep 2021 16:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 22FA860F58;
        Sun, 12 Sep 2021 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631480211;
        bh=o/nPlq5L2V70pg98+BN34NYx4I3HB0I47c5HBmhhuUA=;
        h=Subject:From:Date:To:From;
        b=imzxBh52vEJfNvRI0d7CWgjHvqBJx4pbjQ9aRK6V95ExOVUMyQqss2A8Fi8I/5wEW
         We1ptIFadQ60orCYa9v8RM+vTKKoYvVXj7IN/zoyycZB52JdJercf9dNb+Iw/PW0FP
         lZ5JjlqKnyefYCrv6H/BM74Kmxpj5ZyNMJ7lCgGG+EOm+y/f9tT6AFqNN4BXQ8F+Vw
         lQTKCO8j4AUCspJXrqiyV2+OQk6e6M8d+KEbpmt2gHIRXDXdxYEkeIQi355Ix03uDK
         7FtHoKYYFPhSuSTwNbJF+Y1fDuUTfMDsgCthKyvxIfvRNCcB5z/YjbljZFUCtERJMQ
         TNOecmnekcD6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1BFA8609ED;
        Sun, 12 Sep 2021 20:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163148021110.12620.4914334277490882746.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 12 Sep 2021 20:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] NVIDIA Tegra power management patches for 5.16 (2021-09-12T20:07:58)
  Superseding: [v8] NVIDIA Tegra power management patches for 5.16 (2021-08-17T01:27:20):
    [v8,01/34] opp: Add dev_pm_opp_sync() helper
    [v8,02/34] soc/tegra: pmc: Disable PMC state syncing
    [v8,03/34] soc/tegra: Don't print error message when OPPs not available
    [v8,04/34] soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
    [v8,05/34] soc/tegra: Use dev_pm_opp_sync()
    [v8,06/34] dt-bindings: clock: tegra-car: Document new tegra-clocks sub-node
    [v8,07/34] clk: tegra: Support runtime PM and power domain
    [v8,08/34] dt-bindings: host1x: Document OPP and power domain properties
    [v8,09/34] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
    [v8,10/34] gpu: host1x: Add host1x_channel_stop()
    [v8,11/34] gpu: host1x: Add runtime PM and OPP support
    [v8,12/34] drm/tegra: dc: Support OPP and SoC core voltage scaling
    [v8,13/34] drm/tegra: hdmi: Add OPP support
    [v8,14/34] drm/tegra: gr2d: Support power management
    [v8,15/34] drm/tegra: gr3d: Support power management
    [v8,16/34] drm/tegra: vic: Support system suspend
    [v8,17/34] usb: chipidea: tegra: Add runtime PM and OPP support
    [v8,18/34] bus: tegra-gmi: Add runtime PM and OPP support
    [v8,19/34] pwm: tegra: Add runtime PM and OPP support
    [v8,20/34] mmc: sdhci-tegra: Add runtime PM and OPP support
    [v8,21/34] mtd: rawnand: tegra: Add runtime PM and OPP support
    [v8,22/34] spi: tegra20-slink: Add OPP support
    [v8,23/34] media: dt: bindings: tegra-vde: Convert to schema
    [v8,24/34] media: dt: bindings: tegra-vde: Document OPP and power domain
    [v8,25/34] media: staging: tegra-vde: Support generic power domain and OPP
    [v8,26/34] soc/tegra: fuse: Add OPP support
    [v8,27/34] soc/tegra: fuse: Reset hardware
    [v8,28/34] soc/tegra: regulators: Prepare for suspend
    [v8,29/34] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
    [v8,30/34] ARM: tegra: Add OPP tables and power domains to Tegra20 device-trees
    [v8,31/34] ARM: tegra: Add OPP tables and power domains to Tegra30 device-trees
    [v8,32/34] ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
    [v8,33/34] ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
    [v8,34/34] ARM: tegra20/30: Disable unused host1x hardware


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

