Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8541F87E
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJBAL6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 20:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhJBAL5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 20:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D6F9B61ADF;
        Sat,  2 Oct 2021 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133412;
        bh=2nsmPvhDX7002KzzZY8My+vrYOqCrwDJ66QCeJbCyWo=;
        h=Subject:From:Date:To:From;
        b=YkdAQHztU+6xsbMJ7JQ+vKqEmbtN3skmSWDyA3qnTGjdY6prbKUZHv1fDwAvvt8AG
         Bg6b+t2OXfRxaF71AIyplsISsevMyuLFmI/iJiHXvS/kLZZzPxDlTIqhyzfvMBw6fS
         LvRTzvJI61prKM8OCtgknqByqhClFNIWl1yeexktHQmCcJrgCt+6ZVPjolr2lnpJaj
         t94OuQTVHESDrC5kmheulI43zSJp79LuGpRBoAhw3QI1HshM7MDUSxxc8/0Os5BpX9
         tS6tW1CDlyJjE2Q23N2OBpA99LcVycmWFOdQKH8063zcZztHQRtrXqFU0P8OQrrNyE
         LtUX7wRBj3qTw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C0AAD600AB;
        Sat,  2 Oct 2021 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163313341272.19979.6547648498167009899.git-patchwork-summary@kernel.org>
Date:   Sat, 02 Oct 2021 00:10:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: cadence-quadspi: Add Xilinx Versal OSPI support
  Submitter: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=552217
  Lore link: https://lore.kernel.org/r/1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com
    Patches: [1/4] firmware: xilinx: Add OSPI Mux selection support
             [2/4] dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
             [3/4] spi: cadence-quadspi: Add OSPI support for Xilinx Versal SoC
             [4/4] spi: cadence-quadspi: Add Xilinx Versal external DMA support
Patch: [v2] spi: mediatek: skip delays if they are 0
  Submitter: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=556347
  Lore link: https://lore.kernel.org/r/20211001152153.4604-1-dafna.hirschfeld@collabora.com
Patch: [v4] spi: atmel: Fix PDC transfer setup bug
  Submitter: Ville Baillie <VilleB@bytesnap.co.uk>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=550237
  Lore link: https://lore.kernel.org/r/20210921072132.21831-1-villeb@bytesnap.co.uk

Total patches: 6

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


