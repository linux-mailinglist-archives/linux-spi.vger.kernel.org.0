Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2942FC73
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbhJOTuD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 15:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242743AbhJOTuC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:50:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A404361184;
        Fri, 15 Oct 2021 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327276;
        bh=1DkIIA37n2B/Tk1XN4XdNC51aHjXJ1WoMmgOxXTJvvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr0QnE8yPnniSj1Th1WlRjwzCRzc3ykf3CxWuC0Psl424XoQRTMfBzI1BIQ8CavGr
         hT2AVGWsCnAN5kr2OZDwikyN6U17JDUXP3OCwxWPUujSl17YumLODNN4SKlsWjHCHF
         OlS9k/OnuvA01pqIlpJJOytyWQHnHBh0yX3dLoNwKLsytzDys5q6KG84RK/rBxAq8j
         g35/MudzlvD270I8v7l9TU56PkW5WFJMqc4vYG7GK4IZQt+NK26Pg0Jr0ZEnVIsk8g
         UmyeT98U1TRrjxWkLTzNqwNy3GghaEuQcxqmZFi4G/3/5JHR2c7/qevyiaf8kRtd3U
         jgDY6v6+Po9NQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Qing Wang <wangqing@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 20:47:49 +0100
Message-Id: <163432719233.1317044.7864652112120734633.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1634280668-4954-1-git-send-email-wangqing@vivo.com>
References: <1634280668-4954-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Oct 2021 23:51:08 -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the following coccicheck warning:
> drivers/spi/spi-tle62x0.c:144: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: replace snprintf in show functions with sysfs_emit
      commit: 08411e3461bde231bdcdf8298dcb1af9604beff5

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
