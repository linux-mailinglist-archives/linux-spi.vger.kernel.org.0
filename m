Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6363A6F
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2019 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfGISFL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jul 2019 14:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfGISFK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:10 -0400
Subject: Re: [GIT PULL] SPI updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695510;
        bh=ZsIWyGFwW/WH/1PRq35FPeD8inaeQ886pMe4Ngzy3TE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v716gG8LDisvi6QTCiBpTmpPYiYg45aBocXjk565tb1WuBUStmw/DNg2oWG53L0bU
         plwG6AR55uyE205iW/QUh0rLzYd4/AuMeetMgilrK/+RZfGxd4BZ6NQ+hitAgMnPyH
         qlh8gQHLC3rqMl3ppaUp+arlygbJgUxuy6nk/D00=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708124940.GB12731@sirena.co.uk>
References: <20190708124940.GB12731@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708124940.GB12731@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.3
X-PR-Tracked-Commit-Id: 26ac56506b0ea598bd0b52dcbd2d697282af98ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6b6cebbc597aaf7d941f781b5fc114c58cc3352
Message-Id: <156269551020.14383.15290822098573855750.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 13:49:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6b6cebbc597aaf7d941f781b5fc114c58cc3352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
