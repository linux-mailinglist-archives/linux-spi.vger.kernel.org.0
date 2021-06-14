Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04023A6F7F
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhFNT40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 15:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233884AbhFNT4Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E94BE61166;
        Mon, 14 Jun 2021 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700461;
        bh=9H59Xz02Kl+iv21yoouobtliOku9p+EcM8ROFyfhWTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehs1koXhYhnQJhJJvR8usrB0j9ZwqwOc5uAZo9Mub/OJw/4PHL81MgxHaC259emy6
         JBxLmqjtsgBKEcHvUX7ND1/ZAxCsBqZyKWyGSR7u/3e6+G6UnZRYqe5SnmvXI54gDG
         iUWPEb8u7jCPokEeD7nnqSyOfIx5N1ouawX3GPJ7zBSu8BKARk6J55rlvFSr40tVnc
         vaLuLUnOPQPDnKF4SX3CHx3cxG8pfX/iPR2nWTA66FayfFCjNI+KFclffsJ9yx4hLD
         i3tJx44lwpIL2VKANf+tB3Cbj+bQnzpJetKFB0KilYPnBWSHB1EXwe2qIAsVqzBsMU
         Tc8nbAv62GZoQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        zpershuai <zpershuai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: meson-spicc: fix memory leak in meson_spicc_probe
Date:   Mon, 14 Jun 2021 20:53:32 +0100
Message-Id: <162370043178.40904.2317762864895103950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623562156-21995-1-git-send-email-zpershuai@gmail.com>
References: <1623562156-21995-1-git-send-email-zpershuai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 13 Jun 2021 13:29:16 +0800, zpershuai wrote:
> when meson_spicc_clk_init returns failed, it should goto the
> out_clk label.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: meson-spicc: fix memory leak in meson_spicc_probe
      commit: b2d501c13470409ee7613855b17e5e5ec4111e1c

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
