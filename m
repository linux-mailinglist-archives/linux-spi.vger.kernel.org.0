Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FD131A06
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAFVFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 16:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFVFK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jan 2020 16:05:10 -0500
Subject: Re: [GIT PULL] spi fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578344709;
        bh=JTF/FpZa04zfpDw/Kg7Pt2l1gB3EiFXrFudDGVfmegw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o3e9jldxsGkEFO8liuMmFV8j9HnSNw8bVQAgPUuzsijBO/nYJAq9Nix7VRHyvZd1h
         IoQGvJkeeGpGC2Y4jAWv/wYvX9jNBrV66HaIZBgMTyeyZ2bjV+8vnyvS0pv5G1j5//
         y5BCwaolxU7lPKXcVB2yaieEQMRx0AKy46fV9Wyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106131232.GC6448@sirena.org.uk>
References: <20200106131232.GC6448@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106131232.GC6448@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.5-rc5
X-PR-Tracked-Commit-Id: 09b6636cea4f8e419d7cca4155e8695e462535a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec7b3f5372e2f674ce19c23ca8f5a2c103025264
Message-Id: <157834470942.27503.4619949117616234858.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 21:05:09 +0000
To:     Mark Brown <broonie@kerenl.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 13:12:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec7b3f5372e2f674ce19c23ca8f5a2c103025264

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
