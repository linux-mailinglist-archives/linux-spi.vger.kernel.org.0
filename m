Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5D3C5B19
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhGLLAt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 07:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233522AbhGLLAt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 07:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F19F260FE9;
        Mon, 12 Jul 2021 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626087481;
        bh=NR+4QV4YSg25MCNf6/e6Igd5gc9zS3Fq19BnJy9FTl0=;
        h=Subject:From:Date:To:From;
        b=fkQ3tE5mbxvt4mFvQTS6sgYkDWypLy4dX9kikuFKKm+5ra2OW+i+vbTG2nFja5Lq5
         62kDUlVg1FBee6XJ4mcLD60+6RULgkjlKqAVK5asxPexYjH7yJJMaq41TYVJP2hClz
         kiLrx39OVKO8n+jOrErlK9/lf0fqhQ05ZZZ+P+k1HMCoEKDShn+3kSypjnnBYfTYqy
         atQrTCtCsUlNxGO3/MRHpL7il3Is6U46wTWh0ZaqTDNdBBXYYrLmK+n9v8IN4x22v3
         wj4hyI0YY0P9TxTIvr5+6X6ItapI54FFtjHMnLB5cKy17gdGLqTxGl7FrxeW4aeeBH
         0jW8Wu5LjTioA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E24F4600E8;
        Mon, 12 Jul 2021 10:58:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162608748091.28349.13712895311089742631.git-patchwork-summary@kernel.org>
Date:   Mon, 12 Jul 2021 10:58:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: mtd: spinand: add SPI-NAND MTD resume handler
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=492423
  Lore link: https://lore.kernel.org/r/20210602094913.26472-1-patrice.chotard@foss.st.com
    Patches: [v5,1/3] mtd: spinand: add spinand_read_cfg() helper
             [v5,2/3] mtd: spinand: Add spinand_init_flash() helper
             [v5,3/3] mtd: spinand: add SPI-NAND MTD resume handler
Series: Adapt the sja1105 DSA driver to the SPI controller's transfer limits
  Submitter: Vladimir Oltean <olteanv@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=486053
  Lore link: https://lore.kernel.org/r/20210520211657.3451036-1-olteanv@gmail.com
    Patches: [v3,net-next,1/2] net: dsa: sja1105: send multiple spi_messages instead of using cs_change
             [v3,net-next,2/2] net: dsa: sja1105: adapt to a SPI controller with a limited max transfer size

Total patches: 5

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


