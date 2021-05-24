Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16FD38F247
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhEXRco (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 13:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232693AbhEXRcn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 13:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 98655613EC;
        Mon, 24 May 2021 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621877475;
        bh=+Mj+vVcsjvsi2b5DDLHc+QvWb7XgEygO03z0YmvsFqA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VGyVW0+aa9sgidxH/YD8Xm3VLgEEGA0bXklIZ/fHBUGKs54qhP0GGZGkQU1hcTzjG
         FKmBoZVx1xwb+Dc7wSKXsMiKYvCXMBg4zcqB+es/YQQaCoy7lfVaYV029oZ8jAdFoU
         e7eHAsKSer8Lygv1lY622hDBo0h0uQPKkiRDGpuo0luol/K6ULOASuImgKMNhQ2iT4
         vUVP+eIWDhcSApO7hIZZiVW4S8KNzptLpKtCniuGk+SJqZ3F2U3PYkHclTYlSkApAE
         tsk2xhPKXb7BGMMrd+GAeT3a1OB2k/3K+Ru9rkJ+b9CpH/mDTLQGX6lPX41CKQX3jE
         XSdEDSfn4uv9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84BA560A39;
        Mon, 24 May 2021 17:31:15 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210524090329.9BA7260698@mail.kernel.org>
References: <20210524090329.9BA7260698@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210524090329.9BA7260698@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc3
X-PR-Tracked-Commit-Id: b4e46c9954ad55092502e1e8c44ceb9b6744bade
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f71d49e01be6bb0f96ca33402477162511988e9d
Message-Id: <162187747548.9813.17004866093200772240.pr-tracker-bot@kernel.org>
Date:   Mon, 24 May 2021 17:31:15 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 24 May 2021 10:03:14 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f71d49e01be6bb0f96ca33402477162511988e9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
