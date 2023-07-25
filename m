Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672E7621D7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGYS43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGYS43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 14:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D608121
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 11:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37F361867
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 18:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5149FC433C8;
        Tue, 25 Jul 2023 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690311387;
        bh=F+P5SGSooMkkvt5zJynK7k/NGdxnnjO/qwfxCuuEC9U=;
        h=Subject:From:Date:To:From;
        b=kc2ehcOlDHJPteLDmCmPN/nqXw8/UmwUtf4TAMUEuz9K6EHQrwTt1fJOZ9OZ0hkkI
         sPftgRCCrQczT83lCzVI4qVxI8Cl6/0+U5Qs6UuzfhWUblpy34oxf+4HlmNVOFrwdx
         lNiU172rYqkWnKjz94zn9Tst/guYcRDOd39ZaHbsOCv/YD1dAosHApVKxt8IjlHEvy
         +MTCSUqOSjhe2hqTKaqZD4u+wLSVGCzztwRAu2xmwhRTzoNgqmooLCkV8eEn4CiCFq
         xPx4hX6/HwJG1OQ4lzIwa9JaP3ktzrK7ahSoV+o0ZmCO7heKHJkQTuGo7O3O6bui3Z
         vtToVNERNQuiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 334C7C4166D;
        Tue, 25 Jul 2023 18:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169031138720.23630.10816910348027519737.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 25 Jul 2023 18:56:27 +0000
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

Latest series: [v2] Introduce STM32 Firewall framework (2023-07-25T16:40:53)
  Superseding: [v1] Introduce STM32 Firewall framework (2023-07-05T17:27:49):
    [IGNORE,01/10] dt-bindings: Document common device controller bindings
    [02/10] dt-bindings: bus: add device tree bindings for RIFSC
    [03/10] dt-bindings: bus: add device tree bindings for ETZPC
    [04/10] dt-bindings: treewide: add feature-domains description in binding files
    [05/10] firewall: introduce stm32_firewall framework
    [06/10] bus: rifsc: introduce RIFSC firewall controller driver
    [07/10] arm64: dts: st: add RIFSC as a domain controller for STM32MP25x boards
    [08/10] bus: etzpc: introduce ETZPC firewall controller driver
    [09/10] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [10/10] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

