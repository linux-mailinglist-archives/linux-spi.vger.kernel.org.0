Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D04C7D11
	for <lists+linux-spi@lfdr.de>; Mon, 28 Feb 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiB1WKx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Feb 2022 17:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB1WKw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Feb 2022 17:10:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E963C6833
        for <linux-spi@vger.kernel.org>; Mon, 28 Feb 2022 14:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3279161299
        for <linux-spi@vger.kernel.org>; Mon, 28 Feb 2022 22:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97ADBC340EE;
        Mon, 28 Feb 2022 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646086212;
        bh=fSEDoi5H9xqMlJe492+MZPp1nq7RbdUh4MUuBfqXz5w=;
        h=Subject:From:Date:To:From;
        b=afR/sI0k3NfQRfmaQsPyBzQIeHMWijlvmRVj2VxKdgie/9+s5Wth8J8DCr9c1gC7s
         rDp+lc1LoqfgiYjlGRheo0O2lRl7Dp0P6hzz6T/LvCt1ua/NfBnWNODOCNPwh24s+a
         WjSoh5jEA+hFwdHIF/YVY12spyyUDH4VvS2/RbCn7HS9KdR0vYozfdCFGnMBVStnT7
         czc86ECirSz3d1W5MWtFMeMWysH6aojvKT6dlnGtpm6tJynYDqvIBE/LZAahrn0eiB
         WJYTHP47BneODACFeDRB8sM/bb+MXIheg/kmw26KAO+rbLxKfpka5sKcpsh7z3dJ13
         3p855K2YMUTRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A8C5E6D4BB;
        Mon, 28 Feb 2022 22:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164608621244.15510.13201187038096927843.git-patchwork-summary@kernel.org>
Date:   Mon, 28 Feb 2022 22:10:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] spi: use specific last_cs instead of last_cs_enable
  Submitter: Yun Zhou <yun.zhou@windriver.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=615434
  Lore link: https://lore.kernel.org/r/20220217141234.72737-1-yun.zhou@windriver.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


