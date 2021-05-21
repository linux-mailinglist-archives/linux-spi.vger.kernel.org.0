Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE138C9C4
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhEUPJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 11:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232206AbhEUPJb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 11:09:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AA0D613CC;
        Fri, 21 May 2021 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621609688;
        bh=63ae20Ui0Z8uUIJTvxDkH6YhZBlZIrr97WYnPYcu/k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiCkkeJBMBXuK6pds27sl55gJoM906kz7ty8QCWB0or3y5Nk3t++jR6F/9vqrBrYQ
         rw/Nx2TInBI1YCHYFVUQqX4EqCita4LbWp9ljmZ+yvQQVgv8voPHNos9x3Sp1/en6v
         vIBgI3Xj+DWLu0INZo+DEoIKf2hLSF8bdQfQT3KTCfEQvED3P/UKdb5lq198KyBQI9
         wY7PzLNvRPkDZD/55k63jzjw5l0IzovBaLv490bl97IzJeVAkM4gw60drll0bNZcgX
         xZDs5RiTOerb8VqJeeLeUmgVk7jTJ/ZR89heUN6BT01gE6PLkSUqszDAiGnrnrjEo2
         UDN6Gny121q3Q==
From:   Mark Brown <broonie@kernel.org>
To:     daniel@zonque.org, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, haojian.zhuang@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, robert.jarzmik@free.fr
Subject: Re: [PATCH] spi: pxa2xx: Fix inconsistent indenting
Date:   Fri, 21 May 2021 16:08:00 +0100
Message-Id: <162160967729.10785.7445217035686493697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621590465-73594-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1621590465-73594-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 May 2021 17:47:45 +0800, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/spi/spi-pxa2xx-pci.c:260 pxa2xx_spi_pci_probe() warn:
> inconsistent indenting.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Fix inconsistent indenting
      commit: dbfac814bb73624613f47d6e70391053ab6b8960

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
