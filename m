Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3332A5DC
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbhCBNY4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242462AbhCBA1G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 19:27:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 82BA760200;
        Mon,  1 Mar 2021 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614642876;
        bh=QDGSCePDNhRSvaJVsu8HLs45JWtSz5MZLlAZPyX4wBA=;
        h=Subject:From:Date:To:From;
        b=HinJpyKSfFJpjLqFNeJGbB4ETJB7jCOLMplnx598XyL/6SyVlkxkOBHaujrVv0Ern
         ysz1UifVzQVoAhJ0h0orXK7R0R11pc/UpNkUU9WfTbMHRpzzC2bXprYcwU5PJnZFQK
         2Gbz/Ft0bKL6p/jN3O0oDc17TMhiBu++jxcdP7DLMVJC/PcFqe8HBFtm0O2lL9iFvY
         /C7Sgynh3yrTxfVyvhQSC8PS/pIoRD7MxBSjXTfyXJYfoK5t03COv7D7x3ehkRSb14
         ZGAMlG7bujUMh3AQ1TqTV13z5/8IQd6c/XwI0cj+SSdCvmNw0ikVYxmvMZ1dTr+Euj
         6TNFOTZ344kFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DA036095D;
        Mon,  1 Mar 2021 23:54:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161464287640.7970.16929056515501051427.git-patchwork-summary@kernel.org>
Date:   Mon, 01 Mar 2021 23:54:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [1/3] spi: mpc52xx: Avoid using get_tbl()
  Submitter: Christophe Leroy <christophe.leroy@csgroup.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=430565
  Lore link: https://lore.kernel.org/r/99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu
    Patches: [1/3] spi: mpc52xx: Avoid using get_tbl()
             [2/3] powerpc/time: Avoid using get_tbl()
             [3/3] powerpc/time: Remove get_tbl()
Patch: regulator: axp20x: Fix reference cout leak
  Submitter: Pan Bian <bianpan2016@163.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=419445
  Lore link: https://lore.kernel.org/r/20210120123313.107640-1-bianpan2016@163.com
Patch: coresight: etm4x: Fix merge resolution for amba rework
  Submitter: Uwe Kleine-König <uwe@kleine-koenig.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=428749
  Lore link: https://lore.kernel.org/r/20210205130848.20009-1-uwe@kleine-koenig.org
Patch: [GIT,PULL] immutable branch for amba changes targeting v5.12-rc1
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=426429
  Lore link: https://lore.kernel.org/r/20210202135350.36nj3dmcoq3t7gcf@pengutronix.de
Patch: mailbox: arm_mhuv2: make remove callback return void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=426527
  Lore link: https://lore.kernel.org/r/20210202194308.jm66vblqjwr5wo6v@pengutronix.de
Patch: ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
  Submitter: Bjorn Helgaas <helgaas@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=422933
  Lore link: https://lore.kernel.org/r/20210126202317.2914080-1-helgaas@kernel.org
Patch: [v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml
  Submitter: Michal Simek <michal.simek@xilinx.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=431341
  Lore link: https://lore.kernel.org/r/4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com

Total patches: 9

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


