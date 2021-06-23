Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A813B1E36
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhFWQC1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 12:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhFWQC0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 12:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 35F73611C1;
        Wed, 23 Jun 2021 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464009;
        bh=SjgvgGvoEwf8mdM55ZXmWIeKZJwv2F9gwPx4SGJClaw=;
        h=Subject:From:Date:To:From;
        b=gA+l8jp/G1sIs09Jqrp9aBlVPFQR3qXE9sW7RiOU/8bWS9rKRMi4TBEV5Jba0LgKy
         4m6mVrxmMWtm09Q6ThWvfFyaAM7Q2yCRN6pX4c7+HNvPfnpIKaepAHio+/L8XecnF1
         4IjnMARMIlwpY8MA3R4/2UngbLesB3ha/z4jedUJXmyI9EwY3jrfuOCsxJ14UO9lOf
         zWV35panm8YXGX0yZ3paa9Gtl3bqpAvECWSsuleJhpGunkhWpbFgo3a8AXS6z17uAZ
         fv28GZzkjPhZiksVLYPrcvTDlKpokOn6NRu+UihOIFmqV7FkM4yw9AiZ14VeyRoGSY
         auQF7xxvNS/Kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 20B5E6094F;
        Wed, 23 Jun 2021 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162446400906.32151.1333873954843584643.git-patchwork-summary@kernel.org>
Date:   Wed, 23 Jun 2021 16:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [1/1] spi-sun6i: Fix chipselect/clock bug
  Submitter: Ralf Schlatterbeck <rsc@runtux.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=486737
  Lore link: https://lore.kernel.org/r/20210521201913.2gapcmrzynxekro7@runtux.com
Patch: [v2,1/1] spi: spi-sun6i: Fix chipselect/clock bug
  Submitter: Ralf Schlatterbeck <rsc@runtux.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=499971
  Lore link: https://lore.kernel.org/r/20210614144507.y3udezjfbko7eavv@runtux.com
Series: Support ROCKCHIP SPI new feature
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=504289
  Lore link: https://lore.kernel.org/r/20210621104800.19088-1-jon.lin@rock-chips.com
    Patches: [v10,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
             [v10,2/6] spi: rockchip: add compatible string for rv1126
             [v10,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
             [v10,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
             [v10,5/6] spi: rockchip: Support cs-gpio
             [v10,6/6] spi: rockchip: Support SPI_CS_HIGH

Total patches: 8

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


