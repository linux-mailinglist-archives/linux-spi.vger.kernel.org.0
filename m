Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F74214A3
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhJDRCU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237979AbhJDRCS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 13:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3B9C86138B;
        Mon,  4 Oct 2021 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633366829;
        bh=5d6GeRf3j6ce+13Kpt3H1UYtuhfulIT/beSzBr6XZPk=;
        h=Subject:From:Date:To:From;
        b=RQ5yT9f3JHPUUH6g6Qowz12oOBImb7FZKOlaLDzudhP7G7N5ewc1tMv10iLbEX5P1
         SEC5GL7SukwMwcLv76z4aUSnR4QkfAEQQRn/8+1nEpXUVJTbNNLRhBlIZKYFsAbNF2
         SIu/nwR/0Yxml+xi2vfhOXgnDd+QYWDJxf32lCiJv6lRL9nWsA5bhDKDHri88VocvW
         dSlPxfP3inUwL2GUP+1150AXA5UqBicXS1fxmmzDUs1S7icZZdy2MmVB7La2CWajDI
         j43ol4uRGWwkoP4K0nIM0uCIXxSyjTyLiUPlC6eDh7VKrepx46I8BEBFkRpmG/djwf
         9EmiBp3LfrpRw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 298DE608AF;
        Mon,  4 Oct 2021 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163336682911.31009.16213998793380468389.git-patchwork-summary@kernel.org>
Date:   Mon, 04 Oct 2021 17:00:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] spi: cadence: fix static checker warning
  Submitter: Parshuram Thombare <pthombar@cadence.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=556997
  Lore link: https://lore.kernel.org/r/1633336704-22735-1-git-send-email-pthombar@cadence.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


