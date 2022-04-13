Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7289C4FFCFE
	for <lists+linux-spi@lfdr.de>; Wed, 13 Apr 2022 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiDMRnA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Apr 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiDMRmf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Apr 2022 13:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A3B87C
        for <linux-spi@vger.kernel.org>; Wed, 13 Apr 2022 10:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3C061EE5
        for <linux-spi@vger.kernel.org>; Wed, 13 Apr 2022 17:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27337C385A4;
        Wed, 13 Apr 2022 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871613;
        bh=N/On44+lxEN31t+WbCW49VsTIudN10OV1xrJcUDf1JU=;
        h=Subject:From:Date:To:From;
        b=XhxPBHeI3GCDQsSyMi/Ffm3JqFZ/HukhZE5Kk3UypoXHJA0O/fujgfrMAcfJjnjpz
         FGHGwdA/71qpmg091qCWuDXV9LZKrE0DYdWYaYCSaLCD87WLMR4VC7aH8AW4FFfmfb
         iaRByW0fJ/9DGbRZOEWZtLj0p0J9QQ0ThuPwERoGl4nZEzL9qakcXsml69CwgxBIhU
         UY3aphcxEjJoEjaw1+4rBIwoLn81Ig5b3iVvKrd9kCpLmXeuPhMRsCjY3pEsw4cBrY
         H/jEp/+hFrM07EUYIyBm5hoEV8Wy8c96p9felMOavooY8ZsOpPdwV/AQNEBXFAFiAV
         iIhvhZRecUcDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 038E2E73CC8;
        Wed, 13 Apr 2022 17:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164987161295.7120.8905794310101546182.git-patchwork-summary@kernel.org>
Date:   Wed, 13 Apr 2022 17:40:12 +0000
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

Series: [1/2] spi: atmel-quadspi.c: Fix the buswidth adjustment between spi-mem and controller
  Submitter: Tudor Ambarus <tudor.ambarus@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=629550
  Lore link: https://lore.kernel.org/r/20220406100340.224975-1-tudor.ambarus@microchip.com
    Patches: [1/2] spi: atmel-quadspi.c: Fix the buswidth adjustment between spi-mem and controller
             [2/2] spi: atmel-quadspi: Remove duplicated DTR checks

Series: [v2,1/2] spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller
  Submitter: Tudor Ambarus <tudor.ambarus@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=629606
  Lore link: https://lore.kernel.org/r/20220406133604.455356-1-tudor.ambarus@microchip.com
    Patches: [v2,1/2] spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller
             [v2,2/2] spi: atmel-quadspi: Remove duplicated DTR checks


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


