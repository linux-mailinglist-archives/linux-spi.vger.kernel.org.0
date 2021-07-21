Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226A63D1747
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhGUTHL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 15:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239569AbhGUTHL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 15:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D815B6120D;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626896865;
        bh=6huAX5M9TlGaC5gjJxEOBbU4z0vXMtUSxCfta95YnY8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NjFGSsS2yHf8DyS8eHjuhQHSHM/VAtU4fF/CMRwRcbm/Bt/O2M3HcibeO95TAZuAK
         /dmaOPG2XZl0TMmPrsHkrQEM2dB4RxhPFBVWPM4RNMABkJqXRRwKBH7QyqJQECiW+g
         ePPfLFw6iMbadu4OXt+QM8ODodRRQTFycaSJMR5inJRhz2eeR64Oad4uEa3/Xk9pvu
         8a0g4aABe3K8ZBLetg9H9MOfR/jf+vXVDPL+DtbKXpmZt0/tdnI0XnY9ecBjyFdQ04
         QJhloxrTWMD7zwIrNJCJ8/T8G/oJ67OZT6p3TetBX2zO1eW28A1xZnTD9EadiUUQKH
         QOSLSasgcIV/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D189B609B0;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210721173407.485936124B@mail.kernel.org>
References: <20210721173407.485936124B@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210721173407.485936124B@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc2
X-PR-Tracked-Commit-Id: c45c1e82bba130db4f19d9dbc1deefcf4ea994ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b6ae471e5415bc2bf4384a83ccb4c21de7824c0
Message-Id: <162689686585.6427.15444597373229285284.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jul 2021 19:47:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Wed, 21 Jul 2021 18:33:48 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b6ae471e5415bc2bf4384a83ccb4c21de7824c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
