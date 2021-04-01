Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAED351322
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhDAKQr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 06:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233978AbhDAKQn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 06:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5C8260FDB;
        Thu,  1 Apr 2021 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272203;
        bh=/4JZCYKJ34Ny/VV6useJAcsGbW6iKdWswaBA799Cid8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umkEuqdcVMsL1xl3v7RxGfsWELRqFtLqv0J+9n4Al2hNvyIHX9czktZeVA38tu/hC
         aH8xI/2mGVyKgnZ5Dd+ert4ZQKNCnKZ8rOUNn1LkhQetXatcUtnPj7krqzUEIGM+yi
         79dNk4Z/GDX5xfZkLJ4HFVskO5q+XLtWdPuuOV/iY00ddFjBEuBukPFvVVVXvn4exM
         mvOovjYsR+c7perUJ9gM4/H93iMMAFuMUzfOJqidoojTRFOxBaFKXJ6qdHqimiv0Wl
         a6i5xf5qg7bwd1Ut8VK//YHAQ49SRIRBwjPtH3qjs5NVk07zEocoD1OYF3w4EvM3JD
         bAuE1G2eBffaA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: pl022: Drop custom per-chip cs_control
Date:   Thu,  1 Apr 2021 11:16:14 +0100
Message-Id: <161726952255.2486.14037510874353854208.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330164907.2346010-1-linus.walleij@linaro.org>
References: <20210330164907.2346010-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 30 Mar 2021 18:49:05 +0200, Linus Walleij wrote:
> Drop the custom cs_control() assigned through platform data,
> we have no in-tree users and the only out-of-tree use I have
> ever seen of this facility is to pull GPIO lines, which is
> something the driver can already do for us.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: pl022: Drop custom per-chip cs_control
      commit: 4179e576b56d82e5ce007b9f548efb90605e2713
[2/3] spi: pl022: Use GPIOs looked up by the core
      commit: 77f983a9df421fa00ca6a2f494dc79f8afca75a2
[3/3] spi: pl022: Convert to use GPIO descriptors
      commit: 8bb2dbf1e14d05e92a23e03bcbd1c27f7ee937f7

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
