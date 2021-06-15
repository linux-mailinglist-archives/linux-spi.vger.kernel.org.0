Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359AF3A7575
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhFOD6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 23:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhFOD6u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 23:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E683760FEE;
        Tue, 15 Jun 2021 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623729406;
        bh=ChmxcuHm4rqcigwdoaWdaefLPl9FEhRKVZ1PQP6a0GY=;
        h=Subject:From:Date:To:From;
        b=md1fOxu05pRhfTlHwyDHylKoXLTHSHRmN25E+kVQYLsOf026EBJ+FkyUohheUXXWH
         o+p53dySEL7Zi8SjqfbVgkkU1ZaNFCR+pjGbO8sqod0CuaPnKZSTYRMvyXrWcMPr8O
         fpWjCjnDoW5VKPaoBvgQ7G0C+8KUnj64ahxQ7wIVS7IE//gNiEeuxFetpbMyw9D/D4
         V0PZhhpbNuahCB/b3bext/tTTSzjUU+byHmyKdtujTklGJDJ25m2Sagi+6PWKqPWM2
         5YZMXUhI32rMhc7QvdUFxf5Tok0HdkRreUoikbMJNkZ3AzmI9EaHhAAZRGebIf4YdE
         ycZjodXrlIlxA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D8246609AF;
        Tue, 15 Jun 2021 03:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162372940687.16349.6154321595879443381.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 15 Jun 2021 03:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] Support ROCKCHIP SPI new feature (2021-06-15T03:32:08)
  Superseding: [v6] Support ROCKCHIP SPI new feature (2021-06-07T11:18:31):
    [v6,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v6,2/6] spi: rockchip: add compatible string for rv1126
    [v6,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v6,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v6,5/6] spi: rockchip: Support cs-gpio
    [v6,6/6] spi: rockchip: Support SPI_CS_HIGH
  Superseding: [v7] Support ROCKCHIP SPI new feature (2021-06-15T03:26:15):
    [v7,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v7,2/6] spi: rockchip: add compatible string for rv1126
    [v7,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v7,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v7,5/6] spi: rockchip: Support cs-gpio
    [v7,6/6] spi: rockchip: Support SPI_CS_HIGH


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

