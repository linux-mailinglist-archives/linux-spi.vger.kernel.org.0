Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC230060D
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbhAVOvj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 09:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbhAVOup (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 Jan 2021 09:50:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4DDB239EF;
        Fri, 22 Jan 2021 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611327005;
        bh=7A7B5OQ5Ao/GDDIKhsc6LXdXg8ZyvC1zrtW2QnGTv/U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UwNiX0LfqphibQhPpnPBQ40XupO2rWF6LNnEK7QidCQqnSvmhfOovGy24UyI/ol49
         cJ+8Eia3vSamM3XzA7fL2wd+lZiPVrKtdFb5dYvWMWjqW3MWZwNbTDAviuSPm+U1eY
         hfwCQ7t7h79oOw5e71pXiFBMhLn0I8bPKAtcVr57e5LlCqzVyUdCWvmSSw9oLAt1U+
         xZ3m1GJKdcuIZmjQi17fn8q0NoN4WYU8543/99JqZjZaqQ4+lWhgo5APUJ5Tyl98Ns
         MJWO8en21cdKgk/zfEpGArFkDFk2W9d96ERwe1/plX6KqhEhx5I/0oWipAzLl7jytM
         xEAZnXKps7UIA==
From:   Mark Brown <broonie@kernel.org>
To:     corentin <corentin.noel56@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210122113052.40429-1-corentin.noel56@gmail.com>
References: <20210122113052.40429-1-corentin.noel56@gmail.com>
Subject: Re: [PATCH] drivers: spi: spi-au1550: quoted string break
Message-Id: <161132696016.45468.11384338482499943212.b4-ty@kernel.org>
Date:   Fri, 22 Jan 2021 14:49:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 Jan 2021 12:30:52 +0100, corentin wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: spi-au1550: quoted string break
      commit: 3ae04d823d293857eec7c6d435fe748f468b85a1

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
