Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1941273B
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhITUY3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 16:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhITUW2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 16:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD50B610A0;
        Mon, 20 Sep 2021 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632169261;
        bh=V3FbEQEbaxJ61sesodmpgYfnNBZ7ltWCBfJ9pDXsH0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gNUWWWmC+Qty7M1xaetf7M0bNcRQ1Rgwh2au8EQq0FvxPrwR6t3ncZjQRubBCIfP0
         28eKWcpotCpmtCVDhpA6qXJU1FCQim6Bf9jSIh6HiSs5fmIf2z/d4JSSZF1bw1JyQS
         WmHO3pzZOvkFpNePdDVxNUS8oaM3P+cf8TyPwBNsm25qGTOEKEJ68jQSwdczODWkF4
         pHSfYywpLUQOBPUaT1QxIZxaZLaV7G8oLO+SGVcrR78GlhNl7J3MkCx8lAO/vmc5IU
         6y1tanfGV6f1QgGuRRilzyeywv5j6p1bbd7TzXU+t+z7Skfo9xnfG/kF4zRdH1PbYW
         ULHClsT0C52cA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98A4C60A2A;
        Mon, 20 Sep 2021 20:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210920122004.843A86109D@mail.kernel.org>
References: <20210920122004.843A86109D@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210920122004.843A86109D@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc2
X-PR-Tracked-Commit-Id: 2bab94090b01bc593d8bc25f68df41f198721173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c17ca27923c16fd73bbb9ad033c7d749c3bcfcc
Message-Id: <163216926156.8691.7592003093574442163.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Sep 2021 20:21:01 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 20 Sep 2021 13:19:02 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c17ca27923c16fd73bbb9ad033c7d749c3bcfcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
