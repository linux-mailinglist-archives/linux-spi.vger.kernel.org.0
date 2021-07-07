Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BD3BE4CD
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhGGI7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhGGI7a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Jul 2021 04:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 501FA61C84;
        Wed,  7 Jul 2021 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625648210;
        bh=VQynKqdD/cumkfdeDxI5c7VyIxtyza5DAWlmX2BgB4c=;
        h=Subject:From:Date:To:From;
        b=Xmu8ykPir8FW0TNj1ESzXvdayUjhMd34gAN6dlyKfvasngTB+SldyXIBUZlNL5HRB
         N0P+IPG2PzhTfw25UllxzAhC0ojdYwMZPg2FgRRZ3hUjQGYIn7dxuqXD6EPhZfQEaN
         E0s0zlPDysDER5PFQCL1qzqtoMwZNttyevkxZVpsTmPeQGUNqcWQTTiIo0qmhlONgV
         91//z/Orl8XOrsmnQBW52N6sHhMkR/2YBkk8OgfPotKD9/B0s86u2aJNFa8o7Nodtc
         ISFzfqHQ0tRAQtoVmOu2otb7aI6w6ZzmAHmgxkVldmQZLA7lOMmssOUYiaKeVuuinB
         OG3VBXOTymUfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 479746094F;
        Wed,  7 Jul 2021 08:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162564821028.8692.5395729243636891102.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 07 Jul 2021 08:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32: various fixes & cleanup (2021-07-07T08:27:01)
  Superseding: [v1] spi: stm32: various fixes & cleanup (2021-06-30T08:45:20):
    [1/6] spi: stm32: fixes pm_runtime calls in probe/remove
    [2/6] spi: stm32h7: fix full duplex irq handler handling
    [3/6] Revert "spi: stm32: properly handle 0 byte transfer"
    [4/6] spi: stm32h7: rework rx fifo read function
    [5/6] spi: stm32h7: don't wait for EOT and flush fifo on disable
    [6/6] spi: stm32: finalize message either on dma callback or EOT


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

