Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7608542F580
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhJOOhR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 10:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240344AbhJOOhR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 10:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A2B3F61215;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308510;
        bh=TdYUEWZVacFgWbrahliRzX8KiRZOXH6wLqFgnK7ZssY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GXDotZmf/UHrrbmfr8LIgZp2GwE601URgw47TDJcXLF8xgOMjY1GCEPV+TY53tsme
         6FAewisHYBqgPJOBVSIt1QQCqOQNRUhLzevH+KuucEMWC9awVv5CLem+L56rxwpZ9V
         6vMcgaXAYPXhEyyCR9q75HZQCRXJaAYXv5OSAobbDvR3XhaWP1yz7ttQ1w6l4k6qKK
         4HtAYDCamAIb82nacSe9RYudI3yMh65PbIgs2Bcf/YMZQBnIgZ+eNPKHue3akCk96S
         Az9TH5xsyEw0mjem1Zu/v0JN7xBZVgJDmGPTDIxyvqZOXo7bacSJfhRcKO74vVSYMK
         SyjRWpkobr6ag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B9E460A4D;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211015115800.E18A660524@mail.kernel.org>
References: <20211015115800.E18A660524@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211015115800.E18A660524@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc5
X-PR-Tracked-Commit-Id: 16a8e2fbb2d49111004efc1c7342e083eafabeb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 985f6ab93fc986f339654b5cb2e6825839bf3bc5
Message-Id: <163430851063.21069.4915656461278226454.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Oct 2021 14:35:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 12:57:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/985f6ab93fc986f339654b5cb2e6825839bf3bc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
