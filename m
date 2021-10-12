Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1D42A8EA
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhJLP7E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhJLP7D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Oct 2021 11:59:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 378B36103D;
        Tue, 12 Oct 2021 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634054222;
        bh=cCuz7DgvGSONfg9Tszli3VQxd+Knxleyxc3zvGOmbZM=;
        h=Subject:From:Date:To:From;
        b=gcjrmMKxLQbh/4FwA8WcUyABg/JvuCNaKx10hggIb/TnxS//jHPmAUHaQSSFC5y9J
         bdY2PlZSIvdWfa0bi07z/HZbIaAUJtiqNUDWdG4OrZWmTsxBaxWp2Jivqu48+ODxZv
         20h51F79bUU6i8Cr6bJbrt1TX4bUq5ShR8sZXVvT97Z8DcEXBM/VTbw1uPhS14oM1y
         h1RcKLpEBurmOjoA3di9dfkuHUP0vK/qVxqng1qtCz9bjEqzwIDvccl9mOtpPnULwF
         fxhzFumDaDII1lZvRZA2BZF0SzzUKsmzPSvKcconuDMbmii7bVpTwpxhFWjPUL11pE
         Nqrb+k9YLVBkQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 282376095D;
        Tue, 12 Oct 2021 15:57:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163405422211.11962.13690262259067049479.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 12 Oct 2021 15:57:02 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Make some spi device drivers return zero in .remove() (2021-10-12T15:39:27)
  Superseding: [v1] Make some spi device drivers return zero in .remove() (2021-10-11T13:27:42):
    [01/13] drm/panel: s6e63m0: Make s6e63m0_remove() return void
    [02/13] hwmon: adt7x10: Make adt7x10_remove() return void
    [03/13] hwmon: max31722: Warn about failure to put device in stand-by in .remove()
    [04/13] input: adxl34xx: Make adxl34x_remove() return void
    [05/13] input: touchscreen: tsc200x: Make tsc200x_remove() return void
    [06/13] media: cxd2880: Eliminate dead code
    [07/13] mfd: mc13xxx: Make mc13xxx_common_exit() return void
    [08/13] mfd: stmpe: Make stmpe_remove() return void
    [09/13] mfd: tps65912: Make tps65912_device_exit() return void
    [10/13] serial: max310x: Make max310x_remove() return void
    [11/13] serial: sc16is7xx: Make sc16is7xx_remove() return void
    [12/13] staging: fbtft: Make fbtft_remove_common() return void
    [13/13] tpm: st33zp24: Make st33zp24_remove() return void


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

