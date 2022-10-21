Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC07607B70
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJUPrk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJUPrQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 11:47:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834CBEA
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 08:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31DBEB82C54
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 15:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7864C433D7;
        Fri, 21 Oct 2022 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666366818;
        bh=1/ASgLUJiguIgJQeaFb6ecECX8sTn8mw+kc7J+DocSI=;
        h=Subject:From:Date:To:From;
        b=Q+OoBS3Wg6H+vEwKMocDZhJnVhLRTkrrgXozn5WDGzkbZx8NAMQ+9vxvZkY3csDwO
         2XhYzC1jottrmlqgtAYaCbpiCMu3bQSy6NjDbojKc/32FLG1sPhQ61d8hUkvKCAKuG
         T0dqnmNGiSLpj+R6bldcWxEzRSA7GFlKX6+X7SmAdv1x3R8LS7ycob6WG2k3ZM619n
         VBqZe4k1tTpH4E4kXn7Q+LjRyT/lJ9D58XSpaRMYWSDf1gIXXSWaVADN+9e4BIFTtv
         eHFCHeXy2eU73HlMWygun7AmOAtZNgo5JTdwwSkp781y24S0CPzLj1wmQz0+ZF5Zb4
         mBOL3Userpf2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1474E270E0;
        Fri, 21 Oct 2022 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166636681870.12101.17608614881182132104.git-patchwork-summary@kernel.org>
Date:   Fri, 21 Oct 2022 15:40:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: pxa2xx: Pass the SSP type via device property
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=687271
  Lore link: https://lore.kernel.org/r/20221020194500.10225-1-andriy.shevchenko@linux.intel.com
    Patches: [v4,1/5] spi: pxa2xx: Respect Intel SSP type given by a property
             [v4,4/5] spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
             [v4,5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


