Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73778223D8B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGQOAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 10:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgGQOAV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 10:00:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994421;
        bh=VKrDuU5UJ5xX4ghmhBpTW8ypAHD+vilvRq/yLisiMEE=;
        h=Subject:From:Date:To:From;
        b=UN3i9R8fjEl5otQPHhb7DQIHo2HJbkyhynCUYfvYeAsdABTvEDCtePznkFMCkQz3Q
         OJ3XizKkhDc+iy5VOdhj0WVFIQpsxuocmhzrdVZfRWujZ1UpN6lAk6NFG5ZOy1OMS1
         a7UIY5iehzirv+hooHBBj5PoZy3Q5/w99uYEst2o=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159499442163.17337.8559210407530338066.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Jul 2020 14:00:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Rid W=1 warnings in SPI (2020-07-17T13:54:11)
  Superseding: [v1] Rid W=1 warnings in SPI (2020-07-15T15:06:18):
    [01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
    [02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
    [03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
    [04/14] spi: spi-ep93xx: Fix API slippage
    [05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
    [06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
    [07/14] spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
    [08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
    [09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
    [10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
    [11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
    [12/14] spi: spi-at91-usart: Make use of the defined 'struct of_device_id'
    [13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when
    [14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
