Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C0549D38
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jun 2022 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiFMTQj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jun 2022 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbiFMTQF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jun 2022 15:16:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D924505F
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 10:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BFD91CE168C
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38563C34114;
        Mon, 13 Jun 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655141414;
        bh=rn47xVZEbVzXsn6OdMRGUERt7bE2k1H2tAKQYJR0Amw=;
        h=Subject:From:Date:To:From;
        b=EU9wBEk2yx5QxYQ5Ni9WZb6k35SAKQEt1cpJZ6yNo/rPvBbuktt2XPTaMtQDA9Eja
         avzblTEUKExCJjcu0x/9oPYEcLK27zuVgkMYUE24pAfv9fvBEazP6isPEDaIPei45K
         fKNrAF8HgL/NQQTx1fTZW73mVkd4e3iSK+o1jBD8/MvWnz51HEOfgRSlWHUsEA5CZM
         IC1IyT4i8K9dlS+dAS6uEAu0rsxqoGSkSjyjPIsN1+m9Jr/X95nZQp3DqPJLOn8xEc
         tW2hbjHxw+wAPkIRYPgYcfvVR38bBjijPpr9pHnFNtXtUXvvsOuLihm2pPP5qz2m2M
         8ZDzFQ+B+quuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11561FD99FF;
        Mon, 13 Jun 2022 17:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165514141401.4004.13319266983602765802.git-patchwork-summary@kernel.org>
Date:   Mon, 13 Jun 2022 17:30:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: tegra quad: Add Tegra Grace features
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=647988
  Lore link: https://lore.kernel.org/r/20220607114659.54314-1-kyarlagadda@nvidia.com
    Patches: [V3,1/3] spi: tegra210-quad: Multi-cs support

Patch: spi: micro: fix unreasonable clk_prepare_enable() on error in mchp_corespi_probe()
  Submitter: Peng Wu <wupeng58@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=649471
  Lore link: https://lore.kernel.org/r/20220611021117.40494-1-wupeng58@huawei.com

Patch: spi: microchip-core: Fix the error handling path in mchp_corespi_probe()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=649492
  Lore link: https://lore.kernel.org/r/a90bec10dec43719b12afdb967e87526c4bc849a.1654933052.git.christophe.jaillet@wanadoo.fr


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


