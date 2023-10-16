Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283607CAD53
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJPPV3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjJPPV2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 11:21:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE9B4
        for <linux-spi@vger.kernel.org>; Mon, 16 Oct 2023 08:21:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81127C433C7;
        Mon, 16 Oct 2023 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697469686;
        bh=PzIlHBNnoh2Vyk+m1+bP2xBt+i6FAYvHtVuUiMcu6pQ=;
        h=Subject:From:Date:To:From;
        b=hHkcm1M7+4/3rr5PiJfTmq5mxHqdU+njDzFJ0ueVEA2s2SawObSYiIt1SMUKHbImq
         Hb1n1nz86C35xirEpwiChAkCFTsQ37GcsvgUdPOWcOWSSGvcVfWyLSJcDgTmXoDBIm
         xqbPH161QD1LIEscbs6O+ZHePRe13aNREzoFQ58ctrwnsvcHpjQ9FHaErvj/mJJNHb
         scXqCRST7Ss549W9yeuTSQ3y4iKR5F84hq2pud9QiQhuG72jNKtTvdS9TUjKrWEUbR
         Y1Rl82ynk1ghKKSLlBNgZEcPNevgG/EqML/jhbTQgOil7rSlRpBcqqj4b8DLsSAUJ4
         Lps4ansrThxDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F567C41671;
        Mon, 16 Oct 2023 15:21:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169746968638.27582.12370675355319196817.git-patchwork-summary@kernel.org>
Date:   Mon, 16 Oct 2023 15:21:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: nxp-fspi: use the correct ioremap function
  Submitter: Han Xu <han.xu@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=791928
  Lore link: https://lore.kernel.org/r/20231010201524.2021340-1-han.xu@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


