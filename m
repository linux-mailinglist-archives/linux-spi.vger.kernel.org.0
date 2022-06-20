Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2A55194E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jun 2022 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiFTMuQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jun 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiFTMuP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jun 2022 08:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C412C3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 05:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 664D7614C3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 12:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7013C3411B;
        Mon, 20 Jun 2022 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729413;
        bh=CYtI+1c+yLxevT/p9Ec/lm859XWvBv0Pkp/5S4CFEpY=;
        h=Subject:From:Date:To:From;
        b=Tem8nOpXmhRjm2j9AaZg6KFLKhkzUBXPkYqW9xqDpm0hlbuIVqyil25N7taIBK/TJ
         5vpwHDpjo96AztQxEamMNiqkk1QqoOZPiiJQr/tUbgSfKvLhbeBuBy2yGP5P4Fip79
         Lqd+eY5yFBRKXtPP/AYZBfS+1Ah5+t2HgGjLOJJGMWmxRwHBFwKe9jxAHSUXks/PRJ
         hsIJIytQbiGcmF12Y3EFQA1fCgl7tyDtfYQdh39ctR+gS7I/eMLSBOxAQsSyn1Xo5I
         H5Gwwi4ApMmp7pzz9jp6bGwZe4MeMqA4Mc4eEv67k+Cu2ehBiBbaYQBJ1w/DbwdPK2
         x+HnFsgA4MchQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8BDAE737F0;
        Mon, 20 Jun 2022 12:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165572941361.28646.5230874842773508864.git-patchwork-summary@kernel.org>
Date:   Mon, 20 Jun 2022 12:50:13 +0000
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

Patch: spi: topcliff-pch: Use core message validation
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=650721
  Lore link: https://lore.kernel.org/r/20220615174138.4060912-1-broonie@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


