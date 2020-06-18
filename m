Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7671FF670
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFRPUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFRPUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592493617;
        bh=NTKLfPva2y1Qfd/pD0F0oA8h4O9JiS7Qe1vXmXwLhFU=;
        h=Subject:From:Date:To:From;
        b=BHCuRORcXsvBNbM1YplPTUlHhzcrvulmYemeVMCGu54DuA/yEd7iKs+LM3QZjkLoF
         +Og1xxVT+N+sijPjakq4UixLz71fbiQgr4JusUWM/FC9zZhdFxFfwrGZqtUb+kvtj6
         oG9/vbTqqx3q0CyH8ZqPJmwhc8gqA72cw6A8+wnA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159249361748.11477.17617425409636453575.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 18 Jun 2020 15:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-geni-qcom: Fixes / perf improvements (2020-06-18T15:06:23)
  Superseding: [v3] spi: spi-geni-qcom: Fixes / perf improvements (2020-06-16T10:40:45):
    [v3,1/5] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
    [v3,2/5] spi: spi-geni-qcom: Mo' betta locking
    [v3,3/5] spi: spi-geni-qcom: Check for error IRQs
    [v3,4/5] spi: spi-geni-qcom: Actually use our FIFO
    [v3,5/5] spi: spi-geni-qcom: Don't keep a local state variable


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
