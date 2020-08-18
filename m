Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297DF248E03
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRSd2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 14:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSd2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 14:33:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A0E2075E;
        Tue, 18 Aug 2020 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597775607;
        bh=WzDKOEV/3ks4Vq2RN+XSt37lu7nxqBdwZ04dCcUGLBg=;
        h=From:To:Cc:Subject:Date:From;
        b=fb9EWL9YOJItYrJqb/2kU4UIycl2aJUAdHj+iNBltATniz7K7UJMgEZ4Li5ydb7FV
         yeLXOUeUWot9aEbsnKqjPzKPEhMYWdFXr+DDMBCydJpMrgUcDGe+/k2jqonXH4hj8X
         mTOGx82tEqESa8N93diDsrriQwtd88ZgxqF8Lfew=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.9-rc1
Date:   Tue, 18 Aug 2020 19:32:51 +0100
Message-Id: <20200818183327.30A0E2075E@mail.kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 1d5cd4e7773c834db011f6f0989b1882adbf13c9:

  Merge series "Some bug fix for lpspi" from Clark Wang <xiaoning.wang@nxp.com>: (2020-07-29 14:51:14 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc1

for you to fetch changes up to 8cb61d65b1c8d5bc5b37ebab498ca2f78d264ddb:

  Merge series "spi: stm32: various driver fixes" from Alain Volmat <alain.volmat@st.com>: (2020-08-10 19:55:35 +0100)

----------------------------------------------------------------
spi: Fixes for v5.9

A bunch of fixes that came in for SPI during the merge window, a bunch
from ST and others for their controller, one from Lukas for a race
between device addition and controller unregistration and one from fix
from Geert for the DT bindings which unbreaks validation.

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: always perform registers configuration prior to transfer

Amelie Delaunay (3):
      spi: stm32: fix fifo threshold level in case of short transfer
      spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
      spi: stm32: fixes suspend/resume management

Antonio Borneo (1):
      spi: stm32h7: fix race condition at end of transfer

Geert Uytterhoeven (1):
      dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs1-sel

Lukas Wunner (1):
      spi: Prevent adding devices below an unregistering controller

Mark Brown (1):
      Merge series "spi: stm32: various driver fixes" from Alain Volmat <alain.volmat@st.com>:

Tobias Schramm (1):
      spi: stm32: clear only asserted irq flags on interrupt

 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   1 +
 drivers/spi/Kconfig                                |   3 +
 drivers/spi/spi-stm32.c                            | 100 +++++++++++++--------
 drivers/spi/spi.c                                  |  21 ++++-
 4 files changed, 86 insertions(+), 39 deletions(-)
