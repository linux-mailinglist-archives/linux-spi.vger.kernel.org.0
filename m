Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D95FA018
	for <lists+linux-spi@lfdr.de>; Mon, 10 Oct 2022 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJJOUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Oct 2022 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJJOUR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Oct 2022 10:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CD43E40
        for <linux-spi@vger.kernel.org>; Mon, 10 Oct 2022 07:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0967460F34
        for <linux-spi@vger.kernel.org>; Mon, 10 Oct 2022 14:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7026DC433C1;
        Mon, 10 Oct 2022 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665411615;
        bh=qtntwz/XXjgLxwdhYvxdMiZ4B1wRJTbLLuVPvNpHpmk=;
        h=Subject:From:Date:To:From;
        b=GvYIBBKJJrc6L2aff4GokBYNvplhnqqRdww+wNWPvHpKdA/uYUivmfXT5LTu762Qh
         2Qxm+jZDnKx+e5X4giBhj/GMSACx3H/Kg9RQ8tTz24QkXJN0vcJ29JOlRk+NpurJ2L
         OguE/e3tAl1JoBqCdrHDVljmTV4oho7wslHDIwlJ8Z4T0RnM4AzefJvoVTp2kDxvDY
         nGYguzdhhxWswmDfvGmK6IbajasG7e5nHlP6T/qc4iZY8Qpv5j6RIEO5wRXeX3TDev
         lEyL0s9mAe85S3gA7eTqQ8IeuQilop8FvohAjkWaMOjoW0MRWT+RZuFvOA+3nWeMDP
         12vl80b7wbRkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DA09C070C8;
        Mon, 10 Oct 2022 14:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166541161525.7976.12507537808018580325.git-patchwork-summary@kernel.org>
Date:   Mon, 10 Oct 2022 14:20:15 +0000
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

Patch: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=683165
  Lore link: https://lore.kernel.org/r/20221005083209.222272-1-chin-ting_kuo@aspeedtech.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


