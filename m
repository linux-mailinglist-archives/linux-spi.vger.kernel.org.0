Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F77BFE8E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Oct 2023 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJJN4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Oct 2023 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjJJN4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Oct 2023 09:56:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF01A9
        for <linux-spi@vger.kernel.org>; Tue, 10 Oct 2023 06:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8057C433C8;
        Tue, 10 Oct 2023 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696946186;
        bh=vCXrFNQYUHXWTpEn5CFdCVEEVD9xdQP7nYRzqoKSI3M=;
        h=Subject:From:Date:To:From;
        b=DCErJF2bxkEfqGysc1B/iJvMYt+iOQAnCuhE9cvZdmREC+KRAbU0u2vSLORUF4M14
         Z9m9TzpnYwlW5CRTThyMc5RLnopb6NA3B1llwNzww1/ri9ulZs+G1gHxvvMQ+dl3bd
         8wg6cTwDMWIbJ2KVwkpriT+9P37lKQK1sTX5PObO0ajq3hHrIRmTKv2uOupdkR3ufj
         5jdkNnqZAylHQwIJfnIkPVT7k/dmdhs+ROULUj0/nT3857G/nhgM8ccJmyh4FRiU4G
         RqhgmY9C5/0D++8KKsvlWKp4FpRdpDlSwMF7aR+2oF0gD59Br1PRoO7rdzkDEvYR6Q
         ZnsiC13khYv7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8889C39563;
        Tue, 10 Oct 2023 13:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169694618675.25568.9126365768135622920.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Oct 2023 13:56:26 +0000
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

Latest series: [v6] Introduce STM32 Firewall framework (2023-10-10T12:57:09)
  Superseding: [v5] Introduce STM32 Firewall framework (2023-09-29T14:28:42):
    [v5,01/11] dt-bindings: document generic access controller
    [v5,02/11] dt-bindings: treewide: add access-controller description
    [v5,03/11] dt-bindings: bus: document RIFSC
    [v5,04/11] dt-bindings: bus: document ETZPC
    [v5,05/11] firewall: introduce stm32_firewall framework
    [v5,06/11] of: property: fw_devlink: Add support for "access-controller"
    [v5,07/11] bus: rifsc: introduce RIFSC firewall controller driver
    [v5,08/11] arm64: dts: st: add RIFSC as an access controller for STM32MP25x boards
    [v5,09/11] bus: etzpc: introduce ETZPC firewall controller driver
    [v5,10/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v5,11/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

