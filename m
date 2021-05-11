Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF837AE5B
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhEKSXc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhEKSXb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B81861207;
        Tue, 11 May 2021 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757344;
        bh=Uw8hsDGMWdFoqrkXWoAq4pDRF5iQaFJRHfiWp/r+0k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5z0TeK8lfntTLwn1hiDzHZpXxCl+p6hcLXN1u3FqVync0FV7/wBxQJDPhLf2AXxw
         6BtlB4oCmNBndxdGupB2u5FpMK07kbCHpd34amI+Z8uwcLP3dTpAv3Wbpg8Ql2GYWV
         hH5bypkYxa+DFWq/FP2WQqG3J/2AK9NZG0N8cPRNHxY8P9088z3VmZp7vnftcGEhSM
         KXIssY5BbtGuTIpc4Qztmoxzva2coOp6jmS/r+LABv/H0Vz5mBTvTAwZZRAv+RpJhc
         7NVygrPS69p3itqpAAWhH2xL7FFzzJCuM5kNaXt0n3ewtb6BtQW4BK42nAcH3g+El0
         AYXTOBoiADz0Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] spi: pxa2xx: Set of cleanups
Date:   Tue, 11 May 2021 19:21:27 +0100
Message-Id: <162075727215.18180.8620014243960066654.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 15:41:20 +0300, Andy Shevchenko wrote:
> Set of cleanups here and there related to the SPI PXA2xx driver.
> On top of them, adding the special type for Intel Merrifield.
> 
> In v3:
> - rebased on top of v5.13-rc1 and/or spi/for-5,14
> 
> In v2:
> - cover letter (Mark)
> - drop moving the header in patch 5 (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
        commit: ab77fe8935c57d1339d3df64957f32e87f0d5ef3
[08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
        commit: 4761d2e7e51cfbe6fdb4e95903d407927f519f50
[09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
        commit: 0c8ccd8b267fc735e4621774ce62728f27d42863
[10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
        commit: 1bed378c6b9116c51ae59b970cf3d9b4e9e62ced
[11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
        commit: 42c80cd439a938569a86f6ae135d38c1cda5569b
[12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
        commit: 6d380132eaea536bef641f21847c8a7987e96ad8
[13/14] spi: pxa2xx: Constify struct driver_data parameter
        commit: eca32c3974c0664f88fed90b327f473bd18a4809
[14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs
        commit: 3fdb59cf10b020b32b9f1dfc78611320623dcb3e

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
