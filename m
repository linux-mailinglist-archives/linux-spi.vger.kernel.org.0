Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2E75B700
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jul 2023 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGTSkZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jul 2023 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGTSkY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jul 2023 14:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746441734
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 11:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0910861BD6
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E369C433C7;
        Thu, 20 Jul 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878422;
        bh=HgKww3UGB+DMgar9XAOwoqZLWPqowP/pCjpzQUsFTfs=;
        h=Subject:From:Date:To:From;
        b=Pqrv8s7TlBQPrG+aKy0C2E9A6iWKZzxhKFvh0Whmjz/Yg/pR/4TPX6sp0igu42glI
         5METvnz12wX4zCsYvUl6DvJCuZelP5lsz2K29ruxn3ob7jfyVwjtoEyTTCc8uLyIs2
         l9K3CqcdsLcerWH7pgRNPsrOOTR+r0JkyIKD2ApkqsP7RogcejSdTtzNkzGTX1GEEC
         4DpTp/bFwTIBLW2aExfCxIgjXtIC12N4GXNRQWjRvyWg/fJXymmR4NjjNYFbpB+a2r
         PKNYm77A2a8HbRjQi2ajoYJmnpiHVl3BLncsuO72SXlhQvnocCRWzlB9FODCNESin0
         DQ0/dNuPB+E/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FC53E21EF5;
        Thu, 20 Jul 2023 18:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168987842210.31995.13572985414937110112.git-patchwork-summary@kernel.org>
Date:   Thu, 20 Jul 2023 18:40:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: use devm_clk_get_enabled() in mcfqspi_probe()
  Submitter: Yuanjun Gong <ruc_gongyuanjun@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=767849
  Lore link: https://lore.kernel.org/r/20230720140909.34084-1-ruc_gongyuanjun@163.com

Patch: [1/1] spi: fix return value check in bcm2835_spi_probe()
  Submitter: Yuanjun Gong <ruc_gongyuanjun@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=767850
  Lore link: https://lore.kernel.org/r/20230720140859.33883-1-ruc_gongyuanjun@163.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


