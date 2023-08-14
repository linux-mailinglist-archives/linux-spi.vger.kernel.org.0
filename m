Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105877C345
	for <lists+linux-spi@lfdr.de>; Tue, 15 Aug 2023 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjHNWLE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Aug 2023 18:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjHNWKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Aug 2023 18:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF6D1
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 15:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F9662C24
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 22:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2006C433C7;
        Mon, 14 Aug 2023 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692051036;
        bh=pZk7mMqHDy+24dFNRFggpBn1tXuF04cl0ao3R0f/ejE=;
        h=Subject:From:Date:To:From;
        b=jvNhibRTtYpZI/qaUZt5UInDVa2gePqE/intHm2C1UphMFMmd1jsq+dHp0VSixNWq
         ajUUIzhz5fSrRkc/NaMiikBjPLTSjodM78p6UYEctkZLMOojdbS40L2Oz3htSiQLcc
         0fvU0VokHqTmYTAABNOmN2oeP/q9Re1BO24sbQq1zJV08ZA/UsOgQDTRFwt+JVY1BS
         u/ph4ITm6jtpSV66qVBLZSvHuV6v9Xe8KJk8KteynQG/3fEpF91rYW1Byv5npfIKI6
         D8UvlgMq/SEijMVsmJKtfdN9BrSjFWIy3vbE2ds+VhrWKB3dUdFCi2mNooIciQPfaT
         CaGUJrJ0HIWPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82284E93B32;
        Mon, 14 Aug 2023 22:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169205103647.17980.13265199073054355762.git-patchwork-summary@kernel.org>
Date:   Mon, 14 Aug 2023 22:10:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to use modern name (part2)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773656
  Lore link: https://lore.kernel.org/r/20230807124105.3429709-1-yangyingliang@huawei.com
    Patches: [-next,01/20] spi: amlogic-spifc-a1: switch to use devm_spi_alloc_host()
             [-next,02/20] spi: au1550: switch to use modern name
             [-next,03/20] spi: ep93xx: switch to use modern name
             [-next,04/20] spi: falcon: switch to use modern name
             [-next,05/20] spi: fsi: switch to use spi_alloc_host()
             [-next,06/20] spi: fsl-dspi: switch to use modern name
             [-next,07/20] spi: fsl-espi: switch to use modern name
             [-next,08/20] spi: fsl-lpspi: switch to use modern name
             [-next,09/20] spi: fsl-qspi: switch to use modern name
             [-next,10/20] spi: fsl-spi: switch to use modern name
             [-next,11/20] spi: gpio: switch to use modern name
             [-next,12/20] spi: gxp: switch to use modern name
             [-next,13/20] spi: bcmbca-hsspi: switch to use modern name
             [-next,14/20] spi: hisi-sfc-v3xx: switch to use modern name
             [-next,15/20] spi: img-spfi: switch to use modern name
             [-next,16/20] spi: imx: switch to use modern name
             [-next,17/20] spi: ingenic: switch to use devm_spi_alloc_host()
             [-next,18/20] spi: intel: switch to use modern name
             [-next,19/20] spi: jcore: switch to use modern name
             [-next,20/20] spi: lantiq: switch to use modern name


Total patches: 20

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


