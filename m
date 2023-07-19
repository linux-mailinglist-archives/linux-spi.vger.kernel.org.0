Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB33759A7D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jul 2023 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGSQKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jul 2023 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSQKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jul 2023 12:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D97119
        for <linux-spi@vger.kernel.org>; Wed, 19 Jul 2023 09:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE81E6173F
        for <linux-spi@vger.kernel.org>; Wed, 19 Jul 2023 16:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00BB4C433C8;
        Wed, 19 Jul 2023 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783023;
        bh=uZLtTx6mLmh0NWAMbqFTGYL6aQG3FpP8P1YtRC9ER4A=;
        h=Subject:From:Date:To:From;
        b=cIwjIKxloxVQp9+KgZGBSSFX/cigKiqV5BYFqr7aESvrdpSfHWbW/XzJOhSRiWiqh
         Kj25XjbtodmKslzTauHbQn7rD42TtUaDSFCuffbyU0kVj0YfsrjfixtmOPL9j+6Dfi
         pCV7lsUR2CBmsIMVlDlBAylwxK1JLEmPgt/WkUDNHvRpGyJ1r2LHnZZc7z0IwWvxSN
         hbD50f/58E3lNPQuoR3Y7Pg28CRScNx4zE2vOK4jczKmLCgfA69leU0E8eu1QPGzT1
         ppw9oE8Dl/GzvPBjpdD/t9mLDMvGXJOZo9+O00POcQXQdULvEmGowO8VfVHTGzlelX
         hnvkunRidxmsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C59A5C6445A;
        Wed, 19 Jul 2023 16:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168978302268.27068.788919191666288808.git-patchwork-summary@kernel.org>
Date:   Wed, 19 Jul 2023 16:10:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: rzv2m-csi: Code refactoring
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=767032
  Lore link: https://lore.kernel.org/r/20230718192453.543549-1-fabrizio.castro.jz@renesas.com
    Patches: [v2,1/4] spi: rzv2m-csi: Squash timing settings into one statement
             [v2,2/4] spi: rzv2m-csi: Improve data types, casting and alignment
             [v2,3/4] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
             [v2,4/4] spi: rzv2m-csi: Make use of device_set_node


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


