Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8328D39B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgJMSYT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 14:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgJMSYH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 14:24:07 -0400
Subject: Re: [GIT PULL] SPI updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613447;
        bh=6mlQVw+rrBCO2LC11qi6DBtvC2K7Cv0v49UjE9zjxqA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X+IsEjVcluRxCy8Vp41jdg1FG7NZ3tfMvWD6LpFIadanNOJgJEfNWWG9PDPFM7m+u
         ezFol7mR2hFcb1tlQ7VKEPR36IUM2Elx+nha4KokzMdWDlusJT0wTAKtN0UTqtaGDX
         y8F226VhNYtaoaJz6OTO6XCQ3DO1sewgBR554dAU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012130953.370DA20838@mail.kernel.org>
References: <20201012130953.370DA20838@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012130953.370DA20838@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.10
X-PR-Tracked-Commit-Id: 988731181359efd771ae967f94936906fa38868a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a996b9c61729cd1507e48303c214dc317df890e2
Message-Id: <160261344710.11865.644561534721349938.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 18:24:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 14:09:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a996b9c61729cd1507e48303c214dc317df890e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
