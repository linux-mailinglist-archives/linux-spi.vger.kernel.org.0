Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4870AB9F
	for <lists+linux-spi@lfdr.de>; Sun, 21 May 2023 00:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjETW4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 20 May 2023 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjETW4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 20 May 2023 18:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C09E9
        for <linux-spi@vger.kernel.org>; Sat, 20 May 2023 15:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525BD60C3C
        for <linux-spi@vger.kernel.org>; Sat, 20 May 2023 22:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1852C433D2;
        Sat, 20 May 2023 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684623407;
        bh=xFPtgkWgnklVQKetgnTl6TiTTo5Bd2ot2Lv2PHVMW8k=;
        h=Subject:From:Date:To:From;
        b=Qcr8zDUdiTtFgx10JMccqpApFulgkww3JB8/0n857K32WAjEdo95UEHYS0KBy1aW8
         TcJmbiQFu2kDvR2TRx2GptQSNWjlGwfJf0xXwPHToqNEYe4YaLFC/UfRybpSq+gItn
         IigOgtaocGLISa9NTdesT0kzd4AF5U3miGp/1tuV+dSwgFJkBf1jPk03cgXPZAfZZ5
         LSPR9zg0ZyE/EC2c2Q1m6H80o48zRUnlg0NrT/nJyNaWtRH3XM2S5keryPydyZvuTC
         FNc7KR6+mGsguSFbrZhDGT/wVpOJY5sdg6+7PV6ngZdDQYsrU5uRVePEBcvB2/kntS
         UmBiK9p7nA36A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79FBFE5421C;
        Sat, 20 May 2023 22:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168462340741.32204.6773877945214014215.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 20 May 2023 22:56:47 +0000
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

Latest series: [v1] spi-dw-core.c: Fix error checking for debugfs_create_dir (2023-05-20T22:40:25)
  Superseding: [v1] spi-dw-core.c: Fix error checking for debugfs_create_dir (2023-05-17T17:31:02):
    spi-dw-core.c: Fix error checking for debugfs_create_dir


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

