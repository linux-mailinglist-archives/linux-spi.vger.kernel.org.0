Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461A42959B6
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438092AbgJVH4I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Oct 2020 03:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509075AbgJVH4I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Oct 2020 03:56:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603353368;
        bh=L+ihSyJd5H30O984ztR1E32S/UuQVGXiBb2bEE8WoNk=;
        h=Subject:From:Date:To:From;
        b=do3Ib9NFVqm8ElZJYkqLlIgWvzRaHbl0rG2hwF4sFvUczwdT3kqEwSJWhRwqx32Mc
         q1wln/ioS/Y0f/wLsCQWEfdyzb4LrRaSnw3XoDe9/a1XV7j0JSoHYLr9uvWXs/OgUN
         v4+IgYouv/caJ2I2ttNHS79MyDCA6+/P62t3Xsmg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160335336785.1082.11836887824810626087.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Oct 2020 07:56:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-22T07:52:21)
  Superseding: [v2] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-19T14:58:33):
    [v2] spi: spi-sun6i: implement DMA-based transfer mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

