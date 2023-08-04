Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15A7708AA
	for <lists+linux-spi@lfdr.de>; Fri,  4 Aug 2023 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHDTKc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Aug 2023 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHDTKa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Aug 2023 15:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100AEAC
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 12:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2459620BC
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 19:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1697CC433C7;
        Fri,  4 Aug 2023 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176229;
        bh=pgOH9PTuXLLPrVEMowNRh1XBSJHRu8qETXh9NcIl9FY=;
        h=Subject:From:Date:To:From;
        b=nwuyR509Zn5EtkGbXElgvWW+fi78OvHo6XHnBIh4EB6yYWBe6mqNes3BfGQ0qrNzq
         e+gHrteXYtVvqlYib2UDM7yAgCEn9Pq5CFI5kac7DCAHGdbhT9g1+DxAVAkPTX42ho
         00jxjwhKzdIBpIyZLp5+f3UEzerjJXv54yvLCrjbvuUrVwEu9ECylCQbnbfjQVV6pD
         jXFnr94T8syo6ytUynxBw5sjmQZ8lAgPfTY3TAo+uwleoZDrDzAWGttxCciSPWQ2XU
         1z0Ty3N2s9ymEfFWblNptX6mEFmZP8D6Crx5qTTNdnEir3Yhzllx6iFogKLB1Husb6
         DWA46kCr573tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFAB4C43168;
        Fri,  4 Aug 2023 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169117622897.23172.12769721265152569534.git-patchwork-summary@kernel.org>
Date:   Fri, 04 Aug 2023 19:10:28 +0000
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

Series: Add initialization of clock for StarFive JH7110 SoC
  Submitter: William Qiu <william.qiu@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772857
  Lore link: https://lore.kernel.org/r/20230804020254.291239-1-william.qiu@starfivetech.com
    Patches: [v6,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
             [v6,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI

Patch: [v4,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
  Submitter: William Qiu <william.qiu@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762275
  Lore link: https://lore.kernel.org/r/20230704091948.85247-5-william.qiu@starfivetech.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


