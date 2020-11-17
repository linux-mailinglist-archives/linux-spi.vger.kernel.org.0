Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD22B71BA
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 23:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgKQWiv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 17:38:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWiu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C3120715;
        Tue, 17 Nov 2020 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652730;
        bh=lw7G6IpSo/H8/hFVo1fq+gUL1Im6b7QfvDPyFQTlXuU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bfNItgKLtstT4i3s9qXRaIvVnLM5v0dgppHdUzGhnn5/3fkSZhi1jn2nsbXxoTOLB
         2iPv1K2OwDNSAlCWstyfwosw4y5oDWguAqNsn7wy0EIdz6F+AzPeu46XP8LN3iNwsh
         lfQ8O79MgyzN76VSGO3O50kJtG1g09ptxXsnVa9o=
Date:   Tue, 17 Nov 2020 22:38:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kernel@pengutronix.de, shawnguo@kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20201116202606.29888-1-festevam@gmail.com>
References: <20201116202606.29888-1-festevam@gmail.com>
Subject: Re: [PATCH] spi: imx: Remove unused .id_table support
Message-Id: <160565269951.23908.14015311346732871559.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Nov 2020 17:26:06 -0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> .id_table support in this driver was only useful for old non-devicetree
> platforms.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Remove unused .id_table support
      commit: 6e3dbfcb3c8a1ef8cc73a8637f778673f5c6e91c

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
