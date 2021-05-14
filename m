Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE3380CCA
	for <lists+linux-spi@lfdr.de>; Fri, 14 May 2021 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhENPYX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 May 2021 11:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhENPYX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 May 2021 11:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C630961457;
        Fri, 14 May 2021 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621005791;
        bh=jg0+0ZLWWSudQssdbb0jV0S2Tb99NVlM/AuDj9Uho+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foyzTg2bxFrTucVnVr/E+BLc9jNRKz1zKOuAqIhosngU17jxzKoTP8rrV+EmP9J1b
         cVPbU9/Fl2b7ACcMGRmYh5fRJBJ67+MYRnPeJK91gRgYUev+YsJ4oonQ7J39q8u5z9
         MlGFYuIrzjZGIE3i+ojpNwwFXLJCtkURgJzNtGe1iR0aV4tovPOO70iCodRwg6ects
         cNR0ghqBsUJtGW6WQOqIqFjdeaoM5V30tZG9QPTtgw3r1bsztqyZ0oBZh9Ypnp5qUM
         qU0MOu0Bq9dHFuBbjSpENjmav4ZlIRr1omyuU7wLCN9viAfgsJmjnt6zkhDDkpGueL
         lHWeotCgz6+NQ==
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] spi: Don't have controller clean up spi device before driver unbind
Date:   Fri, 14 May 2021 16:22:27 +0100
Message-Id: <162100572549.50710.4882090204526461984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505164734.175546-1-saravanak@google.com>
References: <20210505164734.175546-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 5 May 2021 09:47:34 -0700, Saravana Kannan wrote:
> When a spi device is unregistered and triggers a driver unbind, the
> driver might need to access the spi device. So, don't have the
> controller clean up the spi device before the driver is unbound. Clean
> up the spi device after the driver is unbound.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Don't have controller clean up spi device before driver unbind
      commit: 27e7db56cf3dffd302bd7ddfacb1d405cf671a2a

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
