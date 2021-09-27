Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F2419D1B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Sep 2021 19:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhI0RmV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Sep 2021 13:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237553AbhI0RmJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Sep 2021 13:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B069260F46;
        Mon, 27 Sep 2021 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764431;
        bh=wGR9JEgD3NxC27sdML8vp1g9bKg5Juq9j+uvCNJilsA=;
        h=Subject:From:Date:To:From;
        b=DtZ6+OA1Ztt2WaA47QlxxyBLQ+KcS/qQk29LnpxRRqvRPAjskqhHWrPw46kvM/9KR
         RLoRKiRKX2Jf90XpqEdKBv1rsOCeXXvtdzSBYoRcF0eITkbWKKIfyIFvB6ZoLAlSTW
         lwhUsP65Z24FT+PFC/y//qYzukAUdirRcK+JKWU6vkfmVcuptBGYJ6x+uy8w418eEk
         s5f19gSpQAfeybZ563VBvwKwFIhuu8JjwjIzZlJCJa4lH3N0kmiSUYbI/ORoONR6Q+
         imj7FxQa4yVX+pahNxGeRni29vtprXZmVmuUg2cJiyT0T9OyRjkOnP/QNdXZGetR4y
         /3Ec5oImv2hiw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BC87609CF;
        Mon, 27 Sep 2021 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163276443157.20047.1445992726029064304.git-patchwork-summary@kernel.org>
Date:   Mon, 27 Sep 2021 17:40:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Fix mdiobus users with devres
  Submitter: Vladimir Oltean <vladimir.oltean@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=550071
  Lore link: https://lore.kernel.org/r/20210920214209.1733768-1-vladimir.oltean@nxp.com
    Patches: [net,1/2] net: dsa: don't allocate the slave_mii_bus using devres
             [net,2/2] net: dsa: realtek: register the MDIO bus under devres
Series: add support for Cadence's XSPI controller
  Submitter: Parshuram Thombare <pthombar@cadence.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=549405
  Lore link: https://lore.kernel.org/r/1632038668-23756-1-git-send-email-pthombar@cadence.com
    Patches: [v6,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
             [v6,2/2] spi: cadence: add support for Cadence XSPI controller

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


