Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A73944AD
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhE1O6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236769AbhE1O6U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 10:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D9764610A5;
        Fri, 28 May 2021 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622213804;
        bh=ShL31bG+bVDIyVnevnXYOQ2++bb9af/LSsKw/EcY+Fo=;
        h=Subject:From:Date:To:From;
        b=Aq836RjSd5EBYqIqtUS8lXNTC2wbX2dcx3LZwVJmqEvan7H3MRwtDp+N/+wUR5msW
         ho5RHUGkwJw/5TKbbnED0DxHy8dd8gxEca2gRwiVGElECorKgH621OBWZ0tInVjSzr
         G7itRRFffxxMvn4nobxf452y9/QmjvCUSg8fLqBVReTR9FEDVlNVs00WnUWTMF1FOR
         J9LOTGRvAllQ50b0Ck7ixyUTp8IEml6T+gHdKhFy1SOkFgfVWiw7pD9r92XCSi9i1G
         BeY9NoR+nLgWBcA4RCkQkOQJRmTGznxVZDornYqL4h5BcpnPBzLrihxVbEwWbfY+Dx
         IdOHvW0KtfdJA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C7C47608FB;
        Fri, 28 May 2021 14:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162221380481.25676.17696089545273828350.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 28 May 2021 14:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] mtd: spinand: add SPI-NAND MTD resume handler (2021-05-28T14:16:36)
  Superseding: [v3] mtd: spinand: add SPI-NAND MTD resume handler (2021-05-27T16:12:52):
    [v3,1/3] mtd: spinand: Add spinand_block_unlock() helper
    [v3,2/3] mtd: spinand: add spinand_read_cfg() helper
    [v3,3/3] mtd: spinand: add SPI-NAND MTD resume handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

