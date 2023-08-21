Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2E7834AF
	for <lists+linux-spi@lfdr.de>; Mon, 21 Aug 2023 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHUVK3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHUVK2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 17:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED465113
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 14:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA5161877
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D876DC433C8;
        Mon, 21 Aug 2023 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692652225;
        bh=P4Iqx9sxniOF0J6drECfLlIf2huwgK7EVMGbS0HtPvU=;
        h=Subject:From:Date:To:From;
        b=WYRz7gse7VhOT+UIinpMUTPeDEirGPoQa7rd0G8Hfs6WXAk0G+Qfv/0A4GH/ly+s0
         eC6LwNek18Au+SbRbMfQiIla8UeD6nhniDiheS6MFKjEhsSjb9JBOc8mR07W4Yfigi
         7JeCjU71gcl6akzmhdxbBfX5k40duBIOijFMtUKKkToGso5+85kZz8bynmx+Fk4sxk
         59CkX4bbI1aHoiVdzs9+/4j1hFRHJoZJ+majcXzCC+UtZlgVoWxJlF4wQFG2Np8lwU
         6bFpC8aK8PPkdn71xpvAdDSpX0btVCR5MXckdFmT9Nc+T4W6BZOFoDi8pWNJ1JSwjs
         6dj+mbSNrWSiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0074E4EAF9;
        Mon, 21 Aug 2023 21:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169265222561.31376.1990190615108270089.git-patchwork-summary@kernel.org>
Date:   Mon, 21 Aug 2023 21:10:25 +0000
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

Patch: spi: stm32: fix accidential revert to byte-sized transfer splitting
  Submitter: Leonard Göhrs <l.goehrs@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=776673
  Lore link: https://lore.kernel.org/r/20230816145237.3159817-1-l.goehrs@pengutronix.de

Patch: spi: spi-cadence: Fix data corruption issues in slave mode
  Submitter: Srinivas Goud <srinivas.goud@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=777833
  Lore link: https://lore.kernel.org/r/1692610216-217644-1-git-send-email-srinivas.goud@amd.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


