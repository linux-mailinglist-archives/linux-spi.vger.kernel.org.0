Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343833AE69C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUJ7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 05:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUJ7G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 05:59:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2173C61151;
        Mon, 21 Jun 2021 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624269412;
        bh=SxZnU9vl0p5hjFqTvaA7TQ66vXoBZ4PS9/rII4kt8S0=;
        h=Subject:From:Date:To:From;
        b=KgtxoozkplE5AzlSiDShc7ruN7t6AqyJtGDLn5hPXUA3uIboHjr4plAFIj8WKraV0
         +1jtSAJIZxnny+sxNKmYTz96xfrfVvtRsKSiOvfGMZQtPgJmlK41D6cKcD++bacAdn
         /9nJ1GmtfzRqbkzvn9qk5/QWYaLjQvjp9l/rg0jvDM/THsY/AoGXgdqPKr9/N9mdvO
         R/FR6hnTzzBY4hjGF9LOC8qdRYIjTIde0m0xDFKZ7U+0AbBp4znW4VlvDzK6Y+qkVT
         oeDuvdVMcVpJ+Oqz5DCgqpq1fpRh276SwEXcCUEujcj3VXcSTJ+RcMVr1AC6BfjZe+
         7Knf0fDNRmRBw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 15C6660A35;
        Mon, 21 Jun 2021 09:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162426941208.2272.12155271990183920842.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Jun 2021 09:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] dt-bindings: spi: omap-spi: Convert to json-schema (2021-06-21T09:28:58)
  Superseding: [v2] dt-bindings: spi: omap-spi: Convert to json-schema (2021-06-08T05:20:09):
    [v2] dt-bindings: spi: omap-spi: Convert to json-schema

Latest series: [v9] Support ROCKCHIP SPI new feature (2021-06-21T08:58:19)
  Superseding: [v8] Support ROCKCHIP SPI new feature (2021-06-15T03:32:08):
    [v8,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v8,2/6] spi: rockchip: add compatible string for rv1126
    [v8,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v8,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v8,5/6] spi: rockchip: Support cs-gpio
    [v8,6/6] spi: rockchip: Support SPI_CS_HIGH


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

