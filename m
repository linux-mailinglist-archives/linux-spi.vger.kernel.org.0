Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2930061B
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAVOwz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 09:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbhAVOuk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 Jan 2021 09:50:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5584F239D1;
        Fri, 22 Jan 2021 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611326999;
        bh=LIWbCD2uGrjrfSZ9ob2z4YekJdktPLRnNNKEEy7uPxk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NXEdvqImj9TGCWc5YRa2oX6/NVgZYfUo4lMHg12/nyA2RLnt4vIueFV9nZtIFtkGQ
         O7at/6PdjJP0KiQ5+1dNfHkcuMKKBayCK8GJhOFOGl/yif74NDQQ4D1/qZs5dxRRxT
         +tlqQnj1pVs0t1PItyFFzCX/SMJsCkPlDghTSSwBU+C8FIhH3f83ew6PQ+25YMW+TM
         SSr0ZXMsWYHf92a38sUH8HQk+xWWC5WpFTybVJCSRS6suB3wWWbsUX+/QgVhLG1bn1
         y2HspCgh9O7eQPaAQ9+4oJSw+xas2zSYnoKufJUs1d+HL04XTOZs27B8j5liZiRxLe
         tSHBXxPFqZiCQ==
From:   Mark Brown <broonie@kernel.org>
To:     corentin <corentin.noel56@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210122082040.30788-1-corentin.noel.external@stormshield.eu>
References: <20210122082040.30788-1-corentin.noel.external@stormshield.eu>
Subject: Re: [PATCH] drivers: spi: spi-au1550: Fix various whitespace warnings
Message-Id: <161132696017.45468.3045415103092275760.b4-ty@kernel.org>
Date:   Fri, 22 Jan 2021 14:49:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 Jan 2021 09:20:40 +0100, corentin wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: spi-au1550: Fix various whitespace warnings
      commit: 21f68c8259a8100ddee985c1536f32a19ed521df

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
