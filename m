Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF41D39EC6B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 04:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFHC6h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 22:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFHC6h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Jun 2021 22:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 64A2060FE8;
        Tue,  8 Jun 2021 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623121005;
        bh=FLaWnlfHsbZWYcGXLaLYqTbtGD1bvPqDfIk0uCq0gOw=;
        h=Subject:From:Date:To:From;
        b=B3uyzbf8VdxD1yB526AgrsqGuvdan5x94gZtfwiMeYmieoGotQcOCjJa05aJT5JPh
         +1ymU3bwVFci7qhMCnjQVs+egtVKADgAT7l9eOdIe74TxYoCxHVGCOZvj/2sNUKVe8
         kye1hJOm2JEwxaZqB5VifnoOTcnLJiuWK6uBoPlsYMSSwiaJNLfs9QYv6MxnWwzgQP
         wEe6ruvFnQaESCo1fYtMsOMNp+4Ar38TjH4e+gaLXVxz0pFHINCJj/iFoQEl1QuLEe
         FuQMHOXHWxR63+aZnoGtwRUT3XJjE/+83sU6zXUEMo8iPdavCNcS5RvRKtQTSND6AX
         xtsXO+1E+WXzw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 56799609B6;
        Tue,  8 Jun 2021 02:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162312100534.19522.5046818501577568344.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Jun 2021 02:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Add Rockchip SFC(serial flash controller) support (2021-06-08T02:26:39)
  Superseding: [v5] Add Rockchip SFC(serial flash controller) support (2021-06-07T12:42:58):
    [v5,1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v5,2/8] spi: rockchip-sfc: add rockchip serial flash controller
    [v5,3/8] arm64: dts: rockchip: Add SFC to PX30
    [v5,4/8] clk: rockchip: Add support for hclk_sfc on rk3036
    [v5,5/8] arm: dts: rockchip: Add SFC to RK3036
    [v5,6/8] arm: dts: rockchip: Add SFC to RV1108
    [v5,7/8] arm64: dts: rockchip: Add SFC to RK3308
    [v5,8/8] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

