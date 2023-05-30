Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC57716B91
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjE3RuZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjE3RuY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 13:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA05B2
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 10:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F089861AD7
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 17:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F8BC433EF;
        Tue, 30 May 2023 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685469022;
        bh=J/aMyQojgNvHUdQBeaZrKWMGDxEYohMj/3UigZpvLLY=;
        h=Subject:From:Date:To:From;
        b=DUhnq7BKQVy9YHvZsPd4RtDd+f2i398GqzlYAKorAx0KqfTyE/HGUMs1kGbOezzj/
         xn1PJddLvACvxPcxU654NBM/aOI0Y9mNrjB3qKHuaOIe6BmKX8rG+QpDbbOh7ABkMG
         ibLStVYvqWv5sP8VJM9pRn7bOJ859I5O3/28/i4g04xFRDV6W1cnTEWUsgyb70BGwd
         zksc0oGtxbeYpuGsTlrmdFI6YmDzZJbS7iiV4wIaiG4W9uTLtlOJOGljIkMYP5dZd/
         MMj4qzrfw8/VnH+Oih73KbQnk8Sf7UE51cf4+zOquMF61ovhnp4k9fLQbgUgLdS2A0
         Ux1YjC0/XtjlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF88E52BF6;
        Tue, 30 May 2023 17:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168546902210.24129.8522546303674362083.git-patchwork-summary@kernel.org>
Date:   Tue, 30 May 2023 17:50:22 +0000
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

Series: spi: add SPI_MOSI_IDLE_LOW mode bit
  Submitter: Boerge Struempfel <boerge.struempfel@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752264
  Lore link: https://lore.kernel.org/r/20230530141641.1155691-1-boerge.struempfel@gmail.com
    Patches: [v7,1/5] spi: add SPI_MOSI_IDLE_LOW mode bit
             [v7,2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
             [v7,3/5] spi: spidev: add two new spi mode bits
             [v7,4/5] spi: spidev_test: Sorted the options into logical groups
             [v7,5/5] spi: spidev_test Add three missing spi mode bits

Patch: [v1] spi-dw-core.c: Fix error checking for debugfs_create_dir
  Submitter: Osama Muhammad <osmtendev@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=749515
  Lore link: https://lore.kernel.org/r/20230520224025.14928-1-osmtendev@gmail.com

Series: [1/3] spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
  Submitter: Lars-Peter Clausen <lars@metafoo.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=751709
  Lore link: https://lore.kernel.org/r/20230528195830.164669-1-lars@metafoo.de
    Patches: [1/3] spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
             [2/3] spi: spi-sn-f-ospi: Use min_t instead of opencoding it
             [3/3] spi: spi-sn-f-ospi: Make read-only array `width_available` static const

Series: spi: mt65xx: Convert to platform remove callback returning void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752079
  Lore link: https://lore.kernel.org/r/20230530081648.2199419-1-u.kleine-koenig@pengutronix.de
    Patches: [v2,1/3] spi: mt65xx: Properly handle failures in .remove()
             [v2,2/3] spi: mt65xx: Convert to platform remove callback returning void
             [v2,3/3] spi: mt65xx: Don't disguise a "return 0" as "return ret"


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


