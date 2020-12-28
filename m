Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA022E33F5
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgL1D5Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 22:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgL1D5Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 27 Dec 2020 22:57:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 22833208B3;
        Mon, 28 Dec 2020 03:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609127804;
        bh=EztJROUockiGF6w5qAJwzfYY/nwVBdQIsL5LNuzQY6U=;
        h=Subject:From:Date:To:From;
        b=fZI66/koFF5V3tJc1bDAWJwZ4/J6HYfSf3E8EFnGz1MhZ14VqQD8l8nF3dw2kJMYM
         +m8+NY4rfs4/9/oXL/eGSSfVHGiKoJ1Nf4sprG1UTOfDooGZMlKMHwKpay3aDjlGK3
         guc8pojjxjhl9QsOlfwsP9tkM6IoOgEGzPIjFvuCVmCa6cXjyGcP5ZnmsakTY37uvJ
         ofdNPgvlD7PJugsM57Pq2kWLOZbKEwG61fDlUvlE5sNo4NvfJ36TlG2hqfwFwgQSLv
         tN4wr9kILsPoRgunFzKEdKnKp2z4NYqqbgdn/J59SaaB4MwWxpayiPN+o1ePnEYRF7
         LYrvBtroH9p6Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 148EF60108;
        Mon, 28 Dec 2020 03:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160912780407.11723.6832033352409631517.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Dec 2020 03:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-28T02:59:39)
  Superseding: [v5] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-26T09:12:00):
    [v5,1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
    [v5,2/4] spi: ls7a: Add YAML schemas
    [v5,3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
    [v5,4/4] MIPS: Loongson: Enable Loongson LS7A SPI in loongson3_defconfig


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

