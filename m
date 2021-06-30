Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A63B8485
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhF3OAc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 10:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236262AbhF3N7Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 09:59:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DAA4361433;
        Wed, 30 Jun 2021 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625061407;
        bh=7OPZAsLCSrhXrYuTUJtZKD7zDkzdo9ghsTOFO3Ia6Rs=;
        h=Subject:From:Date:To:From;
        b=fq4H764I1JrP55v+E+hmGHYi5cOZdrxbllPIV1+yED9urZCBakYzb8w+XojnZj6Mv
         QjgYr4/6m5kfOnxowUpY6hPk5ssutnNQKoMcoPo2Kk2jZd9n3rbE+7M8TIrM/GkZbr
         wp1ezs1g6Zxln8hBpVIc7z+BoSIyhuJe/Q13rvM2raBnaEOUrj0jVSvSvcI65MJ22j
         Sq+2+Z+hXN6T4aL651ELX25/p1pkYKkphIK7kFAukbTG+WPwTDHIqUhgxUxWCQqSNy
         BmpNCYeCo8yRmbAeqXHL5jwkvKL5FwL6TuQ7EF3EukHEBbGdgR4yWnBzghdrRS9eCS
         HZc/B5wCC/c/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CDC95609E4;
        Wed, 30 Jun 2021 13:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162506140783.29446.11861849722769577739.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 30 Jun 2021 13:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] Add Rockchip SFC(serial flash controller) support (2021-06-30T13:46:55)
  Superseding: [v9] Add Rockchip SFC(serial flash controller) support (2021-06-25T08:39:50):
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

