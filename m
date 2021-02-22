Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB4321EED
	for <lists+linux-spi@lfdr.de>; Mon, 22 Feb 2021 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBVSN1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Feb 2021 13:13:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhBVSNY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B6A9464F07;
        Mon, 22 Feb 2021 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017529;
        bh=0tGRBl8lcPjBRwpScX2Ze+J0NAutNiEB4E1ZO24dCXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sEmdfHAjaMzfpVpO+kbSMa93/XU/H0iDvXPoeM3ho3EsynIY58HNe7Rfl2N/aplpx
         g1agHpjZ2+dUgFvZ1t9oqSGE+WdbZbZ65wQe1wdpH94pSuhA/Et/lck36dpJCGBPD8
         KwMYaWm7qNPq8Z68j/puqWORWa0VPLYkeIUY80lbpEeuvogJkqvhOWmnFVCEHfF+Hf
         9vteyg6EOWijzjWVI20YDXao9PBFQzCdfni9vurZJJ7EECM2BOjlcFeJz0V5EZaB2o
         MN2gCg1U3FS7qgOY+7HPktBjAjyDwwiH/DZ3o1oYb6bQah27k9AFG6rSsv/6U36rvE
         Zz48FbJDUQ2qQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B210460963;
        Mon, 22 Feb 2021 18:12:09 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215204532.AC35B64DF0@mail.kernel.org>
References: <20210215204532.AC35B64DF0@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215204532.AC35B64DF0@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.12
X-PR-Tracked-Commit-Id: eec262d179ff60e8d12298ab2f118661040e0bf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2590d69893f232cbb79d149dbbb456a1febca22
Message-Id: <161401752972.943.16045008972594432854.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 20:44:23 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2590d69893f232cbb79d149dbbb456a1febca22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
