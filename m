Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482AD259A0
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEUVE4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 17:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfEUVE4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 May 2019 17:04:56 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558472695;
        bh=bkUkNNEVXi+cqsfp+W2xe4T2ZHKKcUl0JyNumVREB2U=;
        h=Subject:From:Date:References:To:From;
        b=pJSZ1O662PGRNlI03YN2pE3lMiAuc6QAJ7HEHMIdPntRBIp6nA3/NDCF2dFIdsF5Q
         icsVHtv3xuAqyNUHydOnzUHLGxwoajPCNkACcgC01i2RwTcZGuGjHK4cnJk40/fEnm
         tyiDOnb6cN4Mp7I2fEUKvdrGRgLRLKUKHhTDEK7I=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155847269580.30502.12951722878955280704.git-patchwork-summary@kernel.org>
Date:   Tue, 21 May 2019 21:04:55 +0000
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>,
 <20190429162246.6061-1-olof@lixom.net>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v1] dmaengine: idma64: Use actual device for DMA transfers
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=93067

Patch: spi: zynqmp: Fix build break
  Submitter: Olof Johansson <olof@lixom.net>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=111559

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
