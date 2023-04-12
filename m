Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C66DFAA0
	for <lists+linux-spi@lfdr.de>; Wed, 12 Apr 2023 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDLP4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Apr 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLP4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Apr 2023 11:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3B59F0
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 08:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277EE632BC
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 15:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84E53C433EF;
        Wed, 12 Apr 2023 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315006;
        bh=hVU9lD6r8hqv6QY4r+q/umXYFXvc+lAjoHkXNT9x0x4=;
        h=Subject:From:Date:To:From;
        b=RkEHTWx/etKLBvvvVmd3DdkGf9K4xKHD7RJc4CIeUZE5ngBvJQDOBdBkKeVnT03HV
         PfNX4Hk49csY1hTeFi1sTkRXVPaIvLM4jQTDFxs4jUv3CocqtOvbujjftYwE3Hgs8u
         67Kxno6EbUYnp7BckwYir75VJwPqX8RnlgaQ3wawnde9Kf+Rmka6pILrCnW/sel9OK
         bha4he4hDNj0HCDTxcvj0TY9XJ09qTWRheuw66ujxIjSJ3ob58f8ToaBfNzv9LYgwX
         poph18jkFSThzIkjR+fMfJtn4mLDo/pU571PiQB8pOXMdCC7wzBLL3QgJ3JSypHesa
         wEqlMZNrm4t6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7370EE5244E;
        Wed, 12 Apr 2023 15:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168131500646.2127.177340811940735287.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 12 Apr 2023 15:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Add DMA mode support to spi-qcom-qspi (2023-04-12T15:29:45)
  Superseding: [v1] spi: Add DMA mode support to spi-qcom-qspi (2023-04-04T18:03:18):
    [1/2] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
    [2/2] spi: spi-qcom-qspi: Add DMA mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

