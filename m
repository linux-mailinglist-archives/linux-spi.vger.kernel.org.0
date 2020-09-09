Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC5263419
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgIIROJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbgIIPa1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:30:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0AD2226B;
        Wed,  9 Sep 2020 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665392;
        bh=bTPV+b2F+O8mZl5m+rEc7R2fRR7xn414cUCQRo2lkWE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wK9pQjITmFNpABmdHgtYnpyw6pINXkxYlGY2SVqPByTN4/cRDEFU6RdTfu2994zQT
         TkQtuxDoI1zcgLac0pDJkmpCUk4Pm2SITvCCQs7uUbLJQ+fSsEYuyF32FSKFz1G/pn
         4uG0p8+8Xme/vb3Q/7H4pDILUke2RzGTCxZ4ECXE=
Date:   Wed, 09 Sep 2020 16:29:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gustav Wiklander <gustav.wiklander@axis.com>
Cc:     kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20200908151129.15915-1-gustav.wiklander@axis.com>
References: <20200908151129.15915-1-gustav.wiklander@axis.com>
Subject: Re: [PATCH v3] spi: Fix memory leak on splited transfers
Message-Id: <159966533166.54485.5131458985432075382.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 8 Sep 2020 17:11:29 +0200, Gustav Wiklander wrote:
> In the prepare_message callback the bus driver has the
> opportunity to split a transfer into smaller chunks.
> spi_map_msg is done after prepare_message.
> 
> Function spi_res_release releases the splited transfers
> in the message. Therefore spi_res_release should be called
> after spi_map_msg.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix memory leak on splited transfers
      commit: b59a7ca15464c78ea1ba3b280cfc5ac5ece11ade

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
