Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6524B367309
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbhDUTEi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 15:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239751AbhDUTEi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D0B161454;
        Wed, 21 Apr 2021 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031844;
        bh=P7p/m28LizpKpkNHqvzpsT87mFsAqXnMWUuzJeLptMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jebVWKKCJHeyZjm0zAe3vAMwAGFFd7v9v67M2vWfVx6KoZM3FO8wubigqfZS/903m
         kWlumnspx/UcZSU40TkXg48UhcOeEtOFuncuHCZBDYjttD+A4ygN8DZ4soKXPpM1fH
         yVndtAItH9uqhiG09Y6YjuWbKwWYe22QJSt/5ONbwz4S6M7pTwVZtScQU++i7tDAn+
         k9eIxU6or2DSitIgUgw58zRxjS05oYHPS4G98tbFem4NYgNH18MD59rOVnys+W/Oip
         T5Rd08ijsNN6iKhW4Os4ruatreD7Mhr72I542C+EEj3rSne0tCZpM0mehzod9xlsEF
         R4vbmIIBlVqQA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: Allow to have all native CSs in use along with GPIOs
Date:   Wed, 21 Apr 2021 20:03:24 +0100
Message-Id: <161903040536.13608.17759253372901499681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420164425.40287-1-andriy.shevchenko@linux.intel.com>
References: <20210420164425.40287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Apr 2021 19:44:24 +0300, Andy Shevchenko wrote:
> The commit 7d93aecdb58d ("spi: Add generic support for unused native cs
> with cs-gpios") excludes the valid case for the controllers that doesn't
> need to switch native CS in order to perform the transfer, i.e. when
> 
>   0		native
>   ...		...
>   <n> - 1	native
>   <n>		GPIO
>   <n> + 1	GPIO
>   ...		...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Allow to have all native CSs in use along with GPIOs
      commit: dbaca8e56ea3f23fa215f48c2d46dd03ede06e02
[2/2] spi: Avoid undefined behaviour when counting unused native CSs
      commit: f60d7270c8a3d2beb1c23ae0da42497afa3584c2

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
