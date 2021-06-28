Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36413B6830
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhF1STt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 14:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234917AbhF1STr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB06F61C3D;
        Mon, 28 Jun 2021 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624904241;
        bh=JIdfbQtvWQVbPgNSZpv8Fly1at/KjppDU8fR1h/qC9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bi1nKZ0kki3lujzbnCHDNovmZarMuqhiW5JSjKxHRteC+QrApYSxlqeyktg8fJiqQ
         xaWVbHGsbFQ1RRUpqk9W6D54X+pWDcappoTZFSOLaPDI03OrWn8iI8oaOwU5nJOpAx
         h0jIJXqWLoGhAx3GJSEl1LsuCT+xa9LZES7B3RxZiio2by9gjKORUVJ6P6TVZYeTJf
         eiFkXLXHWxd1GivNkP1L+tRzATj2GD94Igg33j7B/Tu23mPKY2nO8qHRTCJJGa39LJ
         snIc+rXqj4dMdNKwSgqJT2JjabO8jhaNfhoiDANwiyZmuMXGn+Tp1gV1PNRIqF8DHl
         7G3A08K7r5KGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3CA460A71;
        Mon, 28 Jun 2021 18:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628145522.BE31F61353@mail.kernel.org>
References: <20210628145522.BE31F61353@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628145522.BE31F61353@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.14
X-PR-Tracked-Commit-Id: 1bee1ecf232cd90ad112d78ab5124850b4e5ea09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69609a91ac1d82f9c958a762614edfe0ac8498e3
Message-Id: <162490424179.3852.15619770622263280854.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:17:21 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 15:54:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69609a91ac1d82f9c958a762614edfe0ac8498e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
