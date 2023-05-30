Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535047163D3
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjE3OWA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjE3OVc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 10:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089610D0
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2719462863
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 14:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83F16C433D2;
        Tue, 30 May 2023 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456420;
        bh=Cv4epQdwGrsPGeiPvmnoEUOujdyKLZtyHDjjkxClTgM=;
        h=Subject:From:Date:To:From;
        b=L8axquSca5lPGFvcXqR8WLBZoG4LFiI0ALOL9pk48TNIdgITx6PlopIS0MaqRwz0m
         NplIIkP39iM2v3Afc6fAXr4i76sFihFnDcEk5AVxQy3ljfL/2ANu1gSd4wHr6yluJN
         IbJLyMeyR5Iodg8AByGottqqmX7BaOgzG+zubRO1QZT18PXBecDbw5/EKctkzahOUJ
         WXZooJa3YrGZM0Q3ANQVFmJjyeBxMYVmLy9dA3qP1J6wpdf+RE3vArH+h+f0IOL9ZQ
         g56ZFQsXg1/od8AIUy5CLbdL8wYfefVZjZyY1cMfxqfxBnO/XJXwOBabXkpzeZ2kk7
         rTd6PQhh3eGsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C1BBE52BF6;
        Tue, 30 May 2023 14:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168545642027.31109.13694469822569519172.git-patchwork-summary@kernel.org>
Date:   Tue, 30 May 2023 14:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Patch: spi: qup: Request DMA before enabling clocks
  Submitter: Stephan Gerhold <stephan@gerhold.net>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748910
  Lore link: https://lore.kernel.org/r/20230518-spi-qup-clk-defer-v1-1-f49fc9ca4e02@gerhold.net


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


