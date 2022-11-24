Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04C6379F4
	for <lists+linux-spi@lfdr.de>; Thu, 24 Nov 2022 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKXNaV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Nov 2022 08:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKXNaU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Nov 2022 08:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25247CDFE1
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 05:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C52F4B827F9
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 692D8C433C1;
        Thu, 24 Nov 2022 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669296616;
        bh=AAqIEdJ/xm+Z9oeclCTv20Xf2wQcdL4nGiyC6lqP/nM=;
        h=Subject:From:Date:To:From;
        b=RZyPTlPzHZFkauro3y4AJc2HrTBarmXpVp7+FuvnY+r3m9jwQUcHJjJYN5xvpthCt
         NPw9CwdWwFHMcwKZagIIEx/UptnPwRuqz9BbSqlf6cE3Cr7Wade4w4+tr7u2Lo2Aud
         3fAPVejcL32IAwTmCLxo1T6YYFPa5ZMis7f8jnSCKc1kD0aGTcYppjzxizdz4ZusOT
         0gLee56a/BLJdOzbbRCphkXZouPJc844sBSsNDCGhjzZI2j3DIp1sU3DLQ5ylQ/WKf
         hyAQioC5X4vEhlS2suPEVaXtJwmaLFr2PQllVywRUhy3TU3KwuXgRcjsU3qm3VabnW
         8oasvMCmcAkWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4681DE21EFD;
        Thu, 24 Nov 2022 13:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166929661623.20297.13754646624003859046.git-patchwork-summary@kernel.org>
Date:   Thu, 24 Nov 2022 13:30:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Introduce Socionext F_OSPI SPI flash controller
  Submitter: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=698711
  Lore link: https://lore.kernel.org/r/20221124003351.7792-1-hayashi.kunihiko@socionext.com
    Patches: [v3,1/2] dt-bindings: spi: Add Socionext F_OSPI controller
             [v3,2/2] spi: Add Socionext F_OSPI SPI flash controller driver


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


