Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62B3A183D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhFIO6s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 10:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238675AbhFIO6s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 10:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B3640611CC;
        Wed,  9 Jun 2021 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623250613;
        bh=Qf778YamqAJtnkX91YU0TmCTXwNnme7fFusHHkby9QU=;
        h=Subject:From:Date:To:From;
        b=dvL0VcLfBRb1/scuJbuNn1xeve9PqVNTO39lQMI9Wk58W+KwUoJ/H8mY6+kIJNLLv
         tWkJ4bX6fU6UldTTzgjAITKg5l2OVz6JFrsJTZVdhkp7qm2QV2Uj9/Zx2MAqAsxKAr
         /bBnzuIJ5A68i2ISsGk9SU9kpZK7FCVT47BMaN1nw1cJUJFgLk0pxWGEdbShTT/pNU
         RozDJLbLQeuD97hXlzGTY4GHz0myL5xi+SUACze9nOwQgcd1lcVdRIP/gEzft6bMdH
         n0GzmrfzOmrblip5tJJXKUQ4j5UEJWUE6nDc4Ff2S7Wb2b9yOQXeuD3by3+iU7z/Xf
         9E/5m07ssrj4w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A22E960A22;
        Wed,  9 Jun 2021 14:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162325061360.7713.15406931282825226069.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Jun 2021 14:56:53 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add Rockchip SFC(serial flash controller) support (2021-06-09T14:04:07)
  Superseding: [v6] Add Rockchip SFC(serial flash controller) support (2021-06-08T02:26:39):
    [v6,1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v6,2/8] spi: rockchip-sfc: add rockchip serial flash controller
    [v6,3/8] arm64: dts: rockchip: Add SFC to PX30
    [v6,4/8] clk: rockchip: Add support for hclk_sfc on rk3036
    [v6,5/8] arm: dts: rockchip: Add SFC to RK3036
    [v6,6/8] arm: dts: rockchip: Add SFC to RV1108
    [v6,7/8] arm64: dts: rockchip: Add SFC to RK3308
    [v6,8/8] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

