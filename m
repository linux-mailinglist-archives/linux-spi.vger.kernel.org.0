Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4837D173
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhELR4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 13:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245247AbhELRGh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 May 2021 13:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74FAC61221;
        Wed, 12 May 2021 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839127;
        bh=pl6QFYggyKEgGFGWijuQGA710WYGSQjCjRLG1PY4TRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NElbabHXinPOID74WkxsGWND1UrbiJqkIDn4aWAfT1auriZPVGNcLxD6QMivw0Wa1
         v60O8d8cr6V7TXFHJAJwuRrGLrDlKoLxMV6v1OtJfLY66pNAnRfbVRveahtakz1hgx
         9sWU1zIl5a8jt+E91oXn0oWS3i/8JpVr6SKBofH1o6pXzisaaEMxmPuAoYWISRW3RC
         2hCOUcZ+AJxyAnrN3n0vZcnJ8nC1CRYVcez784SPCk7CKb5hu5PV5ADvEeL2qxNRd6
         Co2L6QquJB16IsZL+WLsD+2Ia2nvR/L2E8wFxLXNlZU/97c14x/eJ0d1tUL/TEjV8X
         zqmhIC71vsWxA==
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-spi@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH] spi: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 18:04:37 +0100
Message-Id: <162083907219.45027.14385100050123362588.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512093534.243040-1-zhang.lyra@gmail.com>
References: <20210512093534.243040-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 12 May 2021 17:35:34 +0800, Chunyan Zhang wrote:
> MODULE_DEVICE_TABLE is used to extract the device information out of the
> driver and builds a table when being compiled. If using this macro,
> kernel can find the driver if available when the device is plugged in,
> and then loads that driver and initializes the device.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sprd: Add missing MODULE_DEVICE_TABLE
      commit: 7907cad7d07e0055789ec0c534452f19dfe1fc80

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
