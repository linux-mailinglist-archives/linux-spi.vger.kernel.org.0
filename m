Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA53E37A1CF
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhEKI2X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhEKI2P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D85061432;
        Tue, 11 May 2021 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721628;
        bh=Av6ODrArdaRyklq5h81aFEAyRwi1Zqxxq8VsieTEPwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnqD5y5awUoCzDztVqE7CeesfCzLk6Gz3oinRh2ZmUDKeQraocy8gnv0LYOqtwFpP
         6xn1jv62HDunW9Bg4kVolb6XSnxxifD+R4heNr0YmkQvpmwXX1WnRjfXz2ma5iBa0h
         kKESGJBZyMTFU1z4H9+ym1I/P0RKYP/hIPS42qVwyLko2lU7y2nMG1FaAnIB6Y/OIb
         ZqVBgkJQEQl1CjQAwfddwNoxcVfyGRdM1VmVv1a/kTI6IZlr4eXRn5NczC0CSi2OUh
         rFmzXuYcrJzydmqXJji1WZvQG1yZkInhlc/Lk1ENo9t7M/HoUoIVrv/lY3rIQSh3RM
         sCSB8jdpKozpA==
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: take the SPI IO-mutex in the spi_set_cs_timing method
Date:   Tue, 11 May 2021 09:25:38 +0100
Message-Id: <162072071982.33404.18025194443786909424.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210508060214.1485-1-leilk.liu@mediatek.com>
References: <20210508060214.1485-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 8 May 2021 14:02:14 +0800, Leilk Liu wrote:
> this patch takes the io_mutex to prevent an unprotected HW
> register modification in the set_cs_timing callback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: take the SPI IO-mutex in the spi_set_cs_timing method
      commit: dc5fa590273890a8541ce6e999d606bfb2d73797

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
