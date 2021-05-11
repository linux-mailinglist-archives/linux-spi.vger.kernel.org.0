Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7637A1CB
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhEKI2N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEKI2G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B11E613C3;
        Tue, 11 May 2021 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721620;
        bh=m9zlLDv90RfQ+x96u3VrEpC2hqe/Kaz9L9sKJE/1ISU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAs7NGzyCiNRSXZNAa2ZQpj3Vji726uUIafVdSKJw9qj8It92cE2sRWrtrcs0fSGK
         0lxfh++CxJB37Fjold1O0ToZk7nYhlQUmIMYunFNqTWJZGiCxYGC94TymUG33UUhfC
         deubdBhRdBU6/mXPub7IjtKhgCB6qDQAEJhUeCZ/0zFCSfdpo11uhOGr7Y4zEbpKlM
         TmBUZ6b91U4u6l9s75AqAZLXvCGeaiX2xZjJF0Rs8Bxrj2Nz0VaxVLtIzZ69hEZ9yJ
         X6Dz9B8CIYGL2fgYo4hHqardQMxOBhAVQ373yUdNYdhB2QqWuf0diIN/WpONUWeASU
         yzX0QLt+2TxJw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Date:   Tue, 11 May 2021 09:25:35 +0100
Message-Id: <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> Set of cleanups here and there related to the SPI PXA2xx driver.
> On top of them, adding the special type for Intel Merrifield.
> 
> In v2:
> - cover letter (Mark)
> - drop moving the header in patch 5 (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/14] spi: pxa2xx: Use one point of return when ->probe() fails
        commit: f2eed8caa336e31d672804a8725dadba0415f19d
[02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
        commit: 9e43c9a8d5de4810ea9688519d55b5e46784d84a
[03/14] spi: pxa2xx: Utilize struct device from struct ssp_device
        commit: c3dce24c40cc7cd07deca5b81b763eae66f30856
[04/14] spi: pxa2xx: Replace header inclusions by forward declarations
        commit: 0e4768713e71dd224633fd7e00ad358bc48f433a
[05/14] spi: pxa2xx: Unify ifdeffery used in the headers
        commit: 5edc24901f4d469f8fc943004f73655933e89dbf
[06/14] spi: pxa2xx: Group Intel Quark specific definitions
        commit: 1beb37b0e3f98708bfb37778049764b4500756da
[07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
        (no commit info)
[08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
        (no commit info)
[09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
        (no commit info)
[10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
        (no commit info)
[11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
        (no commit info)
[12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
        (no commit info)
[13/14] spi: pxa2xx: Constify struct driver_data parameter
        (no commit info)
[14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs
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
