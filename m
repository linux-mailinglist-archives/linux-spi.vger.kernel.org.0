Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20864D05C4
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 18:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiCGR52 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiCGR52 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 12:57:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4356939D9
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 09:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A5EB8166B
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 17:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61DA6C340E9;
        Mon,  7 Mar 2022 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646675791;
        bh=7V7EDYfBSbZxQFbH4S/1q1EbstGAD0g3yMJtbkpVb3w=;
        h=Subject:From:Date:To:From;
        b=eAMXtcMRfegSQ3HKue14BYawuDnN7QbTLDheqXkKGG5utq4MQYugSsO+ZvX+6VQIK
         zx/AtOnqZsVsqUKcM/SwtN90IrFNR4/u90NVEa+cyLv49hHVIpC8MOKWbTcY9PS7Xk
         yn2K7740LsLXpINRkUIZQcJdQo8N/Ll06rcQu1Z2Xm+h91hXQsbPdJ9VzhDV2cqZIb
         vdEak0802FjYiUt7RB3DVRagJiFpuMxxVJSmt2mCbPvZO/aY6sFh2vVsfhWUuyIZvW
         vaKsCrXhzczgLlf9ysVZRGK2xRzR5W85xDFTZ6ByjRXLBh2eBa1itU6bla6Yx0FE/H
         zl+dqSqCejApA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41F76E6D3DE;
        Mon,  7 Mar 2022 17:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164667579117.32333.1645836394170290163.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Mar 2022 17:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Tegra QUAD SPI combined sequence mode (2022-03-07T16:55:16)
  Superseding: [v2] Tegra QUAD SPI combined sequence mode (2022-02-22T17:56:06):
    [v2,1/5] spi: tegra210-quad: use device_reset method
    [v2,2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
    [v2,3/5] spi: tegra210-quad: add new chips to compatible
    [v2,4/5] spi: tegra210-quad: add acpi support
    [v2,5/5] spi: tegra210-quad: combined sequence mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

