Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CD2D7D5F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436664AbgLKRwm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390560AbgLKRw1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 12:52:27 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20201209173514.93328-1-tudor.ambarus@microchip.com>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max speed
Message-Id: <160770909978.26609.5466191880976694172.b4-ty@kernel.org>
Date:   Fri, 11 Dec 2020 17:51:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Dec 2020 19:35:14 +0200, Tudor Ambarus wrote:
> Make sure the max_speed_hz of spi_device does not override
> the max_speed_hz of controller.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Limit the spi device max speed to controller's max speed
      commit: 9326e4f1e5dd1a4410c429638d3c412b6fc17040

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
