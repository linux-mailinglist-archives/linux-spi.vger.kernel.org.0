Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FF26684E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKShX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 14:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgIKShP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 14:37:15 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599849435;
        bh=VjEuWCJ6BSmQFY8Lb7eahFsiQdMu/ZumBUHw+odIaOs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xhIjyICF2houENIYfsRPU2QNgx/kJ9Mya3r/Ae2FbaaUNc109CAcT+41Fb0GPKiDd
         HvQpG/aKvzKyfW9RSbnXTO9vjvxG44QTYEeODd6nR26l6OAcVZGIDZifaDXi45KM52
         t/B0qLqzt78PIFSN0ygRjKDHSm2QVrdi42uudFzM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200911122335.31C272078D@mail.kernel.org>
References: <20200911122335.31C272078D@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200911122335.31C272078D@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc4
X-PR-Tracked-Commit-Id: c170a5a3b6944ad8e76547c4a1d9fe81c8f23ac8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8878ab825450c9ac07a0fc22e1f66fdb62b4f72
Message-Id: <159984943538.11596.13928317472483672225.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 18:37:15 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 13:22:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8878ab825450c9ac07a0fc22e1f66fdb62b4f72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
