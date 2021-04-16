Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC36D3624E5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhDPQAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 12:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238563AbhDPQAf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 12:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EACD0611ED;
        Fri, 16 Apr 2021 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618588811;
        bh=sWugirdKkwvV6nt06XwefXI/mEdoB+rIcjYqatfH3S0=;
        h=Subject:From:Date:To:From;
        b=cEM7eu9ZrYuKLeJdBRj8vm5TUmWC/A0DYqGkpCGRkfG7asFEuxLv3YIFF+T3RrdEH
         rhEeiA3e39p7uuLwjhU24gCX/OwVQUucmZ1XmuvoogL4D4aSP2MX0xMw9NMS3CTFeD
         PEUx990bLtLzxBspaNaQx6zz6HyjXXTIg+OBljKDjEJhWGJi3mvJmdKXjf9k82CEap
         t3NkgRRWp7W1y9OHC8YEgUFUCUgg04Q4dk8y2k5yUJeV34CX0pEe/spkk0WD7Wljcu
         7piW1gJGqt9dWKFOft1EnVj+NOSUIgJOwAL1vAzZon6qQKPdTdwlb5Nw3fQqSgtO4o
         HepmehwfhTD/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DA51E609AF;
        Fri, 16 Apr 2021 16:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161858881083.11790.10359855101552966887.git-patchwork-summary@kernel.org>
Date:   Fri, 16 Apr 2021 16:00:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: spi-zynqmp-gqspi: fix spi issues
  Submitter: Quanyang Wang <quanyang.wang@windriver.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=468631
  Lore link: https://lore.kernel.org/r/20210416142047.6349-1-quanyang.wang@windriver.com
    Patches: [V2,1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
             [V2,2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
             [V2,3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
             [V2,4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
             [V2,5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails

Total patches: 5

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


