Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938BC34C212
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2C4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhC2C4h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 28 Mar 2021 22:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3123E61932;
        Mon, 29 Mar 2021 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616986597;
        bh=L5sQqTRoR4DbOzmWhT35fdAZYLv1FlILNyG80xHvZMg=;
        h=Subject:From:Date:To:From;
        b=EaVli93vRtWEYzvLU6+eNrzyo6vcnV65WeJofWUH1DcbM7B3VSv3fNe8czJjJsOwl
         prdQSsfrkPmTHwn1jRBLGxqSTCBUuhe+C1VtMn3L/qMrSM2crHV8Ic1QJjOWu9YwvJ
         cBdixGw5L8i6DQnbvCz73L/i8XxWGlY3OJPmuvgAjbT74NbvBz/KD718ESrbeoSvzI
         tI1BerltfAbSCPEZLjWTMunMdJriEQXWaZCZlFUW3iuihDfy0rGM+0pfGwooKcIARN
         +KPhG9oeTotzaw2WNQQNpp6Kmp4EUGrP0VsN51gxKxHRfo3NmXGIjPTds15FD6AFFO
         1WSnzR3AWMHjQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1EFC260A3B;
        Mon, 29 Mar 2021 02:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161698659707.9779.17835880237616092783.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 29 Mar 2021 02:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Support Pensando Elba SoC (2021-03-29T01:59:27)
  Superseding: [v1] Support Pensando Elba SoC (2021-03-04T03:41:33):
    [1/8] gpio: Add Elba SoC gpio driver for spi cs control
    [2/8] spi: cadence-quadspi: Add QSPI support for Pensando Elba SoC
    [3/8] spi: dw: Add support for Pensando Elba SoC SPI
    [4/8] spidev: Add Pensando CPLD compatible
    [5/8] mmc: sdhci-cadence: Add Pensando Elba SoC support
    [6/8] arm64: Add config for Pensando SoC platforms
    [7/8] arm64: dts: Add Pensando Elba SoC support
    [8/8] MAINTAINERS: Add entry for PENSANDO


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

