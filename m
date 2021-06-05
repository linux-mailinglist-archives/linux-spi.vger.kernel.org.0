Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9CC39C732
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFEJ6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Jun 2021 05:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFEJ6b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 5 Jun 2021 05:58:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B802A6121E;
        Sat,  5 Jun 2021 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622887003;
        bh=Tt4F1k6rhW3yTlqyznTiF4AE9T0Hd0f95yHNbgxNNm8=;
        h=Subject:From:Date:To:From;
        b=XWzLlwKeuImdeqEtZ0F5XMZ/spuxvUWnSyNiXxPIT/DbMMdmsSaavJZyncNi+lXqd
         66OgOlFhmO/VTVH4uZ+SR5S7TYxLZqgS/s3VjEoiIBgGcr1KebWZLYsiEPMxPv49W2
         PfS3O5lUcWxROZ0g6adKOCSZVHtZA2aK86EJwFLKevoR8oYlZFTWHvNiCIQToIhVcg
         ShtEkEbDJIhjsGbNt44Q40YxyeCLpYWlvgwic2UAQC0/s014a9BSXGsRxC60MyaKMT
         SA1x4YDBiB4EYcFIY4KePihNzLJEH3OqT0yeY5AbTGt6kX//+1gjTcRlOuRu64f0Zj
         jCm/CFKRXcMoQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1266609F7;
        Sat,  5 Jun 2021 09:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162288700360.3424.2137741759830920282.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 05 Jun 2021 09:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item (2021-06-05T09:46:54)
  Superseding: [v2] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item (2021-04-27T07:37:28):
    [v2,1/8] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v2,2/8] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v2,3/8] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v2,4/8] spi: rockchip: add compatible string for rv1126
    [v2,5/8] spi: rockchip: Support cs-gpio
    [v2,6/8] dt-bindings: spi: spi-rockchip: add description for rk3568
    [v2,7/8] spi: rockchip: Add compatible string for rk3568
    [v2,8/8] spi: rockchip: Support SPI_CS_HIGH


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

