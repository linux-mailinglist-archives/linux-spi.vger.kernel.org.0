Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4542DA22
	for <lists+linux-spi@lfdr.de>; Thu, 14 Oct 2021 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJNNUY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 09:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhJNNUY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Oct 2021 09:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B32A6610E7;
        Thu, 14 Oct 2021 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634217499;
        bh=LX3p1DlNBdxCIxbLiRRUIKV8LSSbL/18b+S5/91kSrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnhXWgHqMwpxsJzpIgtwI6AoG5muM9k1z/984fQyqDl36lw9hym9A/ljdMvQm66yJ
         785/p0XDsVjau/DUNUbTd7DXtHyiRnZQnuJ0YOwlcKNTPVxXycvcZ+QIrLcs1J4Xc0
         Lsqc3X3eQIpu3BGQMAeZSA8VPIdfiaJhQPUgenggcnmrv9+M5tUYpQddNA5r6BfFNe
         SX/6LDq22TLk3WaT7W6LBm4YpU1YENtguGDgNnHGMsTDkj/+m4qTzM+b9s/EuHbEZU
         Bn0yZx/HjiZ75+1yvEqN/d0dnWVKMvN6QhLwcQmBEDey36YKHWQruZJGjAs7LVp+Ri
         7MUSbPFaWztdw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI buses
Date:   Thu, 14 Oct 2021 14:18:14 +0100
Message-Id: <163421748241.2468431.4816167288130747203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013122628.1369702-1-broonie@kernel.org>
References: <20211013122628.1369702-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Oct 2021 13:26:28 +0100, Mark Brown wrote:
> Currently we have a global spi_add_lock which we take when adding new
> devices so that we can check that we're not trying to reuse a chip
> select that's already controlled.  This means that if the SPI device is
> itself a SPI controller and triggers the instantiation of further SPI
> devices we trigger a deadlock as we try to register and instantiate
> those devices while in the process of doing so for the parent controller
> and hence already holding the global spi_add_lock.  Since we only care
> about concurrency within a single SPI bus move the lock to be per
> controller, avoiding the deadlock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix deadlock when adding SPI controllers on SPI buses
      commit: 6098475d4cb48d821bdf453c61118c56e26294f0

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
