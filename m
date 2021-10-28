Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA15643E747
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJ1R14 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 13:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhJ1R14 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EB1EE610FC;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441929;
        bh=n5lHGHYKZXscO5U9tjYJq7rvJZn0E6D501gbNGywRFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kde7VUNN+d9DMVhNucfVX+HV2vFCzt6iBRH8+WTzta3EBLYqpAquQzQ5wZ43l7Fjm
         MBxSVKsI+1qpvxN9os9bwfJhbb0YFYmhtlAh4o+mX2OB445mnBI6YDZJFtFi1IzOB4
         7pvONvWWEXn9l+vO/bohOcQNarTXh+5fxOqON8M0VPnmCTgpdytNub7/zMd2fyORaB
         jO99y3YWaH8AL3KnKKkQFlxulg27ivNBC4TS8vUf7kHGf+TPEz1DDbDC9Xh1NaFgBN
         Os+bP9QaiwqwtC3yVNQTj1440Am/gvdr7kBOYQWrscimma+2rWeU2w/mBr0ly45zmK
         bLfwU3l1/BK1g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E48CF60A1B;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211028122404.031DD610C8@mail.kernel.org>
References: <20211028122404.031DD610C8@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211028122404.031DD610C8@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc7
X-PR-Tracked-Commit-Id: d81d0e41ed5fe7229a2c9a29d13bad288c7cf2d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fb7d85b2ebf0f06d6b47df2c9f2d45c6fec8b8c
Message-Id: <163544192893.14282.14846364848946048845.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Oct 2021 17:25:28 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 28 Oct 2021 13:23:47 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fb7d85b2ebf0f06d6b47df2c9f2d45c6fec8b8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
