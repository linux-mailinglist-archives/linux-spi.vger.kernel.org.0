Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE47B362C
	for <lists+linux-spi@lfdr.de>; Fri, 29 Sep 2023 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjI2O5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Sep 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2O5L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 Sep 2023 10:57:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE8F9
        for <linux-spi@vger.kernel.org>; Fri, 29 Sep 2023 07:57:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85C08C433C9;
        Fri, 29 Sep 2023 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695999427;
        bh=sALZta96CSS2Nt3HZQEwAejc7KiFnssvXL5hsH+TITs=;
        h=Subject:From:Date:To:From;
        b=cAUaXaw0YH+Qs1J3RqD4sQN8Lx1TijNHbli+sclo4njs1dEfaZlLSMLdJnbcJRieK
         tKQMlJRdcmX7y+iGUIYW/s3vtEdBHwxayLnQi8S7YAHiDhFD/6+XvTIjYiryi4Eq4p
         Rs/NYISVTWmVUKjC9IeSCfofrHtjoBPnW/8RzYxLY8IC0mij3LJvd2N+C25G0ZL+jv
         /AnUW5pCultAFIfQnKQkNYBgnqI0GBfl/bJ7c9yArDCDId91keGVnZkJk4tnz/GA0i
         26rbD2PMBHC7F0ThObTSdqSaBLnux9mqIai0ptCjseEEghgulg39PVVJ59qPq7vm2O
         ePVWt0WFnxr/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 720EAC43158;
        Fri, 29 Sep 2023 14:57:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169599942746.11320.4293604664260013461.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 29 Sep 2023 14:57:07 +0000
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

Latest series: [v5] Introduce STM32 Firewall framework (2023-09-29T14:28:42)
  Superseding: [v4] Introduce STM32 Firewall framework (2023-08-11T10:07:21):
    [IGNORE,v4,01/11] dt-bindings: Document common device controller bindings
    [v4,02/11] dt-bindings: treewide: add feature-domains description
    [v4,03/11] dt-bindings: bus: document RIFSC
    [v4,04/11] dt-bindings: bus: document ETZPC
    [v4,05/11] firewall: introduce stm32_firewall framework
    [v4,06/11] of: property: fw_devlink: Add support for "feature-domains"
    [v4,07/11] bus: rifsc: introduce RIFSC firewall controller driver
    [v4,08/11] arm64: dts: st: add RIFSC as a domain controller for STM32MP25x boards
    [v4,09/11] bus: etzpc: introduce ETZPC firewall controller driver
    [v4,10/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v4,11/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

