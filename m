Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A523D7B70
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhG0Q4n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 12:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0Q4n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Jul 2021 12:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CCE8660E09;
        Tue, 27 Jul 2021 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627405002;
        bh=lpx6e7GjcTkMvlWPNBtRyNpprwhasxzKOHCugUZFNkI=;
        h=Subject:From:Date:To:From;
        b=kMxrOe4hYHcuiH4s6hl5oyrPNm5lBLHKMQPfyCFjvkq5R9VhnZKL9IbDrmCoQR8Lm
         roMu7KvstljuRC9poPCPBstLL0NQg/3PMji1q0kp56Ssdo8Mpw0fMnzLD9cG3HhgKa
         0fuiTv10KjoCpTJGp0YCKEvjrZYkqMLb2rcLPkzpsvJHJcP/k3DKNP8jVqfAu88pcD
         BbGi70a++PIBN8FRn7xiUUPjzZWsXbxFAgqN1e416uOW3H6JdMyvcBxzHBjT/b50+S
         KdnT5nnArcDHQ0y7jszFt+9dAmI20efF2tMtSJT5QVQtEmWG41VwwDhiIg1ZLnAvXC
         9uWOEdK8Kbq1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C1AEE609CC;
        Tue, 27 Jul 2021 16:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162740500278.29392.9903331906346823246.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 27 Jul 2021 16:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements (2021-07-27T16:01:05)
  Superseding: [v1] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements (2021-07-14T11:30:13):
    dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements

Latest series: [v2] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment (2021-07-27T16:04:28)
  Superseding: [v1] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment (2021-07-26T10:15:02):
    spi: imx: mx51-ecspi: Fix CONFIGREG delay comment


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

