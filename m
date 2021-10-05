Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCE422CA4
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJEPjj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 11:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhJEPjj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Oct 2021 11:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E62D360F9D;
        Tue,  5 Oct 2021 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633448268;
        bh=VNMwv22FvVJr37/utthyswV8Kmqu6h+cvM+d5Cilb8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZ/ikPyX6aEgzTkFrv0zdwmzrCGDU2gTAp4/NE+9fgLBoe7iS7J0PyPd1emkBNnXj
         /xjwTh7aqHb0MUomUuoZLFlwj72MbShSMQshd2mifsHbGYDx+rBqVWO6w0lVw9p4bK
         Edo72759r38JyFMSsNWTlFfzwEDefkhX+bYkMJoDvaqj02gVKZ7aOtcY57jbETe8wO
         LL1KeeN0xX5ZR765cF3nEDo+5nRvC9p2BGrHSRcMcVlo8b4b8E9E8xJ1DWZeRaXimp
         /vq3Z2zTQP/ZO8ALlbTAvmkQt5e7LXL4V49ivYC8V2zSSOofXfv7SEUpBh37bIDmtV
         wstVlx7XH4NRA==
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsi: Print status on error
Date:   Tue,  5 Oct 2021 16:37:39 +0100
Message-Id: <163344813900.1141585.10210629516525058717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004195149.29759-1-eajames@linux.ibm.com>
References: <20211004195149.29759-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Oct 2021 14:51:49 -0500, Eddie James wrote:
> Print the SPI engine status register when an error is detected. This
> will aid tremendously in debugging failed transactions.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Print status on error
      commit: 48a78c66ad5d9d4f918182335d6e5726e7008085

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
