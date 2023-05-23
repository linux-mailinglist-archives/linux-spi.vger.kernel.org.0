Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88070DF35
	for <lists+linux-spi@lfdr.de>; Tue, 23 May 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjEWOa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 May 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjEWOaY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 May 2023 10:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50722130
        for <linux-spi@vger.kernel.org>; Tue, 23 May 2023 07:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F2463322
        for <linux-spi@vger.kernel.org>; Tue, 23 May 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AC3C433D2;
        Tue, 23 May 2023 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852220;
        bh=VoG0+mup3+5mQpvYRv1nBgk5HpFHGS9XV/OP44UHikM=;
        h=Subject:From:Date:To:From;
        b=cBUTGh8DdAdnIstr+5WH2VsyQ4qpRj3gH+tCgpQcMdXJvnKxIjkIW+SHgBo0I+/vE
         HrEVNcIi2A43uEwypEsh1TK6wkpLBfQ5WYhQX5uUq0QGYNk6sgQoe25nKO6py7X617
         ssI+vXKLMK8bht6CLzO+GW8hmADas/UFY1QKZgpfLSno81q9t+RxqdrMzMyRPsAIz0
         KSWTJnMcm8DBJ+03TYhSqHWZH87sGDqQzUD0SspN81WHXXUIFHaSFlEX/jaSHZygEP
         XLTxOa17fwileFNMUxX2a1IUQco9tFnqWEttKtw/H5I4vdQYBhFFhju9CN0v9PWndf
         qLWvo+Kdo2arg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B73EE22AEC;
        Tue, 23 May 2023 14:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168485222009.20577.11420461200561516079.git-patchwork-summary@kernel.org>
Date:   Tue, 23 May 2023 14:30:20 +0000
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

Series: [v2,1/2] spi: spi-cadence: Interleave write of TX and read of RX FIFO
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748822
  Lore link: https://lore.kernel.org/r/20230518093927.711358-1-ckeepax@opensource.cirrus.com
    Patches: [v2,1/2] spi: spi-cadence: Interleave write of TX and read of RX FIFO
             [2/2] spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi

Patch: [v3] spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=750155
  Lore link: https://lore.kernel.org/r/20230523090124.3132-1-ckeepax@opensource.cirrus.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


