Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C863E2F42
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhHFS1Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Aug 2021 14:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhHFS1Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Aug 2021 14:27:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B68A460ED6;
        Fri,  6 Aug 2021 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274428;
        bh=+DPz3a3YSufyYBoZtapTTwtyPij2qgqBTna6g4zm7eY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qFjq4qc0jjW3gItrJixyjGUfdPpKDwX5I00pS6eDzGu9feOMw0eZd57vJTHFWooNz
         28TQjitfkbfno4eVHj8hwXoVcfc7VRtt/vxX759CZ/kr7c8e5EIGMMRmqhAfOGH8D5
         zZKO/msc29Bf/2qtv/D1FPACmeLjvV9CUssohh9uXQ1BOOcyNg27Z84ab1+Y2kOMR5
         rbfz5OqZl5JHVA9z2Y18oMN+ksW5HMXqB9jBt313DwQ+YvP9Ofl3xG7bxXbSVfrfz4
         A5U26mYVjfcdoveHE3pYA1ZASu3cjImKODLPW24dp3Svnhz2QFvvn1f9j1f+z6nr2u
         ITHlwkNicIHMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A21F360A72;
        Fri,  6 Aug 2021 18:27:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210806145551.243236105A@mail.kernel.org>
References: <20210806145551.243236105A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210806145551.243236105A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc4
X-PR-Tracked-Commit-Id: 0395be967b067d99494113d78470574e86a02ed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 894d6f401b21865962aba776ecaa918b2f0abaa6
Message-Id: <162827442860.9282.6302981407334600594.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 18:27:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 06 Aug 2021 15:55:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/894d6f401b21865962aba776ecaa918b2f0abaa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
