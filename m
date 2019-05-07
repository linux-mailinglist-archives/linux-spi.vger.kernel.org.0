Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFC16647
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEGPKJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 11:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfEGPKF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 May 2019 11:10:05 -0400
Subject: Re: [GIT PULL] spi updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557241804;
        bh=NaIsSXzIcMFRnBC8bWDF0NJ2eiWwpDrGf7HZPQRFR8E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LWKYn3FWC6thZFHQ80OYSpdSikkK5dzW6I1rbmg/s+dWFvpxO0Q6McnKiN5cps9U9
         +EMngVxjVcLNXFpey1plv8tQmd7Ad1kV72rVQFDCgCINZEL2WJuhrXfOrqFDnaZO5k
         zxfg6mzYTSy7yesKZADTP7A1PBhDNb4ASdE+Kq6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506143301.GU14916@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.2
X-PR-Tracked-Commit-Id: 2e5f081003f033d37be3faf052aaccc8b6a44aa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bff9dfc513bd5de72cb59f4bffb72cf0a5aa526
Message-Id: <155724180454.32029.15609659443661274152.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 15:10:04 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 23:33:01 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bff9dfc513bd5de72cb59f4bffb72cf0a5aa526

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
