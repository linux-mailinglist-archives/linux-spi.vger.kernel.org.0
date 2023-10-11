Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3F7C5D45
	for <lists+linux-spi@lfdr.de>; Wed, 11 Oct 2023 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjJKTA0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Oct 2023 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJKTAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Oct 2023 15:00:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6413BD6
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 11:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7F68C433C9;
        Wed, 11 Oct 2023 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050225;
        bh=3ovjDi1IVBuqb3xr0zhWs6tE6XKMhPV39O/2qAoSdAY=;
        h=Subject:From:Date:To:From;
        b=X5XYE7xcVIJlSskh/Sv22iWxpdvR9Ot01nbBl8wMoLPG3C30yWGyPI8DeQnQ4PPfv
         0zIQdqzejy6r1xS/5MhwlEHJfsMEIgvF4q0jC5AbsV+ZfZxkX9JiQgcRFlhPmDfYAW
         KxbczPVU+w19IH9b0Q//VJ2SYhECM0kZBVe+X5O5k1ekOLCNKq1FKO3gnmRtcraGmx
         gxCZ/nPRX1zNFaimZ93sn/d6yEC3CDQNUUJp8ytGC/3hsyZpQ1OvxaZqhwcUpUn6bQ
         wOdRRY+6epbLG61h9AU5fBk8LsC5ZmfXH7754PkLsHIxo3TmZ6Kdn3grU5nQGbwT6z
         7yaDq0Y64SN4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94DEFC595C4;
        Wed, 11 Oct 2023 18:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169705022553.28799.4204286801588002481.git-patchwork-summary@kernel.org>
Date:   Wed, 11 Oct 2023 18:50:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Don't use flexible array in struct spi_message definition
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=791863
  Lore link: https://lore.kernel.org/r/20231010163100.89734-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


