Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF22A9EF4
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 22:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKFVOd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 16:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgKFVNY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:24 -0500
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc2-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697203;
        bh=JSgth3tfgPhPN4tXKctwBg5AZk3HnGTJlyywwpQuknk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UqhEORHs88GdfXSl2mT9PXPNAJOTYsUXEXzAX9pm1PtiBWxmaUxKAEwhwepQLjJeJ
         hlJFI28MJGg9AXsQ0H7MkcBfbI9vBUE9jwwGC1OGLMMdZpuErxcq8otU/NmY7DInUD
         Uh8/9qNQYcgdC1F8FmOl/BxSrWs4POIBmmItrS7A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201106173823.48AD72151B@mail.kernel.org>
References: <20201106173823.48AD72151B@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106173823.48AD72151B@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2-2
X-PR-Tracked-Commit-Id: bc7f2cd7559c5595dc38b909ae9a8d43e0215994
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44d80621857f916f1370782cdd20c9359ccc5eea
Message-Id: <160469720351.14190.6655629553371321723.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:23 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 06 Nov 2020 17:37:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44d80621857f916f1370782cdd20c9359ccc5eea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
