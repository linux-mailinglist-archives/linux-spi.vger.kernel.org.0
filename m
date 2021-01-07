Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA02EE6C5
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 21:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbhAGUYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 15:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbhAGUYd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 15:24:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F2A4023406;
        Thu,  7 Jan 2021 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610051033;
        bh=Dj2QWyo30J8bbFxXEj7TdXQ0PjuLFuwxYQ/Sb74QLys=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aiMDgi914zjhpm8EoL/EdZd7zfUh2c/ryz5483VU/Rpe0ppqF3rLcWDFzEKHKK/jL
         1BYRHgRZ4uBR3gVFfuAot77XT+uo4LUIRY/WlrbkaAldJL7H683PQEVghzCdKunwtT
         hsHkz7WQSmaLu/cv5BdwsScv91ZdTVSVIM5dMcXhDlQ463PhdYXPO34520NKqqxDxM
         mYEdxo+jFDBCZ4D74WyMK9d0YC+1mai6gvLJjSTfENptsvl64gcd/GJxo2E4awAWSo
         jdbXoiSS+feM5P0lwVKwpS02UfxasC5tut6aunsnlg0jc1vjG2w6LAcfN4SbK6TNyx
         QBNSg+Do0oN1g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id DAFFA60508;
        Thu,  7 Jan 2021 20:23:52 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210107171103.EE51F2342C@mail.kernel.org>
References: <20210107171103.EE51F2342C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210107171103.EE51F2342C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc2
X-PR-Tracked-Commit-Id: 6170d077bf92c5b3dfbe1021688d3c0404f7c9e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5e6c330254ae691f6d7befe61c786eb5056007e
Message-Id: <161005103282.19187.5682766892624812410.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Jan 2021 20:23:52 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 07 Jan 2021 17:10:22 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5e6c330254ae691f6d7befe61c786eb5056007e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
