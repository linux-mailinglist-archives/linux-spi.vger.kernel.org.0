Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E42D003D
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 02:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLFB5j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 20:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgLFB5j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 5 Dec 2020 20:57:39 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607219818;
        bh=gYmRBtpKp53FnaZJ9qZ38CNY8HNmyLwu8jTHAwMR//k=;
        h=Subject:From:Date:To:From;
        b=hHPaI2Olntqh24kKWxGFpXraXzttihc8sIl8321pkfTv9VlEKCL2+nAkQFW5jhKza
         vtIEqqxL5xW0kxOeVvuKYdPZrDd0R3nXctbXXqWJ3OsQ+B14WGp6V5jlpQsQWTwcX/
         ZlUUMqh94W6mTUmWoc029juQuQjC5F7CvjCUGYGlkE4LFn+OidoV2EpsLxUjp3f5Md
         iAlJkNVDuRWRcZ+JJY0gL8fB4in0lZwhFASye6Lrd1rWYsj2C4QKfQ+KiO3BKKqa5k
         QCQ76jxh0vUXd1GfXjqlM0H382GT8PMQpTburHWxiymKS2JNRdjn0CZpqXcHWUx1dX
         fF6dngFkNxwow==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160721981856.19317.8698459051048678935.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 06 Dec 2020 01:56:58 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC (2020-12-06T01:18:14)
  Superseding: [v2] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC (2020-11-26T02:00:46):
    [v2,1/3] spi: dw: Add support for 32-bits max xfer size
    [v2,2/3] spi: dw: Add support for the Canaan K210 SoC SPI
    [v2,3/3] dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

