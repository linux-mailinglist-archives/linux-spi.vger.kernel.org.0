Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858676F81E
	for <lists+linux-spi@lfdr.de>; Fri,  4 Aug 2023 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjHDC47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Aug 2023 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDC4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Aug 2023 22:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1983AA3
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 19:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A378261EB3
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 02:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 081C5C433C7;
        Fri,  4 Aug 2023 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691117806;
        bh=AsUHBT/goiRux5ajM74M/5K/hZqW8N/Ga/Mg+pmTRLQ=;
        h=Subject:From:Date:To:From;
        b=sEQUOTBLpv3woaXaKSK+me4oa9gBQsMjP67XPsyYzV35F8jb9hYTPv3cYjk4UL0kF
         odAAKiqx3F/xNiSyb68YxqcuJHuatkv/lwVDZXJUFe7kSNEK+xoG5JLulFW7VO/su+
         slhF71tZw+RpwALIAvR4Kz1AoF2I41x/4ZA9vHAvxnQBaWmei7mFHPTmeAQ9uYp60F
         +H/sz0CJqHXEncU0kIskBCMaHg7meYHrcSMZxYBrOX9UwQUalV67Rx0gDUr+HQbDSY
         /++UqqFYa9uaLxObMDj4x5/ZJo6Gyb+HgwUTpCtDLxj3O8W/NzYSkj+qwnS/WSOMW2
         b2PVD9IpbBX1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9F01C43168;
        Fri,  4 Aug 2023 02:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169111780588.3152.1503368966732371415.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 04 Aug 2023 02:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Add initialization of clock for StarFive JH7110 SoC (2023-08-04T02:02:52)
  Superseding: [v5] Add initialization of clock for StarFive JH7110 SoC (2023-07-19T09:25:43):
    [v5,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
    [v5,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
    [v5,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

