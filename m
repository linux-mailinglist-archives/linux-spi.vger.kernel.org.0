Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E503299B0C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 00:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408429AbgJZXrm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 19:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408428AbgJZXrl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9A220720;
        Mon, 26 Oct 2020 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756061;
        bh=O9oOmhQqr/swTftdk1U4Yhto01YHEKLALSchC3G0wKs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mcb/oCxIIA/GPtmCGUCUJkiPY5UXhCRlPvRgdBMJIM4koBExABfxdZqDMDTBZrbBs
         pef5VhMPS6h66HzTCwKeU1io8XmVviCKRNxIuZnIyy9tPUwG9Fkknsieoz3kwPdx/T
         jQZizyhQK83e7+1/L1rg4ksaTE++/yxagYqa/2jc=
Date:   Mon, 26 Oct 2020 23:47:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Alexander Kochetkov <al.kochet@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201022075221.23332-1-akochetkov@lintech.ru>
References: <20201022075221.23332-1-akochetkov@lintech.ru>
Subject: Re: [PATCH v3] spi: spi-sun6i: implement DMA-based transfer mode
Message-Id: <160375605709.32342.188457165098247494.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Oct 2020 10:52:21 +0300, Alexander Kochetkov wrote:
> DMA-based transfer will be enabled if data length is larger than FIFO size
> (64 bytes for A64). This greatly reduce number of interrupts for
> transferring data.
> 
> For smaller data size PIO mode will be used. In PIO mode whole buffer will
> be loaded into FIFO.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun6i: implement DMA-based transfer mode
      commit: 345980a3a5e5e1c99fc621e2ce878fb150ad2287

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
