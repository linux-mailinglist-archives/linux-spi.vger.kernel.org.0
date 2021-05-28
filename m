Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C491F3945AA
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE1QLn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 12:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhE1QLl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 12:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 303D7613DA;
        Fri, 28 May 2021 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622218206;
        bh=/MdRl8bpy8Tel9Y92Lu2J4KQzNqk98kbdCj8XsUZX9Y=;
        h=Subject:From:Date:To:From;
        b=sMAaEmV5p5rPNRSlaD5JzV5G7OqdWkoK+7vxKsQhVzeyZn2KjEqAjHOt04vrYLuy8
         Ikgdan1p3q+Ju43fTpgPmyZ5h62PF5TnwYQnYGJe2PbDyv82U4KqWPb4l2FXvg4ogK
         0652ibUuSKOmHPIhGGWrBClLI9w1tFSWYappXlvELE8MmfKOVmk/d84H0pjkXUE1zz
         +OyCRphyl1d6HEl8KFOaQGkP68O6T30W+I2MW79e9egRBu4yoQFDVBeNpiItRcJ2Km
         3RRMXb6frAoNFJ861W2PehvGySsbdN2RknzShLsKYYpJwttTQ/srvF0hOz1uKo4eNw
         P7ePs9mbc5Oqw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1BFB6609FF;
        Fri, 28 May 2021 16:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162221820605.25662.1710593253062225991.git-patchwork-summary@kernel.org>
Date:   Fri, 28 May 2021 16:10:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v1,1/1] spi: Enable tracing of the SPI setup CS selection
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=489145
  Lore link: https://lore.kernel.org/r/20210526195655.75691-1-andriy.shevchenko@linux.intel.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


