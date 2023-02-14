Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BA696772
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjBNO43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 09:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjBNO41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 09:56:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288302917B
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 06:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D438CB81DE7
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 14:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C39EC433D2;
        Tue, 14 Feb 2023 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386583;
        bh=1yTI+mHqXmC8LYH7R/WLYmZec48PuWVPA2se5CVPof0=;
        h=Subject:From:Date:To:From;
        b=QVPv6OILpXjIDu5TJ+5SpKPIogaSURELKepsMohVMTq3QTvUJKjUSXxsbGSalCdLx
         WbJEY3U6qWacZb3l1RYI04PjzG0Eh5juJFJAhphERrBaz5fZBfRly4QFkO0iwIuGk4
         +z8h3KGu/valhXVGdDEuhPIc10CeERLMDv1Elb8vsiizb5nBaApIGh7LAG9e2cB33d
         pZPnLuqJSTUCG0PDrAvYMcst8j+LT1amwWFLjb4KXq4FGrQhepagYboAB3NKkthEU9
         EI8u4lX3B4hSxdRdMtPY2o0VxPjK1EHfVBe8l6zDPbHUN9Ww/U+plpZoOVvcmAgvgD
         MnzxMBW/v3yIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81587E68D35;
        Tue, 14 Feb 2023 14:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167638658352.18795.3460991174194726889.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 14 Feb 2023 14:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: xilinx: add force_irq for QSPI mode (2023-02-14T13:59:28)
  Superseding: [v1] spi: xilinx: add force_irq for QSPI mode (2023-02-09T21:13:21):
    spi: xilinx: add force_irq for QSPI mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

