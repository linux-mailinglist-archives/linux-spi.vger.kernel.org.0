Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C12593276
	for <lists+linux-spi@lfdr.de>; Mon, 15 Aug 2022 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiHOPuS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Aug 2022 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiHOPuR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Aug 2022 11:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F8253
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 08:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1C060F6C
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 15:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C521C433C1;
        Mon, 15 Aug 2022 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578615;
        bh=8htwl6NkuSQZ+l+BFAvnek4IXYD28SOwN3l1ggrSJ8c=;
        h=Subject:From:Date:To:From;
        b=sCCLhIneP9di9Wff8sGZzWj5XBuypwGvtDeXX6asq08s+8+FQ8oETcsG+rjygcUrg
         4vgy3Kz70I6Y5fC/I76iZGiM17PUC4IZFo1v68JYTEp3hV9msroHoe6kxOEO/NuE6F
         dq6a8eR6Q8iHumMrNTEm7TTQ9ZrT3aRXPUHer5uIJa9KlRq7lpHLfD9iJrS4PVk8b3
         txVIibE3ICzVO8ItI0xwK/UtLYjgN+S36Sx0g4oEa4ovFm9CNLZHSllDvdZAejLAPA
         WqBj4IHOv3s2AHF0bNMG1V4WSWHuuXFhV3Kz8tOpM9uIwqjSVBEufKScxikmS4DF9L
         lVEHaRtXhpn4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA385C43142;
        Mon, 15 Aug 2022 15:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166057861482.9412.7588084433729561715.git-patchwork-summary@kernel.org>
Date:   Mon, 15 Aug 2022 15:50:14 +0000
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

Series: spi: npcm-pspi: add Arbel NPCM8XX and full duplex support
  Submitter: Tomer Maimon <tmaimon77@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=661789
  Lore link: https://lore.kernel.org/r/20220721101556.118568-1-tmaimon77@gmail.com
    Patches: [v1,1/2] spi: npcm-pspi: add full duplex support
             [v1,2/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible

Series: spi: npcm-pspi: add Arbel NPCM8XX support
  Submitter: Tomer Maimon <tmaimon77@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=662218
  Lore link: https://lore.kernel.org/r/20220722114136.251415-1-tmaimon77@gmail.com
    Patches: [v2,1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible

Series: Add support for Microchip QSPI controller
  Submitter: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=665972
  Lore link: https://lore.kernel.org/r/20220808064603.1174906-1-nagasuresh.relli@microchip.com
    Patches: [v4,1/4] spi: dt-binding: document microchip coreQSPI
             [v4,4/4] MAINTAINERS: add qspi to Polarfire SoC entry


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


