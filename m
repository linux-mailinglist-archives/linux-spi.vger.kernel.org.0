Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB4704C83
	for <lists+linux-spi@lfdr.de>; Tue, 16 May 2023 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjEPLk1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 May 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjEPLkW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 May 2023 07:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E3D3588
        for <linux-spi@vger.kernel.org>; Tue, 16 May 2023 04:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3B46265B
        for <linux-spi@vger.kernel.org>; Tue, 16 May 2023 11:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F17C433D2;
        Tue, 16 May 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684237220;
        bh=srVugB8CtFKzoWtyVC+qKihOHhBhCGtBRLMGim2Y8mA=;
        h=Subject:From:Date:To:From;
        b=bseccWcZejKYssPqRKFootcDZ1qVYTXPIbOZKjvuXvwUNKFWeg3sEc/m5r0B/byim
         TlsCiTNdHZf8xu7mKOyeQHM0EVxtzUKyXZnRE17+e4cxWrW+hSG+JH5n1SWiISea+6
         Cc4PfPBC+4rrNCiMqymt1/EcMsPRzDDhCnl+Fr6G3pB3QAEsgdTHc95NaUJUSXBjgm
         yDXWgB2/1M7dKQjRf9JOvjx+G6wZh9HNjAVQrJ7QLwGZpJn+M2jloUOLb0mXxMMK0b
         phkYAOfYpcASbCyKTEyMbxX2odoVe/8C3FmN00c4nA6QK3E3Ah4WhSuWBENIAT/6y/
         GSIz5of1J1g2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EF77E5421B;
        Tue, 16 May 2023 11:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168423722016.19810.13078677999707659045.git-patchwork-summary@kernel.org>
Date:   Tue, 16 May 2023 11:40:20 +0000
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

Patch: spi: dw: Replace spi->chip_select references with function calls
  Submitter: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=747573
  Lore link: https://lore.kernel.org/r/20230515130343.63770-1-amit.kumar-mahapatra@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


