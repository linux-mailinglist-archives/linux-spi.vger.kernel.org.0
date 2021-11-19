Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307A6456F2B
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhKSNAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 08:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhKSNAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Nov 2021 08:00:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D6B4D611F2;
        Fri, 19 Nov 2021 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637326631;
        bh=4hiawTnGAD66wVTGLmaTf/YuDjvV4nnn7ZkxtnvhIeM=;
        h=Subject:From:Date:To:From;
        b=Rz5+RQNDFPZCU7jkRMPlbSwqdk5FM42EdA3CmhOcukFFX8Ac+ZHRCp1gSeo/oY6dd
         sDjUI6y/cFfHwFiNkFlkERM9iXS05GvOgpTeFijHmwkGAozpZ1KIdtq8PUOTfKce3w
         1l1vJRNlljnFStn9QuzL0xNfZImQBTTxVI0dAbvGLgP4hkpruNb7Bz/ToQ05HX+59s
         GNQmgUAVpHH2mIOcYyuzhcoJy/tTu/xZy/fQ+0wUVJxedp2qGw0jwxajpVr5RFFhJa
         Ir+GA5aD34cZGRxIzl2dPqrA1xtgAqU3/Z7EYZVLW+t82R5y82Y2UmnXqOmscB9ik9
         w1paDFO6aqW4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CB1EA600E8;
        Fri, 19 Nov 2021 12:57:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163732663182.7478.14434773752716044674.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 19 Nov 2021 12:57:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: docs: improve the SPI userspace API documentation (2021-11-19T12:11:39)
  Superseding: [v1] spi: docs: improve the SPI userspace API documentation (2021-11-18T21:31:43):
    spi: docs: improve the SPI userspace API documentation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

