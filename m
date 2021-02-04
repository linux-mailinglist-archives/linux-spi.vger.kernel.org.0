Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F930FDCD
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 21:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbhBDUIz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 15:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239460AbhBDT4V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Feb 2021 14:56:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E420664F51;
        Thu,  4 Feb 2021 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612468541;
        bh=84RunZ+FZhsa1aFdLio4NhY41KkyxYhaOyOlC8P8BCA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MUqZf8Mxt2wiZaSWN0pd5JqqMtkopV5NOCzKhq90EGqfvCe++ShbLK4uKt0IgBHxH
         o6wTcIuo0attrMPYgUl4HvaLAECSP6rorupZKtCVhDQIIqVsFhcYyeno+m8djDkum7
         1cd3kKCo0vM6bfX3c9ML4wkOuxyXe2tsui7qxzuOFVFRK5gJrWMzrCt/ndG9a1C3ne
         E9nS6ypzfAOq3RVWJuUelbIobjueYRtIJlgqokdrNMvcG9mz7OJ+7CEbt5hEZGiPn+
         GR9CpP0edhc+vrT9caxewpxa6BdsctgDDfeskR4HAHSicPCAAu4v3/dFe3oyncJg1s
         wpbo+M2IVoblg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Yicong Yang <yangyicong@hisilicon.com>,
        shc_work@mail.ru
Cc:     linuxarm@openeuler.org, prime.zeng@huawei.com
In-Reply-To: <1612436886-42839-1-git-send-email-yangyicong@hisilicon.com>
References: <1612436886-42839-1-git-send-email-yangyicong@hisilicon.com>
Subject: Re: [PATCH] spi: clps711xx: remove redundant white-space
Message-Id: <161246849215.26351.15164691423433423153.b4-ty@kernel.org>
Date:   Thu, 04 Feb 2021 19:54:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 4 Feb 2021 19:08:06 +0800, Yicong Yang wrote:
> Remove redundant white-space, no functional change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: clps711xx: remove redundant white-space
      commit: 390624119dee8933fef4ab0e22827c20b49a0927

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
