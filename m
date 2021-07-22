Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6413D2AEA
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhGVQ3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhGVQ3g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ADBC6101E;
        Thu, 22 Jul 2021 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973811;
        bh=J0y6xbtbantf/kVCKwtKZmfOdcq8bh6lH6sDWC8Jwtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnORno1TQEJYgUmFKzK5sD7vJCkC6g0UGItAXfwC6uhYqPj3XVTbCBMYEBjIqxZm0
         JKEgcPHbYUOFfcM95ZiGouMZaBRmVYEN9zIb3qv9xYlkw5b/Tq1sUz/N1R9ANv0mfL
         IE16fPgw2NXbyeQfw1E3K9yoR9FYvXfOBQaEw0mCZbQWSNiWzHJ29y+AKfikCNhSpM
         v24/lrxjrSvlsmFy9qiHeGpSuPIuH77zTSqBr1Rx1gmCw/GBHxB0jMMWE+fJGq4P4w
         R514HxFJc5vmSHZ1/LJzyxevXpSA/+xaMS9Qzd6ulhfue6PjdTH3gwAEsvtPGcQaPJ
         ikggngRYOwndA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Adapt reset_sccr1() to the case when no message available
Date:   Thu, 22 Jul 2021 18:09:55 +0100
Message-Id: <162697114030.3066.8933370918694661458.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210721121520.62605-1-andriy.shevchenko@linux.intel.com>
References: <20210721121520.62605-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Jul 2021 15:15:20 +0300, Andy Shevchenko wrote:
> In some cases reset_sccr1() can be called when no message available.
> This means that there is no associated chip to receive that message
> and hence no threshold needs to be set. Adapt the function to such
> cases.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Adapt reset_sccr1() to the case when no message available
      commit: e3aa9acc71778266cc4743217ff1a1a53caf15d6

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
