Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA3457DAD
	for <lists+linux-spi@lfdr.de>; Sat, 20 Nov 2021 12:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhKTL77 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 20 Nov 2021 06:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237110AbhKTL77 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 20 Nov 2021 06:59:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 038CE60E96;
        Sat, 20 Nov 2021 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637409416;
        bh=VNCnkQ5dE1XbRBnOpfRnOUxztSfXGHSpYkvjM88z/pg=;
        h=Subject:From:Date:To:From;
        b=MuKT4R+vEo5VIkTF/ZtIZ6A2EVhb/Lw/yb+qnDn1eBUXb64iOKk8qzJNvIVfN0RiO
         28QNhhazfnham2+jsfQUA9ij+NSAxdWHdwM4jWlncAKMBp8TItfqk/NzQgQegW5s++
         KQ810Y3FgUm/x1yeP2Gs6X66typzQaQcwV7yDTiApfoAe7qodEdKiNjugL5I63zcFt
         RnLII2KBreUsltkgfSkhA/oRi5DkDA16h2C7gxnNs7E0qJh+7o5YE0zzuwU0FdHSNM
         HE/NDgFnyg7cyrfMQ0TXeE8RrVujkoAwAYNjOJjS/dVgNL0xTue6ne8rv/WMBq3s18
         jLzL9XLq76SaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E7C12604EB;
        Sat, 20 Nov 2021 11:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163740941594.7974.9775766739484789480.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 20 Nov 2021 11:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] dt-bindinds/dts: support i.MX8ULP (2021-11-20T11:34:46)
  Superseding: [v4] dt-bindinds/dts: support i.MX8ULP (2021-11-12T08:29:21):
    [V4,1/9] dt-bindings: i2c: imx-lpi2c: Add imx8ulp compatible string
    [V4,2/9] dt-bindings: mmc: imx-esdhc: Add imx8ulp compatible string
    [V4,3/9] dt-bindings: serial: fsl-lpuart: Add imx8ulp compatible string
    [V4,4/9] dt-bindings: spi: fsl-lpspi: Add imx8ulp compatible string
    [V4,5/9] dt-bindings: timer: tpm-timer: Add imx8ulp compatible string
    [V4,6/9] dt-bindings: watchdog: imx7ulp-wdt: Add imx8ulp compatible string
    [V4,7/9] dt-bindings: arm: fsl: Add binding for imx8ulp evk
    [V5,8/9] arm64: dts: imx8ulp: Add the basic dtsi file for imx8ulp
    [V5,9/9] arm64: dts: imx8ulp: Add the basic dts for imx8ulp evk board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

