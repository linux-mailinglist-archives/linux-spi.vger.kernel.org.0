Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D40222F91
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgGPX6q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 19:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2C120760;
        Thu, 16 Jul 2020 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943925;
        bh=UrQzO724UtSTQ7IKx66zegNUGqB6aVe9FXF7F4V8IM0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SPeCUHvxqY4I/M9AGNMKWRMFRPR2djwcPqfcjEUnxZvDHMnsmH9gAjsUYYvS6B+fj
         l15TxkTs8cDivPzMCIVVLcOue/5qMW9HiQG6jY6qkTgz1V88Rhv4rYXt9X9KnPxQeP
         FJDO3DeKWHXbYZHRz9OnO324c71EhbcPdgFIpC1E=
Date:   Fri, 17 Jul 2020 00:58:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
Subject: Re: [PATCH v2 1/2] spi: omap-uwire: Use clk_prepare_enable and clk_disable_unprepare
Message-Id: <159494389042.42455.11301873090946595161.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jul 2020 13:26:46 +0800, Qing Zhang wrote:
> Convert clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare() respectively in the spi-omap-uwire.c.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: coldfire-qspi: Use clk_prepare_enable and clk_disable_unprepare
      commit: 499de01c5c0b813cc94dbfc722ec12487044ac4a

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
