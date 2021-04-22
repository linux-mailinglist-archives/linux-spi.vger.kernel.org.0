Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C936D36852C
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhDVQuD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 12:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237431AbhDVQt6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 12:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F8D4613DC;
        Thu, 22 Apr 2021 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110163;
        bh=SjrDwa5HJKSmqApWHKXOGHB5NmIYxys0EV24y2IGHu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT0atzPmpRW6GtOZuadbObQ6Ukku/pp90uYtiqqA69dmZiWIzIV6whzZ08rdFLCdP
         sFi4ph2boeAncsngQE8DR5RfPazbARCiFDzUD2kwNg/G5KIbnX0GpQ9VRJTuqX2L6F
         lpSmepneXBhh3Mc5pml7AYayg1HB3sPe2B9nJqqxzUkxCimqyJqzKEAPIboWnIXffh
         aLvEFgNiqlBRJiNL1SHdINKxsz6yNm+mu235ddjOX1XWxwoKw5eppaekNhTHCs4w8M
         iDDF6w8VcXsq1FepXQ+3RF7bfBWtDYjP2N6AAd/nOh46TVaiY4KoIAnpNiP1DJOJuN
         rM637+dmyi21g==
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: stm32-qspi: fix debug format string
Date:   Thu, 22 Apr 2021 17:48:46 +0100
Message-Id: <161911005747.37738.11400279333623304352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421140653.3964725-1-arnd@kernel.org>
References: <20210421140653.3964725-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Apr 2021 16:06:48 +0200, Arnd Bergmann wrote:
> Printing size_t needs a special %zd format modifier to avoid a
> warning like:
> 
> drivers/spi/spi-stm32-qspi.c:481:41: note: format string is defined here
>   481 |         dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: fix debug format string
      commit: 14ef64ebdc2a4564893022780907747567452f6c

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
