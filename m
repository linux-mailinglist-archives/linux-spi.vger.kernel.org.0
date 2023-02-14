Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9762696F27
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 22:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBNVUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjBNVUT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 16:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C909E
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 13:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400EF618F2
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 21:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5CD0C433D2;
        Tue, 14 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409617;
        bh=ZjD3ihB/VrGIJNz1pvszhZHfjzKFtfjh9ykwqSD0Tuc=;
        h=Subject:From:Date:To:From;
        b=ntT9VQuqlyQqVmzPzsAkcF0Z+VKk+888yRNaxCbCOZCVNZGMemfhqBbHxGVS+pqc7
         L+TCamX8Gd9OXstzIbiCD1mLZFDXR7TjywvVlWcD7dvuhCd0niAKByyXO5F0G85Cci
         Qwvxk6dxj9kBALYlk7C9OoQ5oG106A5iefnoqN/CE9r5b/ooA9SLOAxsKOCVfLtG5Z
         wVL76MlnP2vaaMc5W1UwHTGm84oBA9tBSCzw3WfX5zhA0JK/q7ASpXy7pCGPLx/Q5u
         WKwaHMeFBxxlwPCKxAAdVw1Vrvj2oz6RuN1YhOBWErUmScvOCes/GL3ZP8kx7MTPSC
         UP6WklRUqA2rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8107EE68D35;
        Tue, 14 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167640961746.1666.7238271632385101485.git-patchwork-summary@kernel.org>
Date:   Tue, 14 Feb 2023 21:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] dt-bindings: spi: spi-st-ssc: convert to DT schema
  Submitter: Alain Volmat <avolmat@me.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=721403
  Lore link: https://lore.kernel.org/r/20230213192349.17101-1-avolmat@me.com

Series: spi: cqspi: Fix register reads in STIG Mode
  Submitter: Gole, Dhruva <d-gole@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=708669
  Lore link: https://lore.kernel.org/r/20230104062604.1556763-1-d-gole@ti.com
    Patches: [1/2] spi: cadence-quadspi: setup ADDR Bits in cmd reads

Series: STIG Mode Fixes for spi-cadence-qspi driver
  Submitter: Gole, Dhruva <d-gole@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=715383
  Lore link: https://lore.kernel.org/r/20230125081023.1573712-1-d-gole@ti.com
    Patches: [v2,1/4] spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd r/w completion
             [v2,2/4] spi: cadence-quadspi: Add flag for direct mode writes
             [v2,3/4] spi: cadence-quadspi: setup ADDR Bits in cmd reads


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


