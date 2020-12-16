Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D242DB817
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 02:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgLPBBB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 20:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgLPBAp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:45 -0500
Subject: Re: [GIT PULL] SPI updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080405;
        bh=fN+1aWLhBuLgYYrImMqwGZs6BWv0V5mG6TgTaH5SRI4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p/z5LT8tS97g7A5xmhHMnBYoDtJerY5oIJWhuisGhFwA7y7HrOLML+3bsekiopABl
         /DIb6GpGXL5FCpywF31RIGCyo0tj1dUqYAbARGkeyWyLCqBo0YeI1K2ReFeluUY9f9
         UWBphmnO1ykf/9jfpkG7pDnGa8wkhp3tm103bNGnpOdmFHRe0fFBp+npDboCgwd0tJ
         JiG9lKz8F+h39miBqp6s4TqeYx9M1CPKi98vROi+BF4n0DqQ+L9tNMVUIylW+IqiE1
         9ONstvyHkrXk0qsRB+A1E3D70BnvdEuOFAB3lyJax8jqRs0vViHtO921oYi+KEYYMV
         vPpAGLRVO+C0Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214144830.39E172253A@mail.kernel.org>
References: <20201214144830.39E172253A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214144830.39E172253A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.11
X-PR-Tracked-Commit-Id: 3e98a021cc85e7d52acdd1eae8a988e975ec5bf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 605ea5aafe1341ac9b2144516f898ac78ad49c40
Message-Id: <160808040547.29502.5116228565730108567.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:48:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/605ea5aafe1341ac9b2144516f898ac78ad49c40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
