Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24239FD4B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhFHROM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 13:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhFHROK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 13:14:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F209461351;
        Tue,  8 Jun 2021 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623172337;
        bh=B4O7yQ0/4TBID+j1wZoztoIY4tyUDWiPpKQrwT9JCHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oO/S9gQGBovB8n5kTY49MgIEK+EtHVaYzq3E5xdTSxQQztrGenHniJP00S4kFU7pB
         VPS90VctjCKPWJ4OvOlYIfnAJJrL6apR2gklKz3/HDB1tk9GaDNmQ602v2ZrHpWvIs
         qZEljBt2SIBLdCtkEhaRY7AQhAs8CbWh5phgsq/u9qlFciOukBtB5f+qYHuXpsoI2m
         7iRkowwomJv6wp1VKDIATni8Vu2V+rHBGN1eJAfh+mqAlSo8NgjVln/lQVKEHOWy7d
         ITtVA1cx97o+SfqW+fH7y8RCmOvgZ7jF0S3s45XJtIYmuhRCy0A2ICiPTTAfKvJ+ph
         WKW4+Zi4yg1xg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E5FF9609D2;
        Tue,  8 Jun 2021 17:12:16 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210608142723.07F3861003@mail.kernel.org>
References: <20210608142723.07F3861003@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210608142723.07F3861003@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc4
X-PR-Tracked-Commit-Id: d38fa9a155b2829b7e2cfcf8a4171b6dd3672808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c8684fe555e95100030bd330d0a2780ac27952e
Message-Id: <162317233693.10366.18435776241130124675.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Jun 2021 17:12:16 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Tue, 08 Jun 2021 15:26:54 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c8684fe555e95100030bd330d0a2780ac27952e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
