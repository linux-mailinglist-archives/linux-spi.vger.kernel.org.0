Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5153C3AE7BD
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFUK7X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFUK7W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 06:59:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DAA8B610CA;
        Mon, 21 Jun 2021 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624273028;
        bh=sSDN5bXpnV7oRy1kTrVsupnug7DA3f+C24hK++Wmj24=;
        h=Subject:From:Date:To:From;
        b=Ebqoe/q8xctiCM3zotdwjy5FdispCfkmqu6iKJqdIOIFw8oJlJ3jtnVyu+GB+nHOk
         5MFbgFNFFigOPpOP1hFb0KaSZKDWlzcA8sDy0r6hMD/m0PUGdfn29rM/bKW8I+u5/U
         6y7UsyjFbnQNC0PC1LMYe1xig5tVgb/GxHXNzvMGtvrWz5FTcqikvhcOuomuXz5/ku
         zbfvV1E4imnOGxMEDvfmc6GN/444r04TvVAq7ew58rrj6AEfcTaKRlGwQz+c7ZVtt8
         UiMYVjnBVOPVDjqyHuLDe8tQgdoFUvYGzrsZs0T+WfrxavDfSqYveEAkuylErjIqA2
         GYy5w8bCIzzJg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CCA1B6094F;
        Mon, 21 Jun 2021 10:57:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162427302882.32122.17966564834687534097.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Jun 2021 10:57:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] Support ROCKCHIP SPI new feature (2021-06-21T10:47:54)
  Superseding: [v9] Support ROCKCHIP SPI new feature (2021-06-21T08:58:19):
    [v9,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v9,2/6] spi: rockchip: add compatible string for rv1126
    [v9,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v9,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v9,5/6] spi: rockchip: Support cs-gpio
    [v9,6/6] spi: rockchip: Support SPI_CS_HIGH


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

