Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188EA225D44
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgGTLUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 07:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgGTLUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 07:20:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595244009;
        bh=KkttNLB6GgZv+bqYkbg+MfQacJ8nhoC6bn1yiVv4cZo=;
        h=Subject:From:Date:To:From;
        b=lMnnZOJpLMOXAT6inxceY2YIUHQJatrHOCmUIRDC45cYIs/j2NWYpH7pP6K6Mt2tU
         2NPrcWUrSRC+DPAT83iHenyQ1SAC4wiYBHhqacczOCozatl9dNRuLyndmbN6YnTdPV
         D5yIQVKpzOVaNZ8+TNeS1dI/+Nr5cT+DvCsHoreo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159524400974.32299.2168786724732041126.git-patchwork-summary@kernel.org>
Date:   Mon, 20 Jul 2020 11:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Rid W=1 warnings in SPI
  Submitter: Lee Jones <lee.jones@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=320171
  Link: <20200717135424.2442271-1-lee.jones@linaro.org>
    Patches: [v2,01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
             [v2,02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
             [v2,03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
             [v2,04/14] spi: spi-ep93xx: Fix API slippage
             [v2,05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
             [v2,06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
             [v2,07/14] spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
             [v2,08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
             [v2,09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
             [v2,10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
             [v2,11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
             [v2,12/14] spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
             [v2,13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
             [v2,14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
