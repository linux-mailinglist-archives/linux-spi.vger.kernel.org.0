Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86C442595
	for <lists+linux-spi@lfdr.de>; Tue,  2 Nov 2021 03:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhKBCWn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 22:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhKBCWm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6664D60EBC;
        Tue,  2 Nov 2021 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819608;
        bh=rN0kVCAioCE8+pUMIGRQfO00EAgznsXp4fDOZHXy7CI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mjFcfcvCBEvxKZ329Xcw1cKU+d+CDY30THilLtwNf3K03JRAQK/R1BJ4+KE14hNyv
         fSbQ5Vv8xU5INROy0o75JdHR2n7BbOwCsKLOGjOhwJv8CfLSej0BgNI5HCoBo84CeU
         pjDHWjokYbqJAY4mejxxdmXbCpBac0KMOI+WPyZU8rZg6xcOCRZzxrDf02WxjNxQr2
         IXwYXzrohc2ZKbOTo6nt8FGXmboHlD3I7ekCIVw+UmE1BmnWWLs9GBXkX0V5fejRV5
         OabFa5OkntP/qQA1hprc+fZVZgBhFGIwBkPBq2bztxBAlR672qMSJrWgj0KWzCmcN4
         5ehCDzYtNmqrw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F8B760A3C;
        Tue,  2 Nov 2021 02:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101152139.9019160F3A@mail.kernel.org>
References: <20211101152139.9019160F3A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101152139.9019160F3A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.16
X-PR-Tracked-Commit-Id: 28b5eaf9712bbed90c2b5a5608d70a16b7950856
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2019295c9ea3137364682046bb6afc0eb364e591
Message-Id: <163581960838.22843.14262591204325381526.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:20:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 01 Nov 2021 15:21:23 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2019295c9ea3137364682046bb6afc0eb364e591

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
