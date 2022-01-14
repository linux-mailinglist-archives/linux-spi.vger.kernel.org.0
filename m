Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335F448ED7A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jan 2022 16:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiANP4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 10:56:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45432 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANP4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 10:56:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25727B8295C
        for <linux-spi@vger.kernel.org>; Fri, 14 Jan 2022 15:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E53A1C36AE9;
        Fri, 14 Jan 2022 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642175781;
        bh=M6EI6UfG7a5QiV2keZeJz6GmD87KUhBqpMpAUC9i1qc=;
        h=Subject:From:Date:To:From;
        b=aCf7Pf+p+/ejs0o34QNc7dEaSg9wlMsajnnf0xZRBV5VyFNyKiOSolALY6+LLEUHx
         wc0ovVFhuQBCX8XWFmaQtEwoNJhoWjvlJaeWNHBbqBQCIlnA5cCsB96kwwE7U0egCt
         hPn09nVfOGiVKyEYpiLbvkEYIO0Tr7rzUbR25RnuToXifqmFGiMfW1gsJqPji023yn
         87hqcby6o5przqGtNkX3p3DkAAKunOjRi3rEUIabddyRdYkvPxpGu0HSgvGkBHa+M/
         tjkdow+CFX/MwSerszwWkzDS0W8Pdjqsw5xCvAfI7kD71clFxVNms7cY7QpJEIa1aC
         NKwsOhydikpmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2B78F60797;
        Fri, 14 Jan 2022 15:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164217578185.22053.8494314086257326736.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Jan 2022 15:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Update the Icicle Kit device tree (2022-01-14T15:17:12)
  Superseding: [v2] Update the Icicle Kit device tree (2021-12-17T09:33:08):
    [v2,01/17] dt-bindings: interrupt-controller: create a header for RISC-V interrupts
    [v2,02/17] dt-bindings: soc/microchip: update syscontroller compatibles
    [v2,03/17] dt-bindings: soc/microchip: make systemcontroller a mfd
    [v2,04/17] mailbox: change mailbox-mpfs compatible string
    [v2,05/17] dt-bindings: i2c: add bindings for microchip mpfs i2c
    [v2,06/17] dt-bindings: rng: add bindings for microchip mpfs rng
    [v2,07/17] dt-bindings: rtc: add bindings for microchip mpfs rtc
    [v2,08/17] dt-bindings: soc/microchip: add bindings for mpfs system services
    [v2,09/17] dt-bindings: gpio: add bindings for microchip mpfs gpio
    [v2,10/17] dt-bindings: spi: add bindings for microchip mpfs spi
    [v2,11/17] dt-bindings: usb: add bindings for microchip mpfs musb
    [v2,12/17] dt-bindings: pwm: add microchip corePWM binding
    [v2,13/17] riscv: dts: microchip: use hart and clk defines for icicle kit
    [v2,14/17] riscv: dts: microchip: add fpga fabric section to icicle kit
    [v2,15/17] riscv: dts: microchip: refactor icicle kit device tree
    [v2,16/17] riscv: dts: microchip: update peripherals in icicle kit device tree
    [v2,17/17] MAINTAINERS: update riscv/microchip entry


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

