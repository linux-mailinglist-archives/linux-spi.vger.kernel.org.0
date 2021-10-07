Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9B42525C
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbhJGL6y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 07:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232894AbhJGL6y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Oct 2021 07:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B9DA961027;
        Thu,  7 Oct 2021 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633607820;
        bh=b3oVYMBe1ooPC9wV9aHhiq60xxJ9Bt8cwm6B+9Apnr4=;
        h=Subject:From:Date:To:From;
        b=Gga+5EH75q3aQUMIRpJLK+KHgt30+F5Yd0nnKTt4NTQsDOM6JKqN9XVJCo62SY2BU
         Ti/CFO8hxKqx4vA8JpXXBnRDo8BZDWJklgIq2tMVMT2bN98OepOaJbQDqdgtaW7pJZ
         ewZ16IQ9XAmUzS/bMTKMd7O8KEtME9C/bitg5HaSdH3wpzPwQGI95aSK6U+O5YTol2
         wRpyvvgsP+5MYg+fWxabrOrMADx+PYKAz3MOtEEilqgmpgs6S/O/LvahuTBAQUyOzB
         VhXOLLxf2Hkb3jApnRhHBLq/p6vmXkOrx7840NYu+R/dh68dYfk1ETURdRg/zH8v3u
         Zf700Cuse2ckA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACEBF60A23;
        Thu,  7 Oct 2021 11:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163360782070.2043.8404786305712158280.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 07 Oct 2021 11:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-10-07T11:21:29)
  Superseding: [v1] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-09-30T10:07:19):
    [1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
    [2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
    [3/3] Documentation / MTD: Rename the intel-spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

