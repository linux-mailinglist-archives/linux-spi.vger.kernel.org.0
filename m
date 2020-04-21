Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F271B2AA5
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgDUPGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 11:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUPGI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 11:06:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99A5206D6;
        Tue, 21 Apr 2020 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587481568;
        bh=4ADim16T+0u2BglcyovCuf/IIjoL8W8PhOujJLyZSGY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Kxm3YcSHyHIXzDQAStma9KNvqYRZ5pyKFzGDqMVKNNj4lHR5mJ679glTavCTRbGU6
         cFJ9Fpfxyp/jynNwxRkBw0dKGDeHsKyEeVE8buMsRGqHtTDFj5h6wlBDhCpE+OWg7q
         GwDjN6E5JhHlh6/7qLHWGQ4XcO5DUnnUYtZinMS0=
Date:   Tue, 21 Apr 2020 16:06:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200420190853.45614-2-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com> <20200420190853.45614-2-kdasu.kdev@gmail.com>
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-Id: <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Apr 2020 15:08:45 -0400, Kamal Dasu wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> The clock provider may not be ready by the time spi-bcm-qspi gets
> probed, handle probe deferral using devm_clk_get_optional().
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

Thanks!

[1/9] spi: bcm-qspi: Handle clock probe deferral
      commit: 0392727c261bab65a35cd4f82ee9459bc237591d
[2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
      (not applied)
[3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
      (not applied)
[4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
      commit: 742d5958062488d03082a9ff01a6afb3cf7bd634
[5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
      commit: 4df3bea7f9d2ddd9ac2c29ba945c7c4db2def29c
[6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
      commit: 1b7ad8c405c3dc0ad6c2dc61fe21fe7a446cceeb
[7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
      (not applied)
[8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
      (not applied)
[9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers
      (not applied)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
