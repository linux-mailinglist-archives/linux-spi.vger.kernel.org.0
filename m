Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33E2D179A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLGRbk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 12:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGRbk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Dec 2020 12:31:40 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607362259;
        bh=7O/G1kU3o3PBdk9Hm/WISIpc0oxFzWC4LZz2WQ5C7DE=;
        h=Subject:From:Date:To:From;
        b=lSeEsdOJuY//B+EF4I+0LNoqENvJr/XrtXGbJSCygRGxq9nDCoj5D5fxTmBllho8i
         HDcbdAtlMPZNtqoO9R/MqRwiLURjNwTwo1Wu93Mp9xrIqI4RoznZMDwESMY2DcxDgE
         GYeIpfdpjb1AECI/HzDkvW8gZlJGBHIEXH5EGxy8LEP1GjPSSMcQwTSLOZJoP+phiC
         ztdTtLLalFxJbU4E/MG9C/Ug9M1XDbpEwPCWTHHrV9FXE0Rib27mOcJ70CfO7n46KB
         LKl2i7e/AoQ6EnsFql/7w2j4TM9BYf1LrH8luipcweTd72TjZ0wbuazWoAfKybTdeP
         7oOcVrNS0ZF0Q==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160736225958.28456.4268233825724563751.git-patchwork-summary@kernel.org>
Date:   Mon, 07 Dec 2020 17:30:59 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [for-5.10] spi: gpio: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384811
  Lore link: https://lore.kernel.org/r/49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de
Series: SPI probe/remove sanitization for 5.11
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=397369
  Lore link: https://lore.kernel.org/r/cover.1607286887.git.lukas@wunner.de
    Patches: [01/17] spi: davinci: Fix use-after-free on unbind
             [02/17] spi: spi-geni-qcom: Fix use-after-free on unbind
             [03/17] spi: spi-qcom-qspi: Fix use-after-free on unbind
             [04/17] spi: spi-sh: Fix use-after-free on unbind
             [05/17] spi: pxa2xx: Fix use-after-free on unbind
             [06/17] spi: rpc-if: Fix use-after-free on unbind
             [07/17] spi: mxic: Don't leak SPI master in probe error path
             [08/17] spi: spi-mtk-nor: Don't leak SPI master in probe error path
             [09/17] spi: gpio: Don't leak SPI master in probe error path
             [10/17] spi: rb4xx: Don't leak SPI master in probe error path
             [11/17] spi: sc18is602: Don't leak SPI master in probe error path
             [12/17] media: netup_unidvb: Don't leak SPI master in probe error path
             [13/17] spi: mt7621: Disable clock in probe error path
             [14/17] spi: mt7621: Don't leak SPI master in probe error path
             [15/17] spi: ar934x: Don't leak SPI master in probe error path
             [16/17] spi: npcm-fiu: Disable clock in probe error path
             [17/17] spi: atmel-quadspi: Fix use-after-free on unbind
Patch: [for-5.10] spi: spi-sh: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384789
  Lore link: https://lore.kernel.org/r/0aeb0e948baf98ae69b69bae135cb31abe5a9181.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: spi-geni-qcom: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384765
  Lore link: https://lore.kernel.org/r/73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de
Patch: [for-5.10] media: netup_unidvb: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384825
  Lore link: https://lore.kernel.org/r/48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: rb4xx: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384821
  Lore link: https://lore.kernel.org/r/7ea28322f0295201ecd93253600b613fdc588d17.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: spi-qcom-qspi: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384781
  Lore link: https://lore.kernel.org/r/76a3e9a52fdb5ff60d992c6cc2e64f29d3d3ea8b.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: spi-mtk-nor: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384809
  Lore link: https://lore.kernel.org/r/a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de
Patch: spi: davinci: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=379895
  Lore link: https://lore.kernel.org/r/dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de
Patch: [for-5.10] spi: mxic: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384803
  Lore link: https://lore.kernel.org/r/4a7efc3865aace7d28ddb74776ee05695be80bd4.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: sc18is602: Don't leak SPI master in probe error path
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384823
  Lore link: https://lore.kernel.org/r/43babe4e6cd4a433dcdcf99aaabaa1a02ff44acd.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: rpc-if: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384801
  Lore link: https://lore.kernel.org/r/bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de
Patch: [for-5.10] spi: pxa2xx: Fix use-after-free on unbind
  Submitter: Lukas Wunner <lukas@wunner.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=384797
  Lore link: https://lore.kernel.org/r/b43ec730d0991482d5c22cb0b63c68f2e04d5445.1605512876.git.lukas@wunner.de

Total patches: 29

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


