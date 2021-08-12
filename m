Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08F3EA613
	for <lists+linux-spi@lfdr.de>; Thu, 12 Aug 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhHLN5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Aug 2021 09:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232351AbhHLN5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Aug 2021 09:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 10D0D60EB5;
        Thu, 12 Aug 2021 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628776613;
        bh=KUYbfkZ6eMDONpIJdfjT4ME7mT0TJOcfTQt4JxyRte8=;
        h=Subject:From:Date:To:From;
        b=aSTqYqttIuQROLtB9w1TJM8P0BCKN1t3DVnRmjKFyAOtSJ8JPbWQWWc+OW6IG+Q8o
         iJgd640YVH536MEZDUeJo3Cba9r/9X+M4w5y+CYTVxHklU/7nRzOWYS96AlMQph8HQ
         cc+khzjFJDI+WeXq6y6safc3Czum4u4qnurQ/LOnt5Wg64dPUgJTJT7oNFyxA9uK0G
         7Ae2HRb0gHdoaGRUiCAPGGcFZYKSfwTibpAKWzECgwCg5HU8PjQtvtjBY0iAbx5fMi
         lJ0yHWmLR+QNp3ESRSsr1b7SGqRMq7UI5daJHL3W7TOcpYaRYznn/OaocihPcAtnLE
         Mtineuv6HuFeA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 07E3E60A54;
        Thu, 12 Aug 2021 13:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162877661302.21518.10393151338245451364.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 12 Aug 2021 13:56:53 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v13] Add Rockchip SFC(serial flash controller) support (2021-08-12T13:45:40)
  Superseding: [v11] Add Rockchip SFC(serial flash controller) support (2021-07-07T09:08:01):
    [RFC,v11,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [RFC,v11,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [RFC,v11,03/10] arm64: dts: rockchip: Add SFC to PX30
    [RFC,v11,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [RFC,v11,05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
    [RFC,v11,06/10] clk: rockchip: Add support for hclk_sfc on rk3036
    [RFC,v11,07/10] arm: dts: rockchip: Add SFC to RK3036
    [RFC,v11,08/10] arm: dts: rockchip: Add SFC to RV1108
    [RFC,v11,09/10] arm64: dts: rockchip: Add SFC to RK3308
    [RFC,v11,10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
  Superseding: [v12] Add Rockchip SFC(serial flash controller) support (2021-07-13T09:44:46):
    [v12,01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v12,02/10] spi: rockchip-sfc: add rockchip serial flash controller
    [v12,03/10] arm64: dts: rockchip: Add SFC to PX30
    [v12,04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

