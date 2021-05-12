Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727BB37D174
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhELR4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 13:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232303AbhELRGj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 May 2021 13:06:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EFE361376;
        Wed, 12 May 2021 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839130;
        bh=mKbciF1oaTiE7EO3ynmwEg+52gdbwWhxk/wAmHieKJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shgyKFUeEKlCckdhQFe4VyMRXLV0GIkwhb0YYlYlwP4JgrKH/3rpL8YkAuRwiwyKJ
         aIkOuSa66g491QtKiSNmGHTXFufzu4lQqZS93ykWC15loN8wjrO1IN5P5ODE62gYoW
         KIA3q5vwdRFegYGXwBPsR4vtl25xb5khUalnGMUWjmM7z1jQHRO2TOgJN52OEEl1kK
         H2DsMH27HH6mn4L9YBIvYL++9g+YB2219wSDZXvE4qBwnsUwi6NyBSnwQnTdhu1k3B
         Fm86le+eRaCaNbpU0FtHt9FqBy2ifrKS+rMrfQcwlga1DiWL0PVG31rtU2d1JWIPtT
         vGVKglHcvGxIQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2 1/1] spi: Assume GPIO CS active high in ACPI case
Date:   Wed, 12 May 2021 18:04:38 +0100
Message-Id: <162083907220.45027.2264909866666593515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
References: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 11 May 2021 17:09:12 +0300, Andy Shevchenko wrote:
> Currently GPIO CS handling, when descriptors are in use, doesn't
> take into consideration that in ACPI case the default polarity
> is Active High and can't be altered. Instead we have to use the
> per-chip definition provided by SPISerialBus() resource.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Assume GPIO CS active high in ACPI case
      commit: 6b69546912a57ff8c31061f98e56383cc0beffd3

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
