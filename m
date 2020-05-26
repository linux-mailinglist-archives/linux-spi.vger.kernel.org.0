Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C865B1E2766
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbgEZQqP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 12:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgEZQqO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 12:46:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0CC20787;
        Tue, 26 May 2020 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511574;
        bh=l7cy3+L8C73qgjG74eriDphZ8Hg3bEgLDTthsCKHs78=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Cf7NcRvw19ppHK33jNeUXbXpY53gjPp8d5VxuQMDMoU/igHurlSBzNMj5YcchNrAx
         VmbwSaHMTRJBemByIy3IQmf4O55GM7RBEhkgO2AdYShErt3mNilTLCKgI+DKO1vn5D
         rKnEW7tR2cbfyVPL158BAc9ecVcfFgBicwhJd3zI=
Date:   Tue, 26 May 2020 17:46:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200525133120.57273-1-broonie@kernel.org>
References: <20200525133120.57273-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: Remove note about transfer limit for spi_write_then_read()
Message-Id: <159051156064.36444.1340281885240145710.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 May 2020 14:31:20 +0100, Mark Brown wrote:
> Originally spi_write_then_read() used a fixed statically allocated
> buffer which limited the maximum message size it could handle.  This
> restriction was removed a while ago so that we could dynamically
> allocate a buffer if required but the kerneldoc was not updated to
> reflect this, do so.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Remove note about transfer limit for spi_write_then_read()
      commit: c373643b8688836c1627a805875994fe0012fc17

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
