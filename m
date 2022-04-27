Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE503512515
	for <lists+linux-spi@lfdr.de>; Thu, 28 Apr 2022 00:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiD0WNc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Apr 2022 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiD0WNb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Apr 2022 18:13:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBFDF8A
        for <linux-spi@vger.kernel.org>; Wed, 27 Apr 2022 15:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A08F6B82ADF
        for <linux-spi@vger.kernel.org>; Wed, 27 Apr 2022 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 677A0C385A7;
        Wed, 27 Apr 2022 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651097415;
        bh=bsx84rlr4xt8nwzUkzXnSb4NifBaAO6XSdzBusrHOF4=;
        h=Subject:From:Date:To:From;
        b=rNGyNAIw7pL1+4+94TJ1rzLHYTAMhmHdOXpgsl0QqCFQVoq8RtB3qpiDOYLAj6E8P
         QpAL5FE6pF0OUt4rhn2AskveDyOlD8yAqxGiWf0z4k/enB22ovFA7FfKGNp+G9R7/l
         N5sDCpY/not3QyVp3xReQbL5eSeLAsmc5ALlZpuFVZckpmNAsKkPnnGCDuq6jAXznM
         cKz85CB9OCJbg0ZZfrg1F26mAIruSU7kG7YoeKVqcsvDy6AC/oD4ZrLusv3bqpY5ZI
         q+0FvUaSSWxWeNQyLVJn+lcqSbAhMHHtP+fKsmPoiJ9OF+gYDL+lm5lFBRpFHPEx3K
         eOe271/wTxjQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BEC7E8DD67;
        Wed, 27 Apr 2022 22:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165109741518.8532.6412874355211583878.git-patchwork-summary@kernel.org>
Date:   Wed, 27 Apr 2022 22:10:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: add support for Mediatek SPI-NAND controller
  Submitter: Chuanhong Guo <gch981213@gmail.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=634989
  Lore link: https://lore.kernel.org/r/20220424032527.673605-1-gch981213@gmail.com
    Patches: [v6,1/5] mtd: nand: make mtk_ecc.c a separated module
             [v6,3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
             [v6,4/5] spi: dt-bindings: add binding doc for spi-mtk-snfi


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


