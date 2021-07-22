Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1833D2AF0
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhGVQ3s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233717AbhGVQ3o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AADA61183;
        Thu, 22 Jul 2021 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973819;
        bh=6tXsqxQclTT6KIHVXllKY41+MDNoERgynR2skjDE3sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFfHL+A8EXu7CYstSQ+1IjYoikwZaKgrPiwMvO91klckkR1wPj3SEexReAnIpYE7w
         SG5j7JiQ3veVXAqajXljEB0aT27fGq2Jw2t90a0aMwEHvYYL8WO4t7nNuzrr9R5Bec
         zqKqPCeL+0sj94ieU8iXm3iqK8G7rBqtxLc20Llp/C4KAF3mlg5dg8Ubyh8BjXvQ0w
         Pg7FBVyqjfQQzi1d0xjcL4Zvg2JEXTZn3BLwk1kBMxdYn+ynNrXnuMUFWB36IOxWHh
         FMvktb/YdWSeu2FNYkuXn4z35oz+m/c6F8qPSBtTstDvgS7fWZ6GD+C2H6yrNtjxgA
         X862uJ2jIDUPQ==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] spi: meson-spicc: fix memory leak in meson_spicc_remove
Date:   Thu, 22 Jul 2021 18:09:58 +0100
Message-Id: <162697114030.3066.15287754008678432008.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720100116.1438974-1-mudongliangabcd@gmail.com>
References: <20210720100116.1438974-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Jul 2021 18:01:16 +0800, Dongliang Mu wrote:
> In meson_spicc_probe, the error handling code needs to clean up master
> by calling spi_master_put, but the remove function does not have this
> function call. This will lead to memory leak of spicc->master.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: fix memory leak in meson_spicc_remove
      commit: 8311ee2164c5cd1b63a601ea366f540eae89f10e

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
