Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87F6506A7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 03:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLSC4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Dec 2022 21:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSC4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Dec 2022 21:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEAB7E2
        for <linux-spi@vger.kernel.org>; Sun, 18 Dec 2022 18:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2065FB80BE9
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 02:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B584FC433D2;
        Mon, 19 Dec 2022 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671418577;
        bh=AYVJqi7C8P+4DtjiTgd6+mm9izvroLy4GJ3LIoHeDEw=;
        h=Subject:From:Date:To:From;
        b=Q2HYqT1vD4zbFpOM61CD9yYEy8iXs2ijdteYfgJzcMsB8DeHOPaNf5JP182SO6Dt7
         uXrlCqRAdQXHf9mKsyViTBYl4i2WVqsvvQkmaQ0TXJaXNFlpEXk8C0Zp9QPxfRsnSe
         v/7iWUOxhYR9Y8rDPBnul4LBgW1C18WXgkCZfAZxfloi9WtaG1ItPQf0GZWhFoS39a
         KyloljXtRvTFf3vMqexjhHjL40ht/X2SGWO5rqvwVsqY/kAaRDkQ6hyF9HLtWTqXZx
         N8p5skkZUusCGWEqLBjJe7L8JfB1FibRy7uohdZKXVx03XNaZZKaxEtchuqsjv4Un/
         Qsn3F6dZ73jyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 994CEE21EED;
        Mon, 19 Dec 2022 02:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167141857762.1503.7237580296975503324.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Dec 2022 02:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-19T02:40:10)
  Superseding: [v4] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-09T06:43:08):
    [v4,1/9] spi: mtk-snfi: Change default page format to setup default setting
    [v4,2/9] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
    [v4,3/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
    [v4,4/9] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
    [v4,5/9] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
    [v4,6/9] dt-bindings: spi: mtk-snfi: Add read latch latency property
    [v4,7/9] dt-bindings: mtd: Split ECC engine with rawnand controller
    [v4,8/9] arm/arm64: dts: mediatek: Fix existing NAND controller node name
    [v4,9/9] dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

