Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8062AF566
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKKPsW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 10:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgKKPsW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:48:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A3620756;
        Wed, 11 Nov 2020 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109701;
        bh=9NBbD+OcbdaFnuN/BNx8tHXhybYgFcK2wS0IumABVjA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mZYZgwnFS1u6URxxDk0XFRNSQbpc/TEyV+FSc44GZsZqFhqRUJM8h4UC6a1phYlmD
         lMlDGKnb6yl5MwWV+xL0CeDkwYmMW/tfj72cpLX2hNCNLg2/ACr8Kg6C2Z9hlXCwcd
         sqJdgJK/IV43fNkvxK6zb636BbApvz+/phE63bRM=
Date:   Wed, 11 Nov 2020 15:48:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>, linux-spi@vger.kernel.org
Cc:     joel@jms.id.au, linux-kernel@vger.kernel.org
In-Reply-To: <20201110214736.25718-1-eajames@linux.ibm.com>
References: <20201110214736.25718-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Fix transfer returning without finalizing message
Message-Id: <160510968063.12304.5298198996185481749.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Nov 2020 15:47:36 -0600, Eddie James wrote:
> In the case that the SPI mux isn't set, the transfer_one_message
> function returns without finalizing the message. This means that
> the transfer never completes, resulting in hung tasks and an
> eventual kernel panic. Fix it by finalizing the transfer in this
> case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Fix transfer returning without finalizing message
      commit: ee4ad5d06509b3aea79b6a77bebd09ef891bed8d

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
