Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CCC45E8EB
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbhKZICN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 03:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244165AbhKZIAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Nov 2021 03:00:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 50F4461106;
        Fri, 26 Nov 2021 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637913420;
        bh=yhUPrSzxkC1KT65CwCaJTXfH/LU5GrUfMt4LM1Tye4c=;
        h=Subject:From:Date:To:From;
        b=tUP12XA7GUbZSSJLw79iR6uJDKxa12eQ+mXzJI7Mrt4aF3khfcMK7oA8HzI1sWa8k
         1+77RKU782x1EP+ggihi19rE7DSCvfvsagffYkVEAJ6EqKGWNToc/ssfkXMj6kVDIR
         aoCzdC7gIxtvF7/U6qVxiN7Za+dGt+AMYLGAGYAwY2WpzSkNfemN3ivl05xFkJluTM
         oFiff1qqSrcncJYsgZLy59vHwksTdVQsjt/97PqXv4/IXIFVVukhhhE7QFlvT1+1lA
         V3c6C72o7TblcakLeytZvbix5SrM9r1Cps0cEXDeaAnlIP4P+XJqr2c91qaF7azQC3
         4rvSDG2ICnJOQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4B11160A3E;
        Fri, 26 Nov 2021 07:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163791342030.20727.5497710304987018997.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Nov 2021 07:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] dt-bindinds/dts: support i.MX8ULP (2021-11-26T07:39:55)
  Superseding: [v5] dt-bindinds/dts: support i.MX8ULP (2021-11-20T11:34:46):
    [V5,1/8] dt-bindings: i2c: imx-lpi2c: Add imx8ulp compatible string
    [V5,2/8] dt-bindings: serial: fsl-lpuart: Add imx8ulp compatible string
    [V5,3/8] dt-bindings: spi: fsl-lpspi: Add imx8ulp compatible string
    [V5,4/8] dt-bindings: timer: tpm-timer: Add imx8ulp compatible string
    [V5,5/8] dt-bindings: watchdog: imx7ulp-wdt: Add imx8ulp compatible string
    [V5,6/8] dt-bindings: arm: fsl: Add binding for imx8ulp evk
    [V5,7/8] arm64: dts: imx8ulp: Add the basic dtsi file for imx8ulp
    [V5,8/8] arm64: dts: imx8ulp: Add the basic dts for imx8ulp evk board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

