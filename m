Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282612F4EC8
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAMPax (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbhAMPaw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:30:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F68D23102;
        Wed, 13 Jan 2021 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551812;
        bh=gtKkge5HloFVkkhUEJIDV2MvGD6CXB+AQJnlJfOPvE8=;
        h=Subject:From:Date:To:From;
        b=Amc6+xzLKbBGl61JiE5NpOtmpFSHPlNuMkel71ANxfS6NhkckRhwPEHjOXwYs10ec
         4xrXzlzO0xCjQ+BMJhr7Fyf2LdkHk91p2RHjBpSAGxH3ztOKHpHkkVcs9A6WuHneVf
         ffExjZ/9nUNjuqd8Ipte8Kzx5xtf2GWN4QFrSy+4vLd7KTAsBdLngqRY7RgEc/893M
         4ZMUvrwX6MbVKljUa5Hz6hNCkq2nQigKnHC+nWGgO8wyffVvA7k2Vmlqp9uzf/RsDd
         mB/qgJHS18rC/Mxea6LTKjPtAXFgQiTYx51rPfyDHd9muDQMYwfhnlVfopfCTFoA+S
         U4/K4j/2O2Ovw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 2C086604E9;
        Wed, 13 Jan 2021 15:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161055181211.4919.2227245752847106216.git-patchwork-summary@kernel.org>
Date:   Wed, 13 Jan 2021 15:30:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
  Submitter: Ramuthevar,Vadivel MuruganX <vadivel.muruganx.ramuthevar@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=389857
  Lore link: https://lore.kernel.org/r/20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com
    Patches: [v9,1/5] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
             [v9,2/5] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
             [v9,3/5] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
             [v9,4/5] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
             [v9,5/5] dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi

Total patches: 5

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


