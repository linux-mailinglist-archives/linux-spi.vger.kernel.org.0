Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB780358A33
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhDHQzS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 12:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhDHQzS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 751F1610A7;
        Thu,  8 Apr 2021 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900907;
        bh=BDnS0zoL1MKzB1AmIKE6eT+2qFXEdGy0LZAK3L4KyOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YstisIIhCDaGa14D6GDLDmUDFuCsiNkgFjpRqcfnsPhWJhvqh9sRbdQxCTa2kUjmZ
         NbA2YqSAk3s7aqkimV5D/IQPVM+eJjssjghF8d/x4L+wLlCpjIFK2RonEuLUgobIUe
         nxGv+leF0KV6lZ8Dh/y0O1c0qBxZQ9oRsRghFvbKsjWj4e2ycVNJHpFBZ6Ud2oRqej
         zu7yjD4RUTdxBBwkwLywjBTnlsC7BXzqZOUVDLb6ZxswLL0SXtn0Y78S8uizaYcjEt
         jiQ9K00WYB7aoq6M0kbyJSk//CbGrImpZsaLrWnGvrUoiihKs468iwNoaA27z/VcYt
         Y5MOy/X3Qfkfw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] spi: fsl: add missing iounmap() on error in of_fsl_spi_probe()
Date:   Thu,  8 Apr 2021 17:54:32 +0100
Message-Id: <161790025316.17096.17464814359793647048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401140350.1677925-1-yangyingliang@huawei.com>
References: <20210401140350.1677925-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Apr 2021 22:03:50 +0800, Yang Yingliang wrote:
> Add the missing iounmap() before return from of_fsl_spi_probe()
> in the error handling case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl: add missing iounmap() on error in of_fsl_spi_probe()
      commit: 5fed9fe5b41aea58e5b32be506dc50c9ab9a0e4d

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
