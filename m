Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D223F451D77
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 01:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbhKPA3v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 19:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346238AbhKOTck (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 14:32:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EEEB760D07;
        Mon, 15 Nov 2021 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637004538;
        bh=dkAsoUbKIRtS4MmVjVP44vQyVQnf2q568P/Gy+8iwBA=;
        h=Subject:From:Date:To:From;
        b=FqbzqZh65qvHW4r5+lJEygKooI2FOpwyYRG3qTcjP39I3JVytl1oBf07byO4HxAU6
         BrpOYhnUXu/q75PbHdXXTIn68DBqfK6moGotSv0Xa3QGE3rRAGvRKKX5/BDng1gMcZ
         sErhydPxAilpDVyu0fH1KEqMeXR7rxCF45kYvx+zB1uZTazd7iU5ElclFJ+ElUOtXa
         XRdjWqhg+sreV1jyfUPOzYx9aQArjTxspikF7xmDhiugXzmnjqav3mBdcADqxrUFGh
         hxPwLFGXCFd/XViULV0Tr1vLWeyjTzVSq19N+jRU7DcLzShT9kUeXDzZaurFwqhtSB
         pboVWtdOC2Ltw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D994860A3B;
        Mon, 15 Nov 2021 19:28:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163700453783.7365.1188536705997411882.git-patchwork-summary@kernel.org>
Date:   Mon, 15 Nov 2021 19:28:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: sound: soc: tlv320aic32x4: Make aic32x4_remove() return void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=563951
  Lore link: https://lore.kernel.org/r/20211015071113.2795767-1-u.kleine-koenig@pengutronix.de

Patch: spi: Check we have a spi_device_id for each DT compatible
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=550541
  Lore link: https://lore.kernel.org/r/20210921192149.50740-1-broonie@kernel.org

Series: Update STMicroelectronics maintainers email
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=578111
  Lore link: https://lore.kernel.org/r/20211110150144.18272-1-patrice.chotard@foss.st.com
    Patches: [v3,1/5] dt-bindings: timer: Update maintainers for st,stm32-timer
             [v3,2/5] dt-bindings: mfd: timers: Update maintainers for st,stm32-timers
             [v3,3/5] dt-bindings: media: Update maintainers for st,stm32-cec.yaml
             [v3,4/5] dt-bindings: media: Update maintainers for st,stm32-hwspinlock.yaml
             [v3,5/5] dt-bindings: treewide: Update @st.com email address to @foss.st.com

Patch: sound: soc: tlv320aic3x: Make aic3x_remove() return void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=566055
  Lore link: https://lore.kernel.org/r/20211019074125.3812513-1-u.kleine-koenig@pengutronix.de

Series: Let spi drivers return 0 in .remove()
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: David S. Miller <davem@davemloft.net>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=563939
  Lore link: https://lore.kernel.org/r/20211015065615.2795190-1-u.kleine-koenig@pengutronix.de
    Patches: [v2,1/2] net: ks8851: Make ks8851_remove_common() return void
             [v2,2/2] net: w5100: Make w5100_remove() return void

Patch: dt-bindings: Remove Netlogic bindings
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=577559
  Lore link: https://lore.kernel.org/r/20211109161707.2209170-1-robh@kernel.org


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


