Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20F4D9CA1
	for <lists+linux-spi@lfdr.de>; Tue, 15 Mar 2022 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbiCONvb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Mar 2022 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348820AbiCONva (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Mar 2022 09:51:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C010532FE
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 06:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DFD55CE182D
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3314DC340ED;
        Tue, 15 Mar 2022 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647352214;
        bh=3183iCl7T9xhzz6E7y9lnPsIcCTsFIz30kLnFnD95cY=;
        h=Subject:From:Date:To:From;
        b=A762jYGJGiIegX4RvGKM/EtRMr2zaUjjYx/mLDjV+ziP5+KMBwiJBK7X5JtNBVafl
         nOLH1jF+dIaq1fqjobrKV32Tx5DYGt1Xd0FhAvcWIQ8ScOkgQ1U+LOXZAoi5WqNBYg
         XwzWtCaAEntBAUbNuW1t8/EOM66LHrirKoh6Vwn+nfMoKli7Qcm9f7bkJPaZvfcjEZ
         820qI7IR49n0eT09Pm+K8u3ddi3Z0wQ+mA+6xMpKeCM5l10QZF/7rpNhS8xSPOq3NI
         BqF065k8NdZWIGzkBlin2pBGrVx5Qe8/Dp4UKdh3tVlwMfVdQWDmT8i3iWFyQJ5SyS
         V/no6qTaZp0Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D22BE6BBCA;
        Tue, 15 Mar 2022 13:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164735221393.3473.3743207190937113726.git-patchwork-summary@kernel.org>
Date:   Tue, 15 Mar 2022 13:50:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: mediatek: add single/quad mode support
  Submitter: Leilk Liu <leilk.liu@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=623390
  Lore link: https://lore.kernel.org/r/20220315032411.2826-1-leilk.liu@mediatek.com
    Patches: [V4,1/6] spi: mediatek: support tick_delay without enhance_timing


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


