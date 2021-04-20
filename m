Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE836539F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhDTH5V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 03:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhDTH5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 03:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CD6FC61077;
        Tue, 20 Apr 2021 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618905409;
        bh=5xFB53PCE5i97CZzEe13u3y/U7phBPprPeklQqC/zG0=;
        h=Subject:From:Date:To:From;
        b=Fl04LxcIwN5jJjGYj4gEhWdyyu8iKVgjUcVp+bVnqp4Mo0mesy0D3V7WU86e00ZeC
         nsv4rpScKl+eaaoehKYu2d65nPQXWfMl243cG3Wu9BNTd1CaK8f2eMpRfTfoWsBCPN
         KXUiH9lO85vdFfJ8zAHwHNhuTAf1N8bP+TO6tkdWS9E9xUcyV50OkQy+i5bAmCcf4f
         grZOW3c9fg34etW3LkiS+M+Wyu0eDVpQuZzUMBKS5rPyxFNhfc9Gn35DSPRXjfNTZG
         vdi8h5jYDv8VDouFyUqbu34twMd6MZYxbCejuDkutY3n8rPtLRj0mdoiYxcmZcJVmT
         X9Rd+aW5Ack1g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5AC960A0B;
        Tue, 20 Apr 2021 07:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161890540980.21319.884845734899627298.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 20 Apr 2021 07:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add octal DTR support for Macronix flash (2021-04-20T06:29:37)
  Superseding: [v2] Add octal DTR support for Macronix flash (2021-02-05T09:36:46):
    [v2,1/2] mtd: spi-nor: macronix: add support for Macronix octaflash
    [v2,2/2] spi: mxic: patch for octal DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

