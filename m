Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1057389D
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jul 2022 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiGMOUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jul 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiGMOUR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jul 2022 10:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D704C32EE4
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 07:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F8561DBE
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 14:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6C6FC34114;
        Wed, 13 Jul 2022 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657722014;
        bh=MG88yyYpis9fnA5ZQNCCGHuLpAWcJ+Mv2XPv1uC4T4g=;
        h=Subject:From:Date:To:From;
        b=JENgaeAKTTKxhX77FEjdfThAEuo8X0B/KVoMYSaKyPbe7alG6bB6Ccd8admS2YmEO
         WsUtB1QKjF93r09ONTw83FPCaAJOStuM3bu4VWOxGgyPOfmMlDG2bcdlkhIljqLlBX
         pMay1av83YKoY7HM0qeIHjlyfZLlsQIFTXNmbs4pc/+UmMZ/Z5dCqUA+wfAGIxPws4
         4xU0KxUaaNAuG7QFI24+m7BF1cNQo4Uu9auiO5SfwUtzHBHXFqDwq5iKddCUbIPdxg
         kAiVZ6xF+EXRKo4/880Tl51VJ9/dkL+KXNDNF/GJO49msOIhnvYQQvVecKPQe1o9uv
         p+RMjEbNFDuDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C983E4521F;
        Wed, 13 Jul 2022 14:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165772201458.25730.10518886017941537539.git-patchwork-summary@kernel.org>
Date:   Wed, 13 Jul 2022 14:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: [-next,1/2] spi: microchip-core: fix UAF in mchp_corespi_remove()
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=658926
  Lore link: https://lore.kernel.org/r/20220712135357.918997-1-yangyingliang@huawei.com
    Patches: [-next,1/2] spi: microchip-core: fix UAF in mchp_corespi_remove()
             [-next,2/2] spi: microchip-core: switch to use devm_spi_alloc_master()

Series: spi: microchip-core: fix and cleanups
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=659120
  Lore link: https://lore.kernel.org/r/20220713025657.3524506-1-yangyingliang@huawei.com
    Patches: [-next,v2,1/3] spi: microchip-core: fix UAF in mchp_corespi_remove()
             [-next,v2,2/3] spi: microchip-core: switch to use devm_spi_alloc_master()


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


