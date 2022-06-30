Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270EC561997
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiF3LuU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiF3LuT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 07:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668A340F0
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 04:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C29B82A2A
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 11:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7A9C34115;
        Thu, 30 Jun 2022 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656589816;
        bh=/xHo/5CgPF1bziZIjZa8CjNs0GyDlW/iXEB+BoUfBpY=;
        h=Subject:From:Date:To:From;
        b=p/ZkNe9y5h4zLHuDYmXrx9yk6cbBpNHo48Fa4mRxQSF7NBaKoH8okML3a7z394oOv
         cSKOG0l7N/3+YPdbtohZjYW8miUsQki1y49GHy5iI8O6cNyYL34wrSKH7PxrdKqt0b
         ZZuFTP5XDBDpp9uZPuWlhMC4DZoSzjb26hmx5m5tPCb2RkMH0Va+pnimRPL7gtxT3T
         d9Oj6XVMQ0KFsbtz9W4W2tkM6E0YAv6QCLLe11/u2SiQy/eKOYOTciWENwUq2sqkGT
         wOgc8tX9ZNPHMpHm656yIiSOEdXpOumavHiA1ZwfcJJOVT9az0PwoYm+xB0YdInsfx
         NOq7xgd6tsIbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1482EE49BBB;
        Thu, 30 Jun 2022 11:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165658981602.24632.13597398865917792129.git-patchwork-summary@kernel.org>
Date:   Thu, 30 Jun 2022 11:50:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: aspeed: Fix division by zero
  Submitter: Cédric Le Goater <clg@kaod.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=652857
  Lore link: https://lore.kernel.org/r/20220622161617.3719096-1-clg@kaod.org
    Patches: [v3,1/2] spi: aspeed: Add dev_dbg() to dump the spi-mem direct mapping descriptor
             [v3,2/2] spi: aspeed: Fix division by zero


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


