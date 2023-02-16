Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C37699D97
	for <lists+linux-spi@lfdr.de>; Thu, 16 Feb 2023 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBPUXp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Feb 2023 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBPUXo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Feb 2023 15:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0A2A6C2;
        Thu, 16 Feb 2023 12:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D50460B38;
        Thu, 16 Feb 2023 20:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CEC0C433EF;
        Thu, 16 Feb 2023 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676579023;
        bh=1FCwdhNCqGnLCfOcTXzf4LBYlsADYWnB3/flvoiKheQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qzg8WOgG7luNkPvv/kPoqch6/EPvcb+ZHS8dDWZMkt3ol7n6uMdmlUmwPqWC/aqDt
         L/s5o1RG5H9o/7lheuKoQOJZEWtobcEkSfq3S9AiuAS2MeU5i/A6zDEw+S3XvcZG11
         tsGeIH0ufJHbgZlkBf+4/TBBLe2ZN4Q1eWJ+30N/xco2g9lDimSsOvE5Ikc0MZDpBm
         mfp+Mtrao9xsYX75ytv00WXNcoHwPxfNkLQ3MDjRrfJzorJVwV2e+8pAHemiHXEtxI
         7m0oboiaWAI4Ked6O9VcdaSDSYD5zjsO+vXJqjGvLRiy32rjlo/6YmpU4A0pwJnNvn
         YpwNpCUo4xhCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3FDBE68D2E;
        Thu, 16 Feb 2023 20:23:42 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.2-rc8-abi
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230216163312.A26DEC4339C@smtp.kernel.org>
References: <20230216163312.A26DEC4339C@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230216163312.A26DEC4339C@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi
X-PR-Tracked-Commit-Id: f276aacf5d2f7fb57e400db44c807ea3b9525fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5596f1d545898de6d5cebe99692e6a205b61c92
Message-Id: <167657902292.10840.4459864409631753303.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Feb 2023 20:23:42 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 16:33:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5596f1d545898de6d5cebe99692e6a205b61c92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
