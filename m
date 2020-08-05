Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930FD23CDB0
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgHERll (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 13:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbgHERdO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:14 -0400
Subject: Re: [GIT PULL] SPI updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596648794;
        bh=Ygph5uU++bkFDZq+Z0NCpFq2qyszFtu0CEY6qDf+dew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gaoIR0bwnkY5bYk8fIb0rGKatYL9BbW+ne5AjRfckTE43yl8A0xq8g+uiGO8VMZNB
         Rp14Vv4lb9NpfRGOD3sEbObTLMimo1S/yuCakmQAonNK7L/gXrfEPL0DoRXheY6X9l
         Cpun6VlYhLZFTlk/Eeua0PXChVrzTpK69bG+Q/I8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803124114.2B1812054F@mail.kernel.org>
References: <20200803124114.2B1812054F@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803124114.2B1812054F@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.9
X-PR-Tracked-Commit-Id: 11ba28229f8258164731e42f4c3e93762cb6578e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b171373902b06d1b5a775de74178bf1527fee6cc
Message-Id: <159664879424.18421.2442649014891589713.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 17:33:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 03 Aug 2020 13:39:59 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b171373902b06d1b5a775de74178bf1527fee6cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
