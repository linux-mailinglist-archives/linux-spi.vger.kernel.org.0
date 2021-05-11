Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37E537A1CE
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEKI2V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhEKI2M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 598A4613CF;
        Tue, 11 May 2021 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721626;
        bh=FWCGDKPohcmsRBmZfuYF8ar7eAo+1KHgcONgXl3Dzpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXXTUYch7oMQEyyQ8xiv+oKYj6JDrvyqWpm2stu2jS6777Sr87EMZmQDgNIr0ow8S
         7OzZAR4aeKJcDmgOuGikIQomtuQ4Gbk0IZN/a5V9HB8QsA50AVpDU3eE+vkk2nxhDx
         K30gbNzGD/wtBAgEjjA6mluCErKbe6KPEA15YRLScIWMBPr+sevML3b9QLBM1V+zSr
         2ki1I5jyFRWXRVSG+CeL9i2p5k3yQbr8AhNdx5aTW3QIQcvj04naVVjhp7MIQVkrdM
         yu6yv0hbHKArVudlH+SbnBVrVHhEckP+fIWSxCaLDpz48Gy6iEKgEcr9XFnAneR7aw
         oTscpqkDbqZew==
From:   Mark Brown <broonie@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: omap-100k: Fix the length judgment problem
Date:   Tue, 11 May 2021 09:25:37 +0100
Message-Id: <162072071981.33404.15075529331329774828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619695248-39045-1-git-send-email-tiantao6@hisilicon.com>
References: <1619695248-39045-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 29 Apr 2021 19:20:48 +0800, Tian Tao wrote:
> word_len should be checked in the omap1_spi100k_setup_transfer
> function to see if it exceeds 32.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap-100k: Fix the length judgment problem
      commit: e7a1a3abea373e41ba7dfe0fbc93cb79b6a3a529

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
