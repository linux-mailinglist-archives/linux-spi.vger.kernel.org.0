Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2031680475
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jan 2023 04:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjA3D4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Jan 2023 22:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjA3D4S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Jan 2023 22:56:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08CC196B5
        for <linux-spi@vger.kernel.org>; Sun, 29 Jan 2023 19:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EA960EAB
        for <linux-spi@vger.kernel.org>; Mon, 30 Jan 2023 03:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC0CC433D2;
        Mon, 30 Jan 2023 03:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675050976;
        bh=3suw6+ZbGD78qMu22UhtdHVTLjVVvA23ifwt0xCbb1A=;
        h=Subject:From:Date:To:From;
        b=feH7xBKSLsts4VmK5tHpvd+hlLJw9UnahcQ6GgtWKjNYV+jXNtDcDcXnsQAWtEicp
         Kdnt924+KF60rmKe3SYGbpMBjsjqEm61uPJD3exxiW+OZantMxs2+X+ylqvvLgHD+z
         dshWi9FMKNGZ7vh3+gdB0S6AWQqCSSvYA9DMvve+SzJrmSvhQt4o05ljCkLyA3EuQc
         fXjurXvZjwvZ7XTi8OATzqXQucxwrS2eOh16Svq9q22354vK/0xGyH6fmSrIQro3Bh
         8MGD4iDthv1qCxyqj0uwu0eJnSMY+rXiYZR4UFYVFvYze4JeLNVFj4mr7uzYVC5R0j
         o5HBN9ZTfEqXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 736FBE501F2;
        Mon, 30 Jan 2023 03:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167505097640.31856.12283328373348850937.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 30 Jan 2023 03:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add MediaTek MT7986 SPI NAND and ECC support (2023-01-30T03:06:46)
  Superseding: [v5] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-19T02:40:10):
    [v5,01/10] spi: mtk-snfi: Change default page format to setup default setting
    [v5,02/10] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
    [v5,03/10] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
    [v5,04/10] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
    [v5,05/10] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
    [v5,06/10] dt-bindings: spi: mtk-snfi: Add read latch latency property
    [v5,07/10] dt-bindings: mtd: Split ECC engine with rawnand controller
    [v5,08/10] arm64: dts: mediatek: Fix existing NAND controller node name
    [v5,09/10] arm: dts: mediatek: Fix existing NAND controller node name
    [v5,10/10] dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

