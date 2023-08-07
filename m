Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C3772D29
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjHGRkq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHGRkq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 13:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4804CF9
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 10:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A2D61ACF
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 17:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F56BC433C7;
        Mon,  7 Aug 2023 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691430044;
        bh=ZqHFO32TblI/CyjLOZxyQuBibhianUiF6c3lfPcN+QI=;
        h=Subject:From:Date:To:From;
        b=p/LvP8syNxtrL7nyGmRBfnN9+/p3IH3+6/4PrRdgm5XhBMAzn1mtVtqp1eZ/WOs9B
         61HN217FpBJjZr0u1ruZG8/wGfBcxOfMJKntwIqi7uIWzMTAGqzCUOxIKRSVXY+zN4
         tc5fAjSx1yK72M6BRMcDNLj7tbcRmmDXJioB5rvBTZCSwaHqVVJiATP3kCUzlIQ/yK
         kPPC/Bo4pzzsyiJcYA47HZH6u4ZggzWnxFMePrrkB2KB0iUasxdm36Sn4rSX0Chj8A
         BwrkVNrNTEJJ7jaZvGaR0CE1OyKj0NX5FDnPeRCN6MgE9vNYBpxJQ+rzVJYyrTOk9E
         OO2BV92gSu+ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19A88E505D4;
        Mon,  7 Aug 2023 17:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169143004403.28736.7796533556600551625.git-patchwork-summary@kernel.org>
Date:   Mon, 07 Aug 2023 17:40:44 +0000
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

Patch: mtd: spi-nor: avoid holes in struct spi_mem_op
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=767530
  Lore link: https://lore.kernel.org/r/20230719190045.4007391-1-arnd@kernel.org

Patch: [-next] spi: Do not check for 0 return after calling platform_get_irq()
  Submitter: Ruan Jinjie <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772098
  Lore link: https://lore.kernel.org/r/20230802093238.975906-1-ruanjinjie@huawei.com

Series: update at91 usart compatible for sam9x60
  Submitter: Durai Manickam KR <durai.manickamkr@microchip.com>
  Committer: Arnd Bergmann <arnd@arndb.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=766797
  Lore link: https://lore.kernel.org/r/20230718065735.10187-1-durai.manickamkr@microchip.com
    Patches: [PATCHv3,1/2] dt-bindings: serial: atmel,at91-usart: update compatible for sam9x60
             [PATCHv3,2/2] ARM: dts: at91: sam9x60: fix the SOC detection

Patch: [-next] spi: spi-zynq: Do not check for 0 return after calling platform_get_irq()
  Submitter: Ruan Jinjie <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772110
  Lore link: https://lore.kernel.org/r/20230802094357.981100-1-ruanjinjie@huawei.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


