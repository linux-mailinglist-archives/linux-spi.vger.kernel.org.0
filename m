Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A82A361225
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhDOSee (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 14:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDOSed (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 14:34:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17BBE6109D;
        Thu, 15 Apr 2021 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618511650;
        bh=yBFKsYKO3TzTjeJ9hWntraQ2oZflKuioCiCuvrZs+As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXTKwCXrVrm66+XMMN9eDJ65TvlfzS3pUd+W35w7VciHDIcFuyrYB4hPAy2hy+Oa2
         vTa7h8nByojJyyi25XA/q5GlwzsSf4Y30y0kjmI8HRFGtOB8NTPWCxUNvk049IzFXk
         DdDPxtneGPbhXpBBqzHVjX5Xcb1dUIu3UVARhn1AGOxQ7H0AsoyYq6qNj/WomQmmYV
         z5zPemp/uJ7ufXJUioWLEiDbZr+nbbpTBwx3AFXvMiuYQuEUhJ48O1jpm6zFQ28989
         onZSxRJScYosQKJxYebvbPK6EGvJGrp5vgvh5/EetuNqSmTvCqYdBSxvlvRKvs/rCT
         hMS0nM3aIKD0w==
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-M
Date:   Thu, 15 Apr 2021 19:33:40 +0100
Message-Id: <161851161879.23304.15572714678764060462.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415135917.54144-1-jarkko.nikula@linux.intel.com>
References: <20210415135917.54144-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 15 Apr 2021 16:59:17 +0300, Jarkko Nikula wrote:
> Add support for LPSS SPI on Intel Alder Lake PCH-M.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Alder Lake PCH-M
      commit: 8c4ffe4d023d7a3153c1d3d1084d98d17bf684b9

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
