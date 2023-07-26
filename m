Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5895C7632F5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jul 2023 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjGZJ5x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jul 2023 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGZJ53 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jul 2023 05:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF76358A
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 02:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72B461A27
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 09:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40629C433C7;
        Wed, 26 Jul 2023 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690365391;
        bh=bQYWXehBADeXS2ZhwL/FBpqi/GWp7ead6LAOLbJQLtY=;
        h=Subject:From:Date:To:From;
        b=Zs9sZ/vjU6lCH96wpheTngmnF92d+XFevcx7HiEBlLXAvFsb/H3oYtlG651snFLJy
         sILp2+pPsAmIKQ/de4apK8sJArMuRf/bprvbHGU8XG+V5caksQykcrMYj9XvScaFUH
         Ol5DZF27C3fH/yoElpjTn3B3Jy65X5a9kvLCWGeKTxICY3as2ZfBBd0u36Pq0WNldo
         RIlxzP5F6MaZ6eiayeG1Jzv7Xwg8PiyXgij8OyI/cKmwOUnIbNs1KziqEGVOZ5Oamy
         x0uM9eahtkScjSwqmqy1jlwqZ3Xm/0wpSx6nelq8x6vgP06CxiZJCPNberOU+ffwbs
         4wJa3Ku2sx2lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E4C9C3959F;
        Wed, 26 Jul 2023 09:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169036539118.28102.14674694086197059297.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 26 Jul 2023 09:56:31 +0000
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

Latest series: [v3] Introduce STM32 Firewall framework (2023-07-26T08:38:02)
  Superseding: [v2] Introduce STM32 Firewall framework (2023-07-25T16:40:53):
    [IGNORE,v2,01/11] dt-bindings: Document common device controller bindings
    [v2,02/11] dt-bindings: bus: document RIFSC
    [v2,03/11] dt-bindings: bus: document ETZPC
    [v2,04/11] dt-bindings: treewide: add feature-domains description
    [v2,05/11] firewall: introduce stm32_firewall framework
    [v2,06/11] of: property: fw_devlink: Add support for "feature-domains"
    [v2,07/11] bus: rifsc: introduce RIFSC firewall controller driver
    [v2,08/11] arm64: dts: st: add RIFSC as a domain controller for STM32MP25x boards
    [v2,09/11] bus: etzpc: introduce ETZPC firewall controller driver
    [v2,10/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v2,11/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

