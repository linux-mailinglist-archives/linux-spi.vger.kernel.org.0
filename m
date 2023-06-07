Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4672675B
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jun 2023 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjFGRaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jun 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjFGRa0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jun 2023 13:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D22100
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 10:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73EA63BC1
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4777AC433D2;
        Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159023;
        bh=4/4YGfWPnAH1CPeK7jx5pJdwbOTtHWDhpjmmb8LiUNA=;
        h=Subject:From:Date:To:From;
        b=q96scMYE4Rl2CovK8WCjn8++Wghz6ei25hAPCfXXpQr0JjBnnGO/tciQQ1GTJkqkO
         l6Krg9AdE1ggouKgRmyrPpdjgipxB/aFqGsyGu7ccL3yL7BYGNPkfbkGVbLPaUx68s
         9WiXhevyBcKSgmi0AojD0ObLHGhDOGIX7SX1zBsjWcdsWIp/u1f627GE3uh8OWt0o/
         eXEytxOdlhUGg/KEWTemnWhMCP6w4nGjgG8jrv7VK0pce28m8fh9AApghnmNM0abVB
         5LIfBpAa8PeXefryAq5VHAWNfFLk315HWM/D9UP3oND21SsXPgKH7Hx+DPfPuyoclQ
         WnENtIg2hU4Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22F03E29F37;
        Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168615902308.7521.8564491970447190431.git-patchwork-summary@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: s3c64xx: Cleanups
  Submitter: Andi Shyti <andi.shyti@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754228
  Lore link: https://lore.kernel.org/r/20230606012051.2139333-1-andi.shyti@kernel.org
    Patches: [1/2] spi: s3c64xx: Use the managed spi master allocation function
             [2/2] spi: s3c64xx: Use dev_err_probe()

Patch: spi: dw: Remove misleading comment for Mount Evans SoC
  Submitter: Abe Kohandel <abe.kohandel@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754661
  Lore link: https://lore.kernel.org/r/20230606231844.726272-1-abe.kohandel@intel.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


