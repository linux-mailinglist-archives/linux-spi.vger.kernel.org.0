Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934E3289D84
	for <lists+linux-spi@lfdr.de>; Sat, 10 Oct 2020 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgJJBkv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 21:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgJJBNv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Oct 2020 21:13:51 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602292430;
        bh=Q5DpkwDbVZBYh2r2KbXAqxaPBMcrtDUKChWniXx1vUE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RBlcwzxCSdVRbYdAAqCfEDEXdN7x6T9XiDixE9Rf5i0qIYd20u0+RL2KU7YGaYNR0
         NnTToQfwzcFBVX+ZBeedQOmwK+zdgezEhgbBYDGRj9UephKd2YyS3AHKVTr+GEC2MX
         suhwPHqAYQ4BB98q5PYIcbF4+Qtqatj5xMUdyr4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201009234428.3827A2072C@mail.kernel.org>
References: <20201009234428.3827A2072C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201009234428.3827A2072C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc8
X-PR-Tracked-Commit-Id: 1c33524f79853f41e80390b1a223254aadd30bd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2f486d57c4d562cdf4932320b66fbb878ab1c4
Message-Id: <160229243062.25674.17343889976744594182.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Oct 2020 01:13:50 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Sat, 10 Oct 2020 00:44:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2f486d57c4d562cdf4932320b66fbb878ab1c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
