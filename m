Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00275072F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 13:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjGLLxd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jul 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjGLLxW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jul 2023 07:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868B2708
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 04:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02BBE6179D
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 11:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 623A1C433C8;
        Wed, 12 Jul 2023 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162643;
        bh=24HbgN/JgVhegFv1VsxI0w0h3374e6wSTu0fDfmE+Do=;
        h=Subject:From:Date:To:From;
        b=NdHZipIM/CMC39eadH0Ybjg6A78RjqT8CNqiD/rKzkamh/JB0DlB1lE7tWPmZJqnE
         f8wHIJqG9+x5bBQi+Rh0yHQD98kCriPsH0JSA3WZMWWdXOg+ARliXyXvMxc5yZfwnw
         7IXuC1FwjhOx9V/d3eEEkG/Ky+JS2AbKwtUMg6t3xnJ/AYrGzu/mcqG+SQ6Gk6p1/D
         Mjxwlr8M+X7CFJSt1V74tgN070Gn26euq+P16jBA4EdQxBqYoXLBoZcpDBBx8c4krG
         yyA3afT2oAB9D1puQcfSWCMW7QuHwP56FkCRPix6W/IXCPZZa7OJlZ3Lp6L5hl51Dx
         scm8Lpbc8LsMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D04CC04E32;
        Wed, 12 Jul 2023 11:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168916264309.31068.11033619336965006330.git-patchwork-summary@kernel.org>
Date:   Wed, 12 Jul 2023 11:50:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Series: spi: Header and core clean up and refactoring
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=764528
  Lore link: https://lore.kernel.org/r/20230711171756.86736-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,01/14] spi: Remove unneeded OF node NULL checks
             [v3,06/14] spi: Use sysfs_emit() to instead of s*printf()
             [v3,10/14] spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
             [v3,11/14] spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
             [v3,12/14] spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
             [v3,13/14] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX

Series: spi: amlogic-spifc-a1: fixes and improvements for amlogic-spifc-a1
  Submitter: Martin Kurbanov <mmkurbanov@sberdevices.ru>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=763047
  Lore link: https://lore.kernel.org/r/20230706110331.19794-1-mmkurbanov@sberdevices.ru
    Patches: [v2,1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
             [v2,2/2] spi: amlogic-spifc-a1: add support for max_speed_hz

Series: Allwinner R329/D1/R528/T113s Dual/Quad SPI modes support
  Submitter: Maksim Kiselev <bigunclemax@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759986
  Lore link: https://lore.kernel.org/r/20230624131632.2972546-1-bigunclemax@gmail.com
    Patches: [v1,1/3] spi: sun6i: add quirk for dual and quad SPI modes support
             [v1,2/3] spi: sun6i: add dual and quad SPI modes support for R329/D1/R528/T113s


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


