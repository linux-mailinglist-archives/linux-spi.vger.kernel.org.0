Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936875850E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jul 2023 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGRSu3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jul 2023 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGRSu3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 14:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E5F0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 11:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F5161653
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 18:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43E66C433C7;
        Tue, 18 Jul 2023 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706227;
        bh=RI/aClRV5GMq6RlOjCaZdsfSDCDEpeK3rnJLKdlCwpk=;
        h=Subject:From:Date:To:From;
        b=ICA7otTh33SvtT4EFbVGGmKR2gW7Ddt8HyMgc/xNatpXdNcPbB2Xi0aaSEROQFRGc
         te+ikXSBD+qhdu502pzjHEuztsE6hFZj44+VNlE3t6ID2Q2XTuv+oDrfKHfMYOj8/Y
         kQLuXiUQzsPgzUvZ0B+FGxJHHeDgQ18H5mZh7QMzUZ+LLvB6apwqFuZjvdn6YzDQSJ
         I55V00E2DPDMa5CUQNxfj+/lYJsbITDlUXz01BgcG6MbkruIFT8DHZr/2KVgMFcZ8J
         EFx/F//MZYs+P5IjoTY+kep/9CSi7AadhYJSu4g13f5bRda4PshQbmvEe+yra5Q/X4
         MWSurXy7VtuDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AD4DC64458;
        Tue, 18 Jul 2023 18:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168970622700.24925.10771927753300141736.git-patchwork-summary@kernel.org>
Date:   Tue, 18 Jul 2023 18:50:27 +0000
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

Series: [v2,1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=766395
  Lore link: https://lore.kernel.org/r/20230717085934.409476-1-alexander.stein@ew.tq-group.com
    Patches: [v2,1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
             [v2,2/3] spi: spi-fsl-lpspi: Move controller initialization further down
             [v2,3/3] spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93

Series: spi: rzv2m-csi: Code refactoring
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=766084
  Lore link: https://lore.kernel.org/r/20230715010407.1751715-1-fabrizio.castro.jz@renesas.com
    Patches: [01/10] spi: rzv2m-csi: Add missing include
             [02/10] spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
             [03/10] spi: rzv2m-csi: Rework CSI_CKS_MAX definition
             [04/10] spi: rzv2m-csi: Leave readl_poll_timeout calls for last
             [05/10] spi: rzv2m-csi: Replace unnecessary ternary operators


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


