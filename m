Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468BF82538
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfHETAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 15:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfHETAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Aug 2019 15:00:13 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565031612;
        bh=Hd/vUxMVruDyc2ioEL2KcZ0JiX1mx860S2OLciJG3sI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=suB2REPa1PHawI4aI+u/vPuCzPLF7oVBKhm6AG/qJpcGPFltfw7XLp3q0t5bpUMd3
         vfvgRqak60aO/uBHP/2ZE7XQ1H6fZ+PchSJLbCGSLplQAiQmW1rfWdJkwL5Z25WS5C
         jrKZg9QXxKJJNXsodeM8MKg/MtncqEwD4KAVA9qE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190805145014.GI6432@sirena.org.uk>
References: <20190805145014.GI6432@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190805145014.GI6432@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.3-rc3
X-PR-Tracked-Commit-Id: a4127952859a869cf3fc5a49547dbe2ffa2eac89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eb0ce0a78e1f57082bca6cbdea6fd04feedb876
Message-Id: <156503161213.31890.9702610706179189498.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Aug 2019 19:00:12 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 15:50:14 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eb0ce0a78e1f57082bca6cbdea6fd04feedb876

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
