Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBE4AE1E8
	for <lists+linux-spi@lfdr.de>; Tue,  8 Feb 2022 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385693AbiBHTKP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Feb 2022 14:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376631AbiBHTKO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Feb 2022 14:10:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F096C0613CB
        for <linux-spi@vger.kernel.org>; Tue,  8 Feb 2022 11:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CED1B81D2E
        for <linux-spi@vger.kernel.org>; Tue,  8 Feb 2022 19:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F047EC004E1;
        Tue,  8 Feb 2022 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644347411;
        bh=SYq1T4O1mp5gtv7AbgPwisgen7YRa0QvQCGLnUYS1O4=;
        h=Subject:From:Date:To:From;
        b=BPR7Xq3VDdq5NrOoIKTK7+0Db/F1eLEJUyUW5RVTOIoMjEdw69Vy9KQ/xMuYLOHUI
         NjaUlZ0wBrGT1f+NQyg+uWwe3HHZ8sSx+z7Mo092eS2jhdMI6ph65W3vHJM2oaV9PG
         cmdLk9ZfjMJGJPsR9W0WpO9CAip1zAjzYEm/N1s9LZD+Gv/gxYCGdjASVLvod+wAp6
         E3DWpg8W+erj6elUytelkqpW/eIRpjtmTz+xzwUPo8XBW1zOFaC1SU+45gbt/ArJSI
         96C1aioz6BksSvEXhw/iIL8nkjdWlR/L1AggTNtz+vVKvgzWkHfeEvsTDcYnWA/gD5
         VA95NePmZ0kaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7D2CE5D084;
        Tue,  8 Feb 2022 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164434741081.13912.15420994860958208221.git-patchwork-summary@kernel.org>
Date:   Tue, 08 Feb 2022 19:10:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [next] spi: Modify irq request position and modify parameters
  Submitter: Li-hao Kuo <lhjeff911@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=611692
  Lore link: https://lore.kernel.org/r/a94e3b123773fe303221d2bd2e4ce36ffa905a1c.1644198957.git.lhjeff911@gmail.com

Patch: spi: ath79: add mem_ops for fast-read
  Submitter: Luiz Angelo Daros de Luca <luizluca@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=609701
  Lore link: https://lore.kernel.org/r/20220129040453.8476-1-luizluca@gmail.com

Series: [1/2] dt-bindings: spi: Convert spi-mt65xx & spi-slave-mt27xx to json-schema
  Submitter: Leilk Liu <leilk.liu@mediatek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=603997
  Lore link: https://lore.kernel.org/r/20220110053744.30323-1-leilk.liu@mediatek.com
    Patches: [1/2] dt-bindings: spi: Convert spi-mt65xx & spi-slave-mt27xx to json-schema
             [2/2] dt-bindings: spi: Add compatible for Mediatek MT8186

Series: Add compatible for Mediatek MT8186
  Submitter: Leilk Liu <leilk.liu@mediatek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=608150
  Lore link: https://lore.kernel.org/r/20220125012330.13449-1-leilk.liu@mediatek.com
    Patches: [V4,1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
             [V4,2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
             [V4,3/3] dt-bindings: spi: Add compatible for Mediatek MT8186


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


