Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067FC2AF56A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 16:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKKPse (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 10:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgKKPse (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:48:34 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0409C2072C;
        Wed, 11 Nov 2020 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109713;
        bh=Vje9tSJh73NycJPShBspvjAw9v4lHDiFLPEBIsUQorM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LwPdFOkIGbiFebdmm9Rjevedo87On5lKJOCwPDSwO2bdUum+28ByzKOfzesiRtTMy
         7hTGL7EZKpApQ9elAIfeg/BTzNuIEQ4YMgx1uFPHlmalPC6NrGO6SKsoD4NncvreeU
         Kmo5wmRu3rg4EoF+WO4fKzApjmrJuqwanPxKps8U=
Date:   Wed, 11 Nov 2020 15:48:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org,
        Simon Han <z.han@kunbus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20201106150706.29089-1-TheSven73@gmail.com>
References: <20201106150706.29089-1-TheSven73@gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
Message-Id: <160510968064.12304.14797288117651443603.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 10:07:06 -0500, Sven Van Asbroeck wrote:
> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> introduced the optional use of GPIO descriptors for chip selects.
> 
> A side-effect of this change: when a SPI bus uses GPIO descriptors,
> all its client devices have SPI_CS_HIGH set in spi->mode. This flag is
> required for the SPI bus to operate correctly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix client driver breakages when using GPIO descriptors
      commit: 766c6b63aa044e84b045803b40b14754d69a2a1d

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
