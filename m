Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1941B4A4C50
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380555AbiAaQj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380554AbiAaQj4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:39:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D1C061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10578B82668
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 16:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C3C340ED;
        Mon, 31 Jan 2022 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647192;
        bh=v1C0Jr5RsN68jb/ZAq9IrmJF7vxV5ynnLRU8szu5eFk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JFTu5Wgny35dgzxR6nzJ3EkugVpZ4NxFtv7fygzF/arRqUSw28WP3iacluZHFKdJ8
         K5C43wxYIfTkPFNHUix5nswBydzhqyuBykw0F/MpvJ7XQfolbM1PvecNgiLidHshQC
         jq0HvTYJLwJNQovIXmVhYXCtiiYc1ZiA0v7EfGATVpSrOT68vIhaPaMG3Ozg3zZQNr
         +yIc1tdEEqIRXar1jq5zovqd2S3QHLjt5FUQb9vuYw/N+Y4y7kgct4W7f6gxsRWlA8
         YU0e+LToo99fq1y4G9IbhqJGkQYdvx7Mg1MfqEEyxByySxFYU/JhOceh5r0174MQ0M
         ZUjuq97ZE14zw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20220125005836.494807-1-linus.walleij@linaro.org>
References: <20220125005836.494807-1-linus.walleij@linaro.org>
Subject: Re: [PATCH v2] spi: pxa2xx_spi: Convert to use GPIO descriptors
Message-Id: <164364719100.1030816.7957554200883067453.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 16:39:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Jan 2022 01:58:36 +0100, Linus Walleij wrote:
> This converts the PXA2xx SPI driver to use GPIO descriptors
> exclusively to retrieve GPIO chip select lines.
> 
> The device tree and ACPI paths of the driver already use
> descriptors, hence ->use_gpio_descriptors is already set and
> this codepath is well tested.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx_spi: Convert to use GPIO descriptors
      commit: 31455bbda2081af83f72bb4636348b12b82c37c1

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
