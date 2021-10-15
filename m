Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2742FC88
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhJOTw3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 15:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242856AbhJOTwU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D4E5461164;
        Fri, 15 Oct 2021 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327413;
        bh=2JVhgPNTkHS8PxhwC8NTtPvw5EpDL/bMP1LXKFVOz2w=;
        h=Subject:From:Date:To:From;
        b=NMV2niwwBvcRhyVF6bre7Me7B1g9Lf6JFYnR5m/WFPlhPPejKhjL8MFVj8YR3QgaE
         5eBydrV5zWfF7X1tGDksHJDZBpgnodnLAYdV9jA+eVhgxaDLIKrSAeY5xEXIAKyPR3
         MrEH+5fx94URb7YDEPkDP6e0VDuNGZ1mQvyiA1+oQFrjoPCZu1WmAzZxs3C8rBVPsu
         eOThNpB3lYu1cLEFJRKwfUSqp4R5mAQiBVeVeZ0XOrtCboECiohiHEMYNIo7ynMNNu
         tD3ZKAVJc4nL3v1jVn6v5fHy76gp4pTexm9yeJqdyMfyPxTsTHc5z6Ijw8Wl/szf4n
         9z5BC3U5ZGRQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BACF6609ED;
        Fri, 15 Oct 2021 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163432741370.8292.1278118937278589452.git-patchwork-summary@kernel.org>
Date:   Fri, 15 Oct 2021 19:50:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: replace snprintf in show functions with sysfs_emit
  Submitter: Qing Wang <wangqing@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=563925
  Lore link: https://lore.kernel.org/r/1634280668-4954-1-git-send-email-wangqing@vivo.com

Patch: spi: orion: Add of_node_put() before goto
  Submitter: Wan Jiabing <wanjiabing@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=563833
  Lore link: https://lore.kernel.org/r/20211015034008.6357-1-wanjiabing@vivo.com

Patch: spi: cadence: Add of_node_put() before return
  Submitter: Wan Jiabing <wanjiabing@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=563831
  Lore link: https://lore.kernel.org/r/20211015033919.5915-1-wanjiabing@vivo.com


Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


