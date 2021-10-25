Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C943A640
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJYV7T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 17:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhJYV7T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Oct 2021 17:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AC77C60E8F;
        Mon, 25 Oct 2021 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635199016;
        bh=+goRy/IpcJKWCxr80uW+XWhYNTYKDULmod0pDz4/HjU=;
        h=Subject:From:Date:To:From;
        b=YefRdaX7SO9UEz877jzZNTouns16X03CPShNbfS1MqrXSgMM6+2E9g4hBqSkSaqx0
         Cvx3Pfj1lScOc5POxvXm7AdGUeL0dVrDEZIUgGYwRaJfFZL09rVoh4eW3pfLkOwA8p
         X8jIG1taoQivR8R0MnKMXPz2FIN916wLGphqJYBTZiQU1ZE8j7E7sF/6p0xeaTxRR4
         g7kvGS6ppFUoP/s+8VkaoRwisy0Tv+AoliAU9mZSkHPPBOFPFVEFX6Ts8dOYUnsNAi
         xqBXbvCg1JshULHQAlzCoXOLkWgTjcTKm/dErVIf8Kfq/K00kEgSevOHAqkReDdHk5
         UpQwVL5YUDAAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8FB4360A0A;
        Mon, 25 Oct 2021 21:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163519901655.22929.910215461517963707.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 25 Oct 2021 21:56:56 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add SPI Multi I/O Bus Controller support for RZ/G2L (2021-10-25T20:56:24)
  Superseding: [v1] Add SPI Multi I/O Bus Controller support for RZ/G2L (2021-09-28T14:07:15):
    [1/6] dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
    [2/6] dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
    [3/6] spi: spi-rpc-if: Check return value of rpcif_sw_init()
    [4/6] mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
    [5/6] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
    [6/6] memory: renesas-rpc-if: Add support for RZ/G2L


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

