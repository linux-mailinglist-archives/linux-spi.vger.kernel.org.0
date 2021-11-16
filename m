Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA94538D0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhKPRxH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 12:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhKPRxH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 12:53:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EC358610A8;
        Tue, 16 Nov 2021 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637085010;
        bh=Bl1HpvG2joGAnV+1mfXYIrW09ZIVVzrGzsQ7DIeVqAE=;
        h=Subject:From:Date:To:From;
        b=EOXsTYNaXeIe0faTBfDnxp1O5lYic1zn6hyHbfNB3A03IRA0V3d8PhGKfhsFwEeYP
         aQLZp1XLECkxC0MA4ABrfiep46CkfxCLP/L/wscJog9Me3G1AmyWMugsxdqo2VS2AZ
         ypOLso5YpYNG3EYJ4FpcXNjEFS7Ju8JE8nxyRQ0094yuPQ33StRgOV8q/jwtf3ryQM
         BcU3h6IiPt6UxX/Sl4YiIc6hsjwVMoCvwRcP3vYNoZrDwcmtRqB/8tz1vC8HFh8lVs
         mCVuJ9tFKKPdur3TlHLuvxPG74K/ZL2uZ/BFNnxOOUI87L/UCGSCzS8j74Bdawt0Kx
         DSnL7hONCAYLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB7ED609EB;
        Tue, 16 Nov 2021 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163708500983.22884.476099565491888142.git-patchwork-summary@kernel.org>
Date:   Tue, 16 Nov 2021 17:50:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: dw: Cleanup macros/funcs naming and add IP-core version support
  Submitter: Serge Semin <Sergey.Semin@baikalelectronics.ru>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=580303
  Lore link: https://lore.kernel.org/r/20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru
    Patches: [v3,1/7] spi: dw: Add a symbols namespace for the core module
             [v3,2/7] spi: dw: Discard redundant DW SSI Frame Formats enumeration
             [v3,3/7] spi: dw: Put the driver entities naming in order
             [v3,4/7] spi: dw: Convert to using the Bitfield access macros
             [v3,5/7] spi: dw: Introduce Synopsys IP-core versions interface
             [v3,6/7] spi: dw: Replace DWC_HSSI capability with IP-core version checker
             [v3,7/7] spi: dw: Define the capabilities in a continuous bit-flags set


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


