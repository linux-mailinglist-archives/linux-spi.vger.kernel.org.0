Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19C52FAC68
	for <lists+linux-spi@lfdr.de>; Mon, 18 Jan 2021 22:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437685AbhARVRJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Jan 2021 16:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389246AbhARVQy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Jan 2021 16:16:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8BB0B22D6D;
        Mon, 18 Jan 2021 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611004574;
        bh=pJYbNwmantxPTLd2nIf5/Q790ke388qEkyFv79UaKog=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CIOIyXhlhwY8gtMpKQu48Q5toXIEtDg6MxTcJi6spHYr4wtuLeyP3ZSPlrM0q1nHo
         hk15oIIOpduuM7zb1ESuFolJThCOhlIwVYHZfFf1bk/4bvI+WgG4qLmdQ25PO+YPrf
         7psrX5Xg2YoPzTeLKrKuoZ4DXTSvyKnyC1myx/3YQGgJkWMO5nbXHCEu/WQHMYprS1
         J6rK0xLr6L06TtEHzNjMcMfWEHrvxVk/iGN1vCeHP7UmWQHHfNiNyzskkkcx41F61y
         vf6BvqOllBhmNb+1uQ1JSNQLSbl6rF1ODluqVCC8naOM16EeI4hVYamX83JUmkhRwl
         tH5UMV3cRnWeg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 83D01601A5;
        Mon, 18 Jan 2021 21:16:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210118175307.44A5320829@mail.kernel.org>
References: <20210118175307.44A5320829@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210118175307.44A5320829@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc4
X-PR-Tracked-Commit-Id: 4d163ad79b155c71bf30366dc38f8d2502f78844
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
Message-Id: <161100457453.30333.17732063240339912259.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Jan 2021 21:16:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 18 Jan 2021 17:52:20 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e2a199f6ccdc15cf111d68d212e2fd4ce65682e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
