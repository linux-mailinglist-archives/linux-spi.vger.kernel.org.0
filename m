Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B913F2E3C
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhHTOkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhHTOkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 10:40:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F07F061102;
        Fri, 20 Aug 2021 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629470378;
        bh=rmyft8QAhVGJOYziap1b+7B6+E/IRplRFw/aa+Gh8nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAxY8SX0UxjbIOyvwqkL0vbhS1OaLHeFQqw40ioYh4f3Hg3sUxLI/RtEIC/gVgFuj
         2xEfQqyIt7nRunuagJ3QLKjDpimG1OOnXay4cdkB1rhXq9Pdudtp7VQ1i9Tfx0/+Nb
         pKhDGGIJgW/x5VoPp03+pj7Gq1FIcuJiDLcPr8xrRBr07vzAEUz2v9AqaYYMf8ANuT
         DkjfyIcuEQXQLtghqe0yO2XMRVftel7vgcaa2XBJ8esIRHOFxVX2bBSOTKX/bSw+qM
         oiWI1DmYpI9bYIiay8/65hIfNIjDnjrfHbT2QaENSaDoKQAUYRLGONalG78sGiMsNM
         SD23/20MbsRoQ==
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kbuild-all@lists.01.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: stm32: fix excluded_middle.cocci warnings
Date:   Fri, 20 Aug 2021 15:39:09 +0100
Message-Id: <162947034008.30978.4693258068045674131.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210713191004.GA14729@5eb5c2cbef84>
References: <202107140345.xyOobAtH-lkp@intel.com> <20210713191004.GA14729@5eb5c2cbef84>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 14 Jul 2021 03:10:04 +0800, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> drivers/spi/spi-stm32.c:915:23-25: WARNING !A || A && B is equivalent to !A || B
> 
> 
>  Condition !A || A && B is equivalent to !A || B.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix excluded_middle.cocci warnings
      commit: 7a4697b201a617907e4b440ae34df601d4755bef

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
