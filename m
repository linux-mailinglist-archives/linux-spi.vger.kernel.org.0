Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB24907F2
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jan 2022 12:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiAQL4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jan 2022 06:56:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58882 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbiAQL4S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jan 2022 06:56:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A2F61129
        for <linux-spi@vger.kernel.org>; Mon, 17 Jan 2022 11:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D6BC36AE7;
        Mon, 17 Jan 2022 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642420577;
        bh=3/fZXwQgqGMOjKcle9/IIxcTB8VaxPUl9bA8lZ3qQX4=;
        h=Subject:From:Date:To:From;
        b=fxSwFHSsFLWXN4EWeHC9B3ZilB22Ln/tmtpaw+piQWJHUd/hRjHRs+xbR61mLGRZc
         Vp/KZ8nlm8X5+NCxU/6tDaYwwge9GlT6HT4Q4ARDhqJMc/9D+9Jb8rrJJ3qxKJscCI
         vr90jabEE+L6EKU5LzGv8/yi9jfxGvKLAjGat58kbz2YJrNLpQZflhXb0npDNEUDUG
         D/Qfxw+bCZ9smyHyMhmgKnxCu+uoorCZURi2Slr8FTpp38dvfzdMdmwuzUK0HW5Wu+
         fzLOWzocSAtNghU+arhNOlJXF7sBpPe2B+TBrGh8+cG65rOC0Caeb7Lt5XuouhCE4N
         9Q0a0rGZiBcDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3026F60796;
        Mon, 17 Jan 2022 11:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164242057778.7469.1006304011693534883.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 17 Jan 2022 11:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Update the Icicle Kit device tree (2022-01-17T11:07:41)
  Superseding: [v3] Update the Icicle Kit device tree (2022-01-14T15:17:12):
    [v3,01/15] dt-bindings: soc/microchip: update syscontroller compatibles
    [v3,02/15] dt-bindings: soc/microchip: add services as children of sys ctrlr
    [v3,03/15] mailbox: change mailbox-mpfs compatible string
    [v3,04/15] dt-bindings: i2c: add bindings for microchip mpfs i2c
    [v3,05/15] dt-bindings: rtc: add bindings for microchip mpfs rtc
    [v3,06/15] dt-bindings: gpio: add bindings for microchip mpfs gpio
    [v3,07/15] dt-bindings: spi: add bindings for microchip mpfs spi
    [v3,08/15] dt-bindings: usb: add bindings for microchip mpfs musb
    [v3,09/15] dt-bindings: pwm: add microchip corepwm binding
    [v3,10/15] riscv: dts: microchip: use clk defines for icicle kit
    [v3,11/15] riscv: dts: microchip: add fpga fabric section to icicle kit
    [v3,12/15] riscv: dts: microchip: refactor icicle kit device tree
    [v3,13/15] riscv: dts: microchip: update peripherals in icicle kit device tree
    [v3,14/15] riscv: dts: microchip: add new peripherals to icicle kit device tree
    [v3,15/15] MAINTAINERS: update riscv/microchip entry


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

