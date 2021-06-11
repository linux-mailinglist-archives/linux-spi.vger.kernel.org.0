Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74633A3C68
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhFKG67 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 02:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKG65 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Jun 2021 02:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 303BE610F8;
        Fri, 11 Jun 2021 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623394620;
        bh=l8n+GZROYDr4X5SqokTfs/kESztpwnG6406z34oUsf0=;
        h=Subject:From:Date:To:From;
        b=diJf4vDeRxvB6tz3LnYtSgMF4prgoZQnPdGUOReGzAtLIEd/AS+XSsQvr9y2uG4Jb
         N4qIgTiIq/8d1TB0ZDZNshm70oaI4yu63kCCuqcENttCCHQIhwFJvGcys+QXUV1Uf7
         rT6w3cFcl0x/S44wEN3sQFcTgjnD8MPgGiumVEpBdPkyCWeIbVr9Fa8sNw+py3ZDGx
         58ZfX/gmMSS5ZZQaIoCoUedNtShv6apbI+mm3cqkO4na1GZpMJk5llgucYlkRRvqVe
         Q9hvCDYXUm1qjIlWVdPtUKeUnVEQhG1AJPa9hYunnisPiSk5VeqKdgvxswp+zb5l0W
         pcqwkbrsxSoQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 252D260A0C;
        Fri, 11 Jun 2021 06:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162339462014.7119.10937930637034163084.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Jun 2021 06:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] Add Rockchip SFC(serial flash controller) support (2021-06-11T06:11:25)
  Superseding: [v7] Add Rockchip SFC(serial flash controller) support (2021-06-09T14:04:07):
    [v7,1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v7,2/9] spi: rockchip-sfc: add rockchip serial flash controller
    [v7,3/9] arm64: dts: rockchip: Add SFC to PX30
    [v7,4/9] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [v7,5/9] clk: rockchip: Add support for hclk_sfc on rk3036
    [v7,6/9] arm: dts: rockchip: Add SFC to RK3036
    [v7,7/9] arm: dts: rockchip: Add SFC to RV1108
    [v7,8/9] arm64: dts: rockchip: Add SFC to RK3308
    [v7,9/9] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

