Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8077320A
	for <lists+linux-spi@lfdr.de>; Tue,  8 Aug 2023 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHGWAd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGWAc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 18:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8317F8F
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 15:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDDD62279
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 22:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75449C433C8;
        Mon,  7 Aug 2023 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445630;
        bh=db4oguOb7dX56O5JpzObxDLht5Cbkci6neyXM07EoFI=;
        h=Subject:From:Date:To:From;
        b=V5MsZMIDKKH/5V2ucZEkv1T3VesnAjUjyceXdlQvKH+HtPuft1BJw4gw2sJ/3ykuo
         bIpkNmntEPuUO4zKgsbyBje06lvlZk0tWiwvn8ahg/Ws5sOyQ8w5iVRTnxIiMHcyIm
         VrGq18ddoLErWSE/ZP8QdUfSRKrasJh3U3OFs41y9mKUFtcoK0KrNYFRoU5EUy+tYy
         02/++Y7/J1Jl2FwbT4o0lsD/KyaabsloWQ+Bne3PngYVaCV0e3aZ9rIrBeE9qrMRXA
         W5iSCVpdIyxjEwu41xRwC+gWmRmVO2nxUsTUXGPHIEMYiKmEl45ArAoTvP68ZPigJR
         ftZNAjg8MLVbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AF45E505D5;
        Mon,  7 Aug 2023 22:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169144562924.5917.15262276655913168786.git-patchwork-summary@kernel.org>
Date:   Mon, 07 Aug 2023 22:00:29 +0000
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

Series: spi: switch to use modern name
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=770496
  Lore link: https://lore.kernel.org/r/20230728093221.3312026-1-yangyingliang@huawei.com
    Patches: [-next,01/21] spi: amd: switch to use modern name
             [-next,02/21] spi: aspeed: switch to use modern name
             [-next,03/21] spi: spi-axi-spi-engine: switch to use modern name
             [-next,04/21] spi: bcm-qspi: switch to use modern name
             [-next,05/21] spi: bcm2835: switch to use modern name
             [-next,06/21] spi: bcm2835aux: switch to use modern name
             [-next,07/21] spi: bcm63xx-hsspi: switch to use modern name
             [-next,08/21] spi: bcm63xx: switch to use modern name
             [-next,09/21] spi: butterfly: switch to use modern name
             [-next,11/21] spi: cadence-xspi: switch to use modern name
             [-next,12/21] spi: cadence: switch to use modern name
             [-next,13/21] spi: clps711x: switch to use modern name
             [-next,14/21] spi: octeon: switch to use modern name
             [-next,15/21] spi: spi-cavium-thunderx: switch to use modern name
             [-next,16/21] spi: coldfire-qspi: switch to use modern name
             [-next,17/21] spi: davinci: switch to use modern name
             [-next,18/21] spi: dln2: switch to use modern name
             [-next,19/21] spi: dw: switch to use modern name
             [-next,20/21] spi: hisi-kunpeng: switch to use modern name
             [-next,21/21] spi: npcm-fiu: switch to use modern name

Series: spi: switch to use modern name (part1)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773708
  Lore link: https://lore.kernel.org/r/20230807140717.3484180-1-yangyingliang@huawei.com
    Patches: [-next,v2,01/21] spi: amd: switch to use modern name
             [-next,v2,02/21] spi: aspeed: switch to use modern name
             [-next,v2,03/21] spi: spi-axi-spi-engine: switch to use modern name
             [-next,v2,04/21] spi: bcm-qspi: switch to use modern name
             [-next,v2,05/21] spi: bcm2835: switch to use modern name
             [-next,v2,06/21] spi: bcm2835aux: switch to use modern name
             [-next,v2,07/21] spi: bcm63xx-hsspi: switch to use modern name
             [-next,v2,08/21] spi: bcm63xx: switch to use modern name
             [-next,v2,09/21] spi: butterfly: switch to use modern name
             [-next,v2,10/21] spi: cadence-quadspi: switch to use modern name
             [-next,v2,11/21] spi: cadence-xspi: switch to use modern name
             [-next,v2,12/21] spi: cadence: switch to use modern name
             [-next,v2,13/21] spi: clps711x: switch to use modern name
             [-next,v2,14/21] spi: octeon: switch to use modern name
             [-next,v2,15/21] spi: spi-cavium-thunderx: switch to use modern name
             [-next,v2,16/21] spi: coldfire-qspi: switch to use modern name
             [-next,v2,17/21] spi: davinci: switch to use modern name
             [-next,v2,18/21] spi: dln2: switch to use modern name
             [-next,v2,19/21] spi: dw: switch to use modern name
             [-next,v2,20/21] spi: hisi-kunpeng: switch to use modern name
             [-next,v2,21/21] spi: npcm-fiu: switch to use modern name

Patch: [v2] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769983
  Lore link: https://lore.kernel.org/r/20230727070806.12205-1-jonas.gorski@gmail.com

Patch: [v2] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative
  Submitter: None <coolrrsh@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773729
  Lore link: https://lore.kernel.org/r/20230807144942.30317-2-coolrrsh@gmail.com

Patch: [-next] spi: omap2-mcspi: remove redundant dev_err_probe()
  Submitter: Zhu Wang <wangzhu9@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=771702
  Lore link: https://lore.kernel.org/r/20230801135442.255604-1-wangzhu9@huawei.com


Total patches: 44

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


