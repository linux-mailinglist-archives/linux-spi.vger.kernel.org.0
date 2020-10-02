Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8C281D47
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgJBVAG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 17:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVAG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 17:00:06 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601672405;
        bh=VooAGHrWiwfgaS6PCsdaGB4Ab4uF5VPXHmYGkrkYsDM=;
        h=Subject:From:Date:To:From;
        b=ItdyidGwePubKWV8SKMf+23xoAwoJgU5+6VTBk153N0cr0oraMHl018OECg5XDfbt
         25Nz+uKPCXP/kpOFRC4uthPeafGYdXnvU2/eJYk5QMQLk+fKBvfY3kERbJxrxAh/Rb
         wGbPSMogj0TQnI149ZrHI/OVrLHmDHcJ7EsgY9UI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160167240547.14539.13463483926789373354.git-patchwork-summary@kernel.org>
Date:   Fri, 02 Oct 2020 21:00:05 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v2,RESEND,1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
  Submitter: Łukasz Stelmach <l.stelmach@samsung.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=358407
  Lore link: https://lore.kernel.org/r/20201001152148.29747-2-l.stelmach@samsung.com
    Patches: [v2,RESEND,1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
             [v2,RESEND,2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
             [v2,RESEND,3/9] spi: spi-s3c64xx: Check return values
             [v2,RESEND,4/9] spi: spi-s3c64xx: Report more information when errors occur
             [v2,RESEND,5/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
             [v2,RESEND,6/9] spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
             [v2,RESEND,7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
             [v2,RESEND,8/9] spi: spi-s3c64xx: Increase transfer timeout
             [v2,RESEND,9/9] spi: spi-s3c64xx: Turn on interrupts upon resume
Series: Some fixes for spi-s3c64xx
  Submitter: Łukasz Stelmach <l.stelmach@samsung.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=358785
  Lore link: https://lore.kernel.org/r/20201002122243.26849-1-l.stelmach@samsung.com
    Patches: [v3,1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
             [v3,2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
             [v3,3/9] spi: spi-s3c64xx: Check return values
             [v3,4/9] spi: spi-s3c64xx: Report more information when errors occur
             [v3,5/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
             [v3,6/9] spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
             [v3,7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
             [v3,8/9] spi: spi-s3c64xx: Increase transfer timeout
             [v3,9/9] spi: spi-s3c64xx: Turn on interrupts upon resume

Total patches: 18

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


