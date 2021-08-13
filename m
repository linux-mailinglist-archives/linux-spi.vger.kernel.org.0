Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FEC3EBB1C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Aug 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhHMRMO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Aug 2021 13:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhHMRKf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Aug 2021 13:10:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1ED146113E;
        Fri, 13 Aug 2021 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628874608;
        bh=Su3VvbH7BEpHtys8VhNhq3KKoxGAdsUMpGTgo3V2DTM=;
        h=Subject:From:Date:To:From;
        b=TlCLk9HKMdl6hhiqUqKEhY9T3MN5K9xQIfjdJhl2inYeBedp7f3eBZgzwJWCYS/CR
         B2ZKAmiT91SebhzGQPXu8SJJ+u1+dWAcSBe0L11UJwY2Q5PIDbc2Rn1m26PpDe3yL5
         c9g8Y7xND7OOipWiBlJ4vWrgvBr39xrGEl6pBMqRUgevhcleHxJty3mQJcX5Lp5QEL
         Obfw4iBSc92DpcOIbhgQUqgVXybnDqpsHZWcJ4B6cSGzo9K4f6x41vvFd5bHTOSnZw
         haZye/T1OHdONQz72gmi+FxIV0BL33E77OPnv3c5ByCAlfN1uHsZ6iuEh4ClPeeRzr
         WbGnfmmYL2PwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0845360A69;
        Fri, 13 Aug 2021 17:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162887460797.31780.12244579969800613552.git-patchwork-summary@kernel.org>
Date:   Fri, 13 Aug 2021 17:10:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [-next] spi: mxic: add missing braces
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=529241
  Lore link: https://lore.kernel.org/r/20210810142405.2221540-1-yangyingliang@huawei.com
Patch: spi: mxic: Fix missing { } around an if code block
  Submitter: Colin King <colin.king@canonical.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=531099
  Lore link: https://lore.kernel.org/r/20210813104259.17612-1-colin.king@canonical.com

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


