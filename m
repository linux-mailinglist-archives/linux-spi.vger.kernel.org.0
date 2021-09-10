Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA06406B12
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhIJL56 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 07:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232613AbhIJL56 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Sep 2021 07:57:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2BC06610E9;
        Fri, 10 Sep 2021 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631275007;
        bh=OGmkS4PpOk7q/ncAtyRT3nApOLPB43Jdk3he1dEhTJo=;
        h=Subject:From:Date:To:From;
        b=tzJvOQkWUHS6hdljqJ2+lUcqQkbxhgBpzEqWheuATDgwuujCgRqA+aa9A9MLM4JAp
         YBmRGs+mWGWqkIvUkCr6KTaDO4Z1dKUdQNLfoOERe51Jt2J/JesStbSPsQfok0wfdS
         Wrt4OzE1ZhTpxpNkA8JaKsig+i5lMiLPMD2nNh6QWySIxOSTRaBn0zoD5uTBKRDjUs
         42BxxAM8ru/CE5xNf2BtMs9jroW2w/zG0RlHiN3NCeLjz7jT2El7VQ0PNOsEnQLQas
         26gjAbVemlc0wxRPsyFadARQ4pfjyzoSV8z+NBquaTdnH1XZ4dUkDe1VNf+G0JrJTW
         U5ms+m2+PohRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 24A24609F8;
        Fri, 10 Sep 2021 11:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163127500714.29936.2213939349434581974.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Sep 2021 11:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: amd: Refactor code to use less spi_master_get_devdata (2021-09-10T11:15:27)
  Superseding: [v1] spi: amd: Refactor code to use less spi_master_get_devdata (2021-09-09T11:10:02):
    [1/4] spi: amd: Refactor code to use less spi_master_get_devdata
    [2/4] spi: amd: Refactor amd_spi_busy_wait
    [3/4] spi: amd: Remove unneeded variable
    [4/4] spi: amd: Check for idle bus before execute opcode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

