Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88482351ECB
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhDASrE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 14:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238593AbhDASpA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8AD361184;
        Thu,  1 Apr 2021 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617293762;
        bh=9mXHLLqBBxMNhCZn7ktuoeDjGYnyOHv6qaqbCKJFjoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9/vii/UoXb0uxDdG74x9V0lQghXcLTLlWDb35ensNRZ6BPx0t/aEl2JdYC8seB5x
         DafKxVIVQDvzGxxC3ZFM7vZv9sbGdrLNVpRWXxwS1I9CnHgD5zsaO1fHFE2qMjTUNn
         FBb1z9NduKM7PEBei6T6Vx4VVPMkzWS/98A/0vJlMkqGw8cYUjXcmzVVXnueoaAdMn
         QpsRv9r3IngTFkwSdLn2cwiGlSqimP6B2Ykw0FLFMrpbFz80yi7zZV63e6J4gYfwiI
         2dBPU+JaCUMKJGwtEAnwXCBYpl8/Sxt/8OYAhXaRHomUa2WtCuK+IET4dN5/IkF+GM
         IO9+YPYdJgRRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] linux/spi: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:15:46 +0100
Message-Id: <161729347262.31861.6906734696742982702.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401065904.994121-1-wanjiabing@vivo.com>
References: <20210401065904.994121-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Apr 2021 14:59:04 +0800, Wan Jiabing wrote:
> struct spi_transfer is declared twice. One is declared at 24th line.
> The blew one is not needed though. Remove the duplicate.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] linux/spi: Remove repeated struct declaration
      commit: d6644a1c2e17febf261fd692bb32271e5779bbd2

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
