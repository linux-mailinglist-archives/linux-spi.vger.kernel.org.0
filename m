Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E844150BF
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhIVTyH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Sep 2021 15:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237263AbhIVTyG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Sep 2021 15:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A49E61050;
        Wed, 22 Sep 2021 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632340356;
        bh=/q2BA3H1L1NsDGy7AxOZPCxE0Poq8Co0vt1z/9cs3uk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QNsQrLfXqxOYCADW9Dlm8LO957GukYcK+SSeD1xiia6cUuuqVmR1Xh3ZxiUSy47vu
         6cH4jjDrHF9BV0BjlZMaveTFnkGTQ14ONhYJ6FWPBIUkCAMXAIQkGNq5OLEbnBDrMg
         I8TYFyCucxiLGupSEt+PyjNREbnRQR6lBRH+sTcLSDQoO16uNEyDQif0VXKmicz4cB
         rknwoWy1YRAUBSKk/Fq6SnfwN/5TV6AndWFy3mbRPRjyysHadNDfDQAZMBSmbzen1M
         27y/LLhVJnvuCGet6zt7cOnKi/T4F0FRjBKvgmcbZV2KOwTeJoIkLcEy0Q7dy26nSY
         b5BrLC8gT1XCw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EA5B5609D3;
        Wed, 22 Sep 2021 19:52:35 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210922182417.23A476124A@mail.kernel.org>
References: <20210922182417.23A476124A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210922182417.23A476124A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc1
X-PR-Tracked-Commit-Id: 96c8395e2166efa86082f3b71567ffd84936439b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bedf10b5797a4660c2acc6c3573376f7e5d1c97
Message-Id: <163234035589.31909.16750974250302294467.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Sep 2021 19:52:35 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Wed, 22 Sep 2021 19:23:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bedf10b5797a4660c2acc6c3573376f7e5d1c97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
