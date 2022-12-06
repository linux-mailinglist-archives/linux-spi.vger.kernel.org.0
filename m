Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB56448F8
	for <lists+linux-spi@lfdr.de>; Tue,  6 Dec 2022 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiLFQPq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Dec 2022 11:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiLFQP1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Dec 2022 11:15:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99C3AC19
        for <linux-spi@vger.kernel.org>; Tue,  6 Dec 2022 08:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E4FCB81AA1
        for <linux-spi@vger.kernel.org>; Tue,  6 Dec 2022 16:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F397DC433D6;
        Tue,  6 Dec 2022 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670343018;
        bh=V7a5ctRJd7diystNYpnm962ZtHyqJUXQ7JTAuv1F5UU=;
        h=Subject:From:Date:To:From;
        b=t1pweiPa+eUTgVzsbyMI7Bvce2wmo4+f3I0UpaTax81zWVUS+CXhI+w4IFhC1N1BN
         SfqBMtFQUg66oV3BSj9zxCVXRxcD1cs34pPrMmcVan0aXiv//ZIcGFItyWFc2zB3nC
         5VhTcEl8R3dtezZ7ge0SRZPqZb3rZFwwhvK6hYSfCudUuBfvUdm6IvRSC+DzFK3AcV
         8boULMJf1QPI0Oda0FKoDH2bBvrtoibjnpmzVAnLBLV6MC0aU8Iaihe/3L3aMGkpTZ
         qFUeHT2ux45T+by054H14IrsVrRVvMRV0Zv7nojEmddKzB4le8QBk+4bm3l9Ac4vtR
         XI/igVSpadwDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D58CAE56AA2;
        Tue,  6 Dec 2022 16:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167034301782.31709.1595728140469643227.git-patchwork-summary@kernel.org>
Date:   Tue, 06 Dec 2022 16:10:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add MediaTek MT7986 SPI NAND and ECC support
  Submitter: Xiangsheng Hou (侯祥胜) <xiangsheng.hou@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=701679
  Lore link: https://lore.kernel.org/r/20221205065756.26875-1-xiangsheng.hou@mediatek.com
    Patches: [v2,1/9] spi: mtk-snfi: Add snfi support for MT7986 IC


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


