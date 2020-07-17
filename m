Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF44223FD5
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQPnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 11:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQPnP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 11:43:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51330208E4;
        Fri, 17 Jul 2020 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000594;
        bh=hw42Xz9G1vvSM2VPyA5G5Ss96DrG5l32n4hdBDRkSTU=;
        h=From:To:Cc:Subject:Date:From;
        b=tWD6kbReL6ddQ8lfjggJLNrdX1S8OeQTbuwdFldGMU1a3gZifg/DDWRX2hp0nfGS2
         VGdCGE9FP7UTs1LCybWFP9rK2XHhMLIItgyMI+C/DkZHJ14WaHDDkZhwAuSRZUXGjY
         CBdv1ZmFmcbAQlyNP4Grj1PK7Qsf9R3WT9KDP/5s=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.8-rc5
Date:   Fri, 17 Jul 2020 16:43:02 +0100
Message-Id: <20200717154314.51330208E4@mail.kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit cf961fce30f8269d0c2662c48b2618005b67dfd4:

  spi: pxa2xx: Add support for Intel Tiger Lake PCH-H (2020-06-25 15:50:50 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.8-rc5

for you to fetch changes up to ed7815db70d17b1741883f2da8e1d80bc2efe517:

  spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate (2020-07-06 16:39:45 +0100)

----------------------------------------------------------------
spi: Fixes for v5.8

A couple of small driver specific fixes for fairly minor issues.

----------------------------------------------------------------
Marc Kleine-Budde (1):
      spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate

leilk.liu (1):
      spi: mediatek: use correct SPI_CFG2_REG MACRO

 drivers/spi/spi-mt65xx.c | 15 ++++++++-------
 drivers/spi/spi-sun6i.c  | 14 ++++++--------
 2 files changed, 14 insertions(+), 15 deletions(-)
