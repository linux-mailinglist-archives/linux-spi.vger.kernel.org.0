Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FB36BC17
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhDZXhZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 19:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235203AbhDZXhX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Apr 2021 19:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27E85611BE;
        Mon, 26 Apr 2021 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619480201;
        bh=t+Nto9cpCrIrQwyNsBHGPh9fhxd37tgVWi2hsO1WHk4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M4bwfj9vDZPwed9CcWibSeNQe81GGs7aSCjF7q0DT3HW3DB6guQDZhySHbHZmron+
         V2rKrUrHMAN/e/06BEJwH1M1CmLFtDzGGF4SGxfAyigbk9iuWRAGPmjDy3Ow2Ge9Iw
         DeDD0myUbA6WTCraLxweu9bBY98fFrs7jhEee6OCOWrqrkAqc3cSnTA3OhOky9qQlr
         d26fU+2xtTLot2ptCFZNg6KZJ44fyeu08hy0QpaY6vAOsuqr3HjHUXl8w38LPh4Qx8
         snavvfyetrmGwsIGbvmyTmHZFZ/ixqcAvXn2cBqUJJAp0SpI5vBhPndiaSPYxpkBbe
         2ZX/ZLR/GFHjQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 20959609AE;
        Mon, 26 Apr 2021 23:36:41 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426144116.D2DBA60E0C@mail.kernel.org>
References: <20210426144116.D2DBA60E0C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426144116.D2DBA60E0C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.13
X-PR-Tracked-Commit-Id: 86527bcbc88922ea40df05d28189ee15489d2cf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a0225c3d208cfa6e4550f2210ffd9114a952a81
Message-Id: <161948020112.27003.8565683957256706979.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 23:36:41 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 15:40:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a0225c3d208cfa6e4550f2210ffd9114a952a81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
