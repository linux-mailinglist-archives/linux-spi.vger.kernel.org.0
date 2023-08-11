Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885E3778C81
	for <lists+linux-spi@lfdr.de>; Fri, 11 Aug 2023 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjHKK5G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Aug 2023 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjHKK5D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Aug 2023 06:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A9C3
        for <linux-spi@vger.kernel.org>; Fri, 11 Aug 2023 03:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775C660F5B
        for <linux-spi@vger.kernel.org>; Fri, 11 Aug 2023 10:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19B9C433C7;
        Fri, 11 Aug 2023 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751421;
        bh=8ReKUZ2Lwv1v3bqOz73qIM595NQaUczMMVNHsK0Zqas=;
        h=Subject:From:Date:To:From;
        b=hKUZgQysPUVkCnAeSPhZvIb8jlqgRALpMqf23arW/Z5R6WQeATZ2hcjzAkfJuXhp5
         9Jsy90j3ZhuRcVg+YgD+al9NcN4XYKtHGprTt012SKk2DMVfUQFZhsVoXpz6pYjmA5
         SDjgT4xGAjpb5/eOMvKvxPNTw97nhDvFlUxeXabhK9eMcgurbPCds9Xb3nEe8KK2g5
         dYx2vjLFVdkTjEnmZJfCbSsHqZLkl5BaVm1Pf7N72dL3i7aS2kfQFHdIq2WMxRNXbE
         tyVN4W309NzCLUWL46AYKb2npCQFWDwHPyz2d3YD4fDgxf3zIvT4BgV1kK0ozAH6Va
         Vk2MgZoior82Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2591C395C5;
        Fri, 11 Aug 2023 10:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169175142178.28583.966614360412023069.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Aug 2023 10:57:01 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Introduce STM32 Firewall framework (2023-08-11T10:07:21)
  Superseding: [v3] Introduce STM32 Firewall framework (2023-07-26T08:38:02):
    [IGNORE,v3,01/11] dt-bindings: Document common device controller bindings
    [v3,02/11] dt-bindings: treewide: add feature-domains description
    [v3,03/11] dt-bindings: bus: document RIFSC
    [v3,04/11] dt-bindings: bus: document ETZPC
    [v3,05/11] firewall: introduce stm32_firewall framework
    [v3,06/11] of: property: fw_devlink: Add support for "feature-domains"
    [v3,07/11] bus: rifsc: introduce RIFSC firewall controller driver
    [v3,08/11] arm64: dts: st: add RIFSC as a domain controller for STM32MP25x boards
    [v3,09/11] bus: etzpc: introduce ETZPC firewall controller driver
    [v3,10/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v3,11/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

