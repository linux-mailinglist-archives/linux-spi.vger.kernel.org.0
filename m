Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682B4411435
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhITMVc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 08:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237696AbhITMVb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843A86109D;
        Mon, 20 Sep 2021 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140405;
        bh=ZuqWbWsmJdT1zt8kIp2oxlEwOHiSglqsHFzFIv9Tc4o=;
        h=From:To:Cc:Subject:Date:From;
        b=ncEZNfciBAH/ZMglRRkODj+3RJJ7WvI9401mdynnX+Lt274vkaJWqiII6uVhZaOtX
         fl4jehBpzaVTENEmP/me7ENq6RJA1Zn4Yvr3WpiXL51cOJD/+9EgkoMXbjb6nWqsRz
         O36vu/fe8+0OopLMw/lVCkEvmoajGeM238ZfHA+IYZjsSfTpS049oSGciiG/ysXI7c
         tvH1E24dgu3t0DyM9N8raV7k6wCX+iy7pMJ7X6veiQ194EqIfzQ2NJbp2ewqW1d5Y1
         HQ0G+UUJpPgjHR3m9q4SwhoYQ2/zpmegQWoX+NYVUDCxWpipcEB952n0pKil21sCH1
         Kf0ZRx40CyOJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.15-rc2
Date:   Mon, 20 Sep 2021 13:19:02 +0100
Message-Id: <20210920122004.843A86109D@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 26cfc0dbe43aae60dc03af27077775244f26c167:

  spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible (2021-08-26 13:42:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc2

for you to fetch changes up to 2bab94090b01bc593d8bc25f68df41f198721173:

  spi: tegra20-slink: Declare runtime suspend and resume functions conditionally (2021-09-09 14:16:27 +0100)

----------------------------------------------------------------
spi: Fixes for v5.15

This contains a couple of fixes, one fix for handling of zero length
transfers on Rockchip devices and a warning fix which will conflict with
a version you did but cleans up some extra unneeded forward declarations
as well which seems a bit neater.

----------------------------------------------------------------
Guenter Roeck (1):
      spi: tegra20-slink: Declare runtime suspend and resume functions conditionally

Tobias Schramm (1):
      spi: rockchip: handle zero length transfers without timing out

 drivers/spi/spi-rockchip.c      | 6 ++++++
 drivers/spi/spi-tegra20-slink.c | 5 ++---
 2 files changed, 8 insertions(+), 3 deletions(-)
