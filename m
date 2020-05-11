Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5B1CE191
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgEKRVz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 13:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730966AbgEKRVy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 13:21:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB3F20746;
        Mon, 11 May 2020 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589217714;
        bh=hbim+lK4kK4svUzZv9ph3jJIF+6ksgUNjk/EOsFRWqo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=tDNYww2k6hQ4sYbnEEt/tR5lkW++TYhDRiTFmKPKb5MPvdhzdk/yfl7iHJlGyYgGB
         AcpkbcqGB+aCE6il8WLv5xRKCJfbIzviLk/KjDiukRD+kaNl/nA9snN4hqUFDarks/
         JtfkPYd5hGuoGgkryUFt0KjHDjO4eHCtBqVF+yEY=
Date:   Mon, 11 May 2020 18:21:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Cc:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200511045330.690507-1-alistair@alistair23.me>
References: <20200511045330.690507-1-alistair@alistair23.me>
Subject: Re: [PATCH v2] spi: sun6i: Add support for GPIO chip select lines
Message-Id: <158921769452.22432.2126080919845661372.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 10 May 2020 21:53:30 -0700, Alistair Francis wrote:
> Set use_gpio_descriptors as true to support using generic GPIO
> lines for the chip select.

Applied to

   local tree spi/for-5.7

Thanks!

[1/1] spi: sun6i: Add support for GPIO chip select lines
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
