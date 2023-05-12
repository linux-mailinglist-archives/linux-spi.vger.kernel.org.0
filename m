Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E76FFFE8
	for <lists+linux-spi@lfdr.de>; Fri, 12 May 2023 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjELFaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 May 2023 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjELFaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 May 2023 01:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2B35A5
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 22:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0506B61461
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 05:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62DF4C433EF;
        Fri, 12 May 2023 05:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683869421;
        bh=xyBz0U9piSGMIbVlGQv5HuUX+OUX3TSW6buTeud0um4=;
        h=Subject:From:Date:To:From;
        b=RMeJnFMNqJxrpJ/MU9U/nv3Q9SxMenhj33N7jR/nw82BfdIv/iayqNKZNOY/yba6n
         HiOB9ypZVxqHayWn2khV44gHOQhttThKBl41ZFQOnPj47hfYh4xhBy5oXEuPf+UH6d
         C8mFsuyxqQXtZbg+6QQKXrnelIeEnKidnEF3fU796zVyzxwxg/MNxEe8+J8jYunFMM
         /1ubmDZvshlrfthE8X9EqMwZFnWKgP3q/vJcbvMT9W1Be4v+UXtIPvyStzw2ulBuY0
         D7vG1j47BFWNrzE5Y2ZRuEbcV1qHEvoeRyyg96fwJYKrKVk0arLF0MR45BsdaF1iEL
         JygNhbr2DnSPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37CCCE26D2A;
        Fri, 12 May 2023 05:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168386942115.8554.7989328136584525713.git-patchwork-summary@kernel.org>
Date:   Fri, 12 May 2023 05:30:21 +0000
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

Series: Allwinner R329/D1/R528/T113s SPI support
  Submitter: Maxim Kiselev <bigunclemax@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=746344
  Lore link: https://lore.kernel.org/r/20230510081121.3463710-1-bigunclemax@gmail.com
    Patches: [v5,1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
             [v5,2/5] spi: sun6i: change OF match data to a struct
             [v5,3/5] spi: sun6i: add quirk for in-controller clock divider
             [v5,4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


