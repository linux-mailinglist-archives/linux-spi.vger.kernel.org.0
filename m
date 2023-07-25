Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CCE7623AC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGYUkv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGYUkr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 16:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997C2D47
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B80618E5
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E782AC433C7;
        Tue, 25 Jul 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690317621;
        bh=TOgzXuEWFwzUX0nC3uKU/7Wgw268bZZUto/0H0qFYD8=;
        h=Subject:From:Date:To:From;
        b=NXe7KJarTKcwaCpdy9pYPQsGdjtWDg5gl8NtlS2qjxp0+I1mhB2Adv81ZGrY0cq8h
         zjed2ErAAgGMnRtK5wfysUxBLyf+048ZkCKzXWPL/VxGATdz8QVDNZ5Lpfkl9koQ24
         6eS54m+c5kHDwJP7RPk1p6VPu168g+rfy0X7/mvQ3vrcWDctLq/Q5eKp0EJbvDX8ju
         Trl8eAXhfrRNL1Kujdea49E4/GW1NEsfjnhHluR+Pzvs55V7z+SzEa0oaJrTL3SnN6
         ukmbwrIUXMV3K4+A1WryUfhPyZ2OAdcsGTc2fJxhCYaq2ts9HNmevTjuDcLhPnJte+
         ZSK2/izhOEoOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C58E5C4166D;
        Tue, 25 Jul 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169031762172.16140.4138462028600228567.git-patchwork-summary@kernel.org>
Date:   Tue, 25 Jul 2023 20:40:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: spi-qcom-qspi: Follow-up patches to DMA mode support
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769274
  Lore link: https://lore.kernel.org/r/1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com
    Patches: [1/4] spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
             [2/4] spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for descriptor
             [3/4] spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
             [4/4] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


