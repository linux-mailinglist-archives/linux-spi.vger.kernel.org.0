Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58246647E2C
	for <lists+linux-spi@lfdr.de>; Fri,  9 Dec 2022 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiLIHAc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Dec 2022 02:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLIHAB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Dec 2022 02:00:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4707B6D91
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 22:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DD17B827BE
        for <linux-spi@vger.kernel.org>; Fri,  9 Dec 2022 06:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AF40C433EF;
        Fri,  9 Dec 2022 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670568981;
        bh=VOmV3118wg9Xsw1Q5Km/FaGcJ1qDQCvMfjUHIJJUB+w=;
        h=Subject:From:Date:To:From;
        b=kYbw150xajbnuF9z9TLpJ6ZJ360ryut7kJijJL1OCJiw4fnW+UpnqybY3259xDivP
         qtG2hMxqI0vSD6IpAL0zTM5Ap4sin8iAbImzHcN/jF4S4oQNy0QTTIiA8dkzIXNEYb
         1OwIU4fuNjXirDq3pj5W3ch+9s/sJ3NJe9wQIpgwhnJCL0NmzZWosN2ng1axcoirNt
         3duxi9fdzJuzh4YI3EApdAiu1q3XlBHBc8RPkTEDjtohOPOSmFS6A7YI8uKAnkN2uL
         9DFhPSRETBG1tHUaAas0CDocCA51TlrUtDZwlwzJqySULsJSsjNRx+L14hY7zAHLDz
         N5lJ5LE7/aTDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBC81C433D7;
        Fri,  9 Dec 2022 06:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167056898080.18352.4876816489463355105.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 09 Dec 2022 06:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-09T06:43:08)
  Superseding: [v3] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-08T06:29:47):
    [v3,1/9] spi: mtk-snfi: Change default page format to setup default setting
    [v3,2/9] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
    [v3,3/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
    [v3,4/9] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
    [v3,5/9] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
    [v3,6/9] dt-bindings: spi: mtk-snfi: Add read latch latency property
    [v3,7/9] dt-bindings: mtd: Split ECC engine with rawnand controller
    [v3,8/9] arm/arm64: dts: mediatek: Fix existing NAND controller node name
    [v3,9/9] dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

