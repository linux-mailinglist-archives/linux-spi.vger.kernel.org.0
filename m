Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080802E023C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLUV5V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLUV5V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Dec 2020 16:57:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 02BC722C9C;
        Mon, 21 Dec 2020 21:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608587801;
        bh=TmSL6EOnf8PJqB4j5sDll0MRG+WDL33aoRF0LByNDjM=;
        h=Subject:From:Date:To:From;
        b=iWEk2HS7GKpiiVyJOY0vGE8cT+SydN2eX8K894Fmdbt55/7gfOVIHmPGgzrecvXuU
         Xpd6BTAd7egb7TnxTTa1/r+Bc1Qj9p7T5S1+SE/1OurbQnizwxUX+nfWeBv/SNxLyA
         2Yi6mLtq4L5arkLl5rEFHLz7O5GJ9UrH/TeZoyOzms2N39m75boUx49wcFRFAO2wIj
         Dj2nZ7//ovIYC9CZsfEOgALFCHbao3729SIdlhsepkDik5Dhsy5bRoPjmD2NgZP4gK
         ya8lYfe9xEU/xzEXk7wHJHG0pJyu6UbdSuxBrCHI1o5ccvZ0q6/Flb6x2BqbFA1VXY
         QhGFwG4rinahg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id DDB7E60113;
        Mon, 21 Dec 2020 21:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160858780083.1730.13751084748384678965.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Dec 2020 21:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add Tegra Quad SPI driver (2020-12-21T21:17:36)
  Superseding: [v4] Add Tegra Quad SPI driver (2020-12-17T20:28:39):
    [v4,1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
    [v4,2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
    [v4,3/9] MAINTAINERS: Add Tegra Quad SPI driver section
    [v4,4/9] spi: tegra210-quad: Add support for Tegra210 QSPI controller
    [v4,5/9] spi: spi-mem: Mark dummy transfers by setting dummy_data bit
    [v4,6/9] spi: tegra210-quad: Add support for hardware dummy cycles transfer
    [v4,7/9] arm64: tegra: Enable QSPI on Jetson Nano
    [v4,8/9] arm64: tegra: Add QSPI nodes on Tegra194
    [v4,9/9] arm64: tegra: Enable QSPI on Jetson Xavier NX


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

