Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884D70F4D6
	for <lists+linux-spi@lfdr.de>; Wed, 24 May 2023 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjEXLLB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 May 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjEXLLA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 May 2023 07:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06848A3
        for <linux-spi@vger.kernel.org>; Wed, 24 May 2023 04:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9466663BB0
        for <linux-spi@vger.kernel.org>; Wed, 24 May 2023 11:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4CAC433D2;
        Wed, 24 May 2023 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684926659;
        bh=ouuugbMtoNZGoXO2PLc3sH0LiodCQJTUELhaMjeIP5Q=;
        h=Subject:From:Date:To:From;
        b=f2jFOyvH2w/ptR+X8clxRaC8B+iTXrxudXQRuU+9Z0NgdCNr/XPTKRaQe9RIH25dJ
         24iaQXOzs57GfT60mOG7pAETt7oAD5CVX8ahBBUsS65aOiNJtevqDyNuBuFpEQPr95
         L/X8XEb480uOjDNOYaZDGWYZXDwG354MDW9G8srmsHggYEaaHlCE403FrASLPwKyrD
         MUSj3KmQGpG3dnbVBuV1FU2oJbtRca+vGKhQgVQY1IavjtXt03mIjS8djl2zRU6Hoz
         DaCs5j5cfd1SWCZnVJb1yvjGh39ZOrjUuVtRlNo+hJanctSb5kfWc6g/fihEj7o/8Z
         y/4nGKVCAl7vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE711C4166F;
        Wed, 24 May 2023 11:10:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168492665870.30744.7560642437838597304.git-patchwork-summary@kernel.org>
Date:   Wed, 24 May 2023 11:10:58 +0000
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

Patch: spi: mt65xx: make sure operations completed before unloading
  Submitter: Daniel Golle <daniel@makrotopia.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=744210
  Lore link: https://lore.kernel.org/r/ZFAF6pJxMu1z6k4w@makrotopia.org

Patch: spi: lpspi: disable lpspi module irq in DMA mode
  Submitter: Clark Wang <xiaoning.wang@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=745180
  Lore link: https://lore.kernel.org/r/20230505063557.3962220-1-xiaoning.wang@nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


