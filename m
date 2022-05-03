Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B098F51893B
	for <lists+linux-spi@lfdr.de>; Tue,  3 May 2022 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiECQEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 May 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiECQDu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 12:03:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E1DCC
        for <linux-spi@vger.kernel.org>; Tue,  3 May 2022 09:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88673B81D8D
        for <linux-spi@vger.kernel.org>; Tue,  3 May 2022 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB99C385A9;
        Tue,  3 May 2022 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593614;
        bh=S7gZfpWnxhXPxpLMSe+fVhGn9C8ZSmLkpSCtnr4mTus=;
        h=Subject:From:Date:To:From;
        b=dxc415rkhtABoblagq0Td7fOUV3VS4YuzB/36I+W2aD//t6PVkaA8rbRfmpb3tq7e
         VacvtrFLMMte+7qGgOPzRySU3E58818JyFSWc/VcRmaqe/N3h+r8356Q9P1rLxdUlK
         SXekLwSJZvtmbiedHaGjph110fssbjlwX9+Qj3BBt8vcR2KOGbAOk1Dw6Z7UGDg3Ol
         c8aBL2BzSxvI1hAmRUF0gZNJxpi7hApKfcR/N+f1PKleXWcQH36ld0ru3IuarpC9lJ
         cMpbdPwbyVzNk9cguSdRWpMWePSp+G7hccjG6GKA9gVBJ5KngyVSNBCr/2NFVL3cd6
         dJ9vtYj/G3L8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 100EEF03848;
        Tue,  3 May 2022 16:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165159361398.31024.16077965831693399790.git-patchwork-summary@kernel.org>
Date:   Tue, 03 May 2022 16:00:13 +0000
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

Patch: [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
  Submitter: Marek Vasut <marex@denx.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=616137
  Lore link: https://lore.kernel.org/r/20220221043238.295369-1-marex@denx.de

Patch: spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
  Submitter: Ian Abbott <abbotti@mev.co.uk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=636235
  Lore link: https://lore.kernel.org/r/20220427153446.10113-1-abbotti@mev.co.uk


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


