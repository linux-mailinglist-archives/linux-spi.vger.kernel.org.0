Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADE1986F1
	for <lists+linux-spi@lfdr.de>; Tue, 31 Mar 2020 00:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgC3WFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Mar 2020 18:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgC3WFK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Mar 2020 18:05:10 -0400
Subject: Re: [GIT PULL] regulator and spi updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605910;
        bh=Kx+bszbi0tZCQ9AWWmH2AJ7BYQY+XLdFMqg93ge9acU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nz5yDODWc+AC5vT0nYZ8JGuw8tML6hXLGqAHkLDvxnBeahE4tVFz224RNoIuXIew/
         zohT4f3+cMIdKO73yAVPQTOz5z+bM0FQO+hYxWZ334eZkxsbIwp1GXRNiE5xBl6pPG
         yUw7wc3415NMW4qL7aisMlc10zAXW1ML7iBtDJvo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330123732.GH4792@sirena.org.uk>
References: <20200330123732.GH4792@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330123732.GH4792@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
 tags/regulator-spi-v5.7
X-PR-Tracked-Commit-Id: 6dfae59d37aec535db5e462db1a1ff76c5e3fa25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a231bed2267cf45b0759da1d3ad62483b8bd0925
Message-Id: <158560591032.3338.15534951811568304834.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:05:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 13:37:32 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/regulator-spi-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a231bed2267cf45b0759da1d3ad62483b8bd0925

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
