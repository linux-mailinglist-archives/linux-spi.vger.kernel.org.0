Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC124901D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 23:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRVdr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 17:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHRVdp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 17:33:45 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597786424;
        bh=cNUrLK+X4dZ3cJneIUdks56upA/Yo4qs7Nws4YCabGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IcOuSLKWn6+i4LDQ977EbwgFvFyj0d1J3KgWkjTZ6Spu96qxkG7/W+psHmb7NGmMx
         q5Fb6Fsjajyz4iJ58ylQfF1Y6xt0z1lfjOlzaiprMCN9aDBwzkhA7HoA9G056NWS1T
         lPU1ReHFjSIFohL08BxymyxzLj2j8a2Rc6dGOHao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200818183327.30A0E2075E@mail.kernel.org>
References: <20200818183327.30A0E2075E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200818183327.30A0E2075E@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc1
X-PR-Tracked-Commit-Id: 8cb61d65b1c8d5bc5b37ebab498ca2f78d264ddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18445bf405cb331117bc98427b1ba6f12418ad17
Message-Id: <159778642459.7307.9543642986732637888.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Aug 2020 21:33:44 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Tue, 18 Aug 2020 19:32:51 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18445bf405cb331117bc98427b1ba6f12418ad17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
