Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCE2B9B65
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKSTSB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 14:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgKSTRx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:53 -0500
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813472;
        bh=9c9M5aepTvT8EfFgu84GA5zqCUYnEsqE6UbqBT6hPBs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T6QTX31eudzQ/rGxZudKj10yATHhsKN0WBQlmRkseA6tpHlHDrzDWbo+rh5FAqHwC
         cwcNzgt05mdmCjzIi3zGqtD1yyMFjsar1jCpwoMQGWPBy9z7axXJiLf+Ij6Y/xjtzg
         0n9qabbDAKM2iRY/EopiDprHHbTRzRWEz1qve6d8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201119174538.A2FC5246D1@mail.kernel.org>
References: <20201119174538.A2FC5246D1@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201119174538.A2FC5246D1@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc4
X-PR-Tracked-Commit-Id: 04a9cd51d3f3308a98cbc6adc07acb12fbade011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fee3c824edf24fd4c497bb3b887d1447150ec4ec
Message-Id: <160581347250.16071.1014504023233233804.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:52 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 17:45:17 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fee3c824edf24fd4c497bb3b887d1447150ec4ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
