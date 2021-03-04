Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3A032D601
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhCDPHA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 10:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhCDPGt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:06:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCB164F6C;
        Thu,  4 Mar 2021 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614870369;
        bh=WwXEOafPN4pplewW8IiKU4Hz1t2+OCoJmRdK8oiDdGg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Vs+5OXQwPkIXjHzfus5GI4o1Koa2l+qhMBZa1bmiqEg8kZLRHc9hE2WNorA3VH5kd
         TBxx0sLqLgvOaDvf1HJsOedsE4ltXgNavSOd3bPWQOz6AH5rgDlaJRkohI5bZR3R6U
         ZAxBaojh2Mbn6vXQluUIJ6Kz53ij13JA3thQ3LO1fpd3S312WcDuYIDrxmqTnxfSHG
         3ItVRCFN0+vedKAsQWwqWfCTuoy8T02UZPS8/so2IsaCC4NeZPpekqJ28SMx4q6eFe
         wEoWYH3Bi4dYEfqRnIS9HINnstg4ehdvXTcPgQ/JsL1T4tAJcTnUtmN2gkwrfrN3CU
         reo+GyDQYf9SQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/3] parport: Introduce module_parport_driver() and use it
Message-Id: <161487030158.30767.2653585264791466653.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 15:05:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 3 Mar 2021 11:16:39 +0200, Andy Shevchenko wrote:
> Introduce module_parport_driver() and use it.
> Greg or Mark, since we have this series tagged, can somebody of you pick it up?
> 
> Changelog v3:
> - added tag on patch 1 (Sudip)
> - Cc'ed to Greg
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] parport: Introduce module_parport_driver() helper macro
      commit: 9c9b536e1ee94558f1ae5ed8d13b76295b2dfef4
[2/3] spi: butterfly: Switch to use module_parport_driver()
      commit: ef3a5316f41fa027cb00b158324a5ef7e3d1a277
[3/3] spi: lm70llp: Switch to use module_parport_driver()
      commit: 7ea6fd9ba47853fb9e88b18d34fc60c71a3fd070

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
