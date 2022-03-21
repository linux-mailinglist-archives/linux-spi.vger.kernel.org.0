Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43804E1EEA
	for <lists+linux-spi@lfdr.de>; Mon, 21 Mar 2022 02:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiCUB6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Mar 2022 21:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbiCUB5t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Mar 2022 21:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71A17F3DD
        for <linux-spi@vger.kernel.org>; Sun, 20 Mar 2022 18:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBF5612CB
        for <linux-spi@vger.kernel.org>; Mon, 21 Mar 2022 01:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1431DC340ED;
        Mon, 21 Mar 2022 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647827784;
        bh=eAHVVFQb51p0zWcUKksTczYNqHG3OMeqdDaA8Nb8sWE=;
        h=Subject:From:Date:To:From;
        b=GRg9Sys3ueEuSYPIcoCupfKq4Jovm+q1E3NvkcM/MT0XfjAwpds9aAhETP2YHltA6
         EBSbpUGcPrkYuA6+3vDEwd4pwIudfRMgHczULJ1ScybXnzPK/XgoHnqnrKXFS4sAcN
         uVimaNbvmCF0fg9wt4FAlolZzj9qzc6lzrc62J9afXPp4qWyKiiwacSnCVemTTX4Lj
         wFczPmqfMDxv904I5Nf8Hy4a58bs1HDKYvc/IMIT5fzCVHC3twPCYa6ImV5j5YPh6q
         dfM8OJj3Jih00IUZcMNe/bCU8y3f2B6WuVZVaG8n5Aw9O8deTxdep5ixeCVO5C1hVY
         r6FO0MM9rWm+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E763BE6D406;
        Mon, 21 Mar 2022 01:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164782778386.30712.16782718364989390754.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Mar 2022 01:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: mediatek: add single/quad mode support (2022-03-21T01:39:21)
  Superseding: [v5] spi: mediatek: add single/quad mode support (2022-03-18T02:50:24):
    [V5,1/3] spi: mediatek: add spi memory support for ipm design
    [V5,2/3] dt-bindings: spi: support hclk
    [V5,3/3] spi: mediatek: support hclk


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

