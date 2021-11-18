Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE14565E8
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhKRW7I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 17:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhKRW7I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 17:59:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2714E61526;
        Thu, 18 Nov 2021 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276167;
        bh=gh7z4pam1guQWNqq19/ROaavwuPt+NUH0wC0sO2O8eo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QSrwzA/HLHfAXzz0ObHIfDLVFlWaWzA0WpGsJsIV9l0pIOZEVDc/pgW44JlaLaGxx
         8X+EHdc8brVpDn62Gu7Jdy9ISlWmpbNc52w+BD0CLqAWjXZssbyTEiMD0d/W4wc/S2
         G+MOcKTZyBln531hbC/LPSg2+SeuaIo8Hxz1MUPpcBtIGfJTcXaCaS9SllouPb8LsC
         C7vPauHFaK4iUUK/4pkCq5FjQS4fY/EST5JEHVX3hD/O6XWqeKinVilYKZsqMaZfWv
         FW3c7Dl6Imqu+95jMsGzzJsGoQyftPi2zoO2TPtoYyUFV7kize9VSNa0idgWPRMp0b
         c+OWSWYD8RR+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1281660A3A;
        Thu, 18 Nov 2021 22:56:07 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211118172553.DF0FB61284@mail.kernel.org>
References: <20211118172553.DF0FB61284@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211118172553.DF0FB61284@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc1
X-PR-Tracked-Commit-Id: 6c53b45c71b4920b5e62f0ea8079a1da382b9434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea229296809aa696fbe006d29d6cd8692880f60e
Message-Id: <163727616701.9679.11107681105658242812.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 22:56:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 17:25:37 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea229296809aa696fbe006d29d6cd8692880f60e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
