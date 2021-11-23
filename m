Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6E4598C5
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 01:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhKWADr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 19:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232696AbhKWADh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CADC6103C;
        Tue, 23 Nov 2021 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625630;
        bh=ZTgLdC0htMeZLvdhWulKKU+v1OiwqkMI47G8i1tGfhc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=FxMmpAUDhgIRoFU6rwazTFtLVu5TVb59KZ8YLpH88X10KEJ7AWw3FGiD5blK9OApz
         poZ7ssNcn8qpJSgidgP/B4sFG6I8y9LTx1ArfNHv0wlw8lGZH9Sbo9GO045mrSvzhl
         BoFte7RhxZ0oFNlBTC08sdxXbe95BP2id8M0g9AQzKmPNfONbzPleIkU4DohOroTEi
         uLk9uDSJijALRfq6/KIoPZyn6tSU682F9+yfTb+ge4cZllwxEQ19stn0JEItpF+KM7
         ueAmJ1SHSEAvkW1KzhI1KKKv1W5LNbVijCWGQ0U2o4VjDozY+kdKQQ+TWJaMwFuldm
         2AmuKXgyAqfvw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: deduplicate spi_match_id() in __spi_register_driver()
Message-Id: <163762562904.2472045.10269153902428824704.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 00:00:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 19 Nov 2021 19:37:17 +0200, Andy Shevchenko wrote:
> The same logic is used in spi_match_id() and in the __spi_register_driver().
> By switching the former from taking struct spi_device * to const char * as
> the second parameter we may deduplicate the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: deduplicate spi_match_id() in __spi_register_driver()
      commit: 3f07657506df363709a37f99db04e9e0d0b1bce7
[2/2] spi: Fix multi-line comment style
      (no commit info)

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
