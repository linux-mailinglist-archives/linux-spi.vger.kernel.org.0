Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD834984D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCYRiH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Mar 2021 13:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhCYRhg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E21661A33;
        Thu, 25 Mar 2021 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693855;
        bh=ESt2AXDOBcY/b0nA4MDdRj5zGAt7XthzQz/J+iuoDNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sp6KFqqnsk39cdqOkX8FH5BRP7cR/vAFap5PmY0BUFkDgK3L4IylCizThCHF2123A
         Ap+YzS2ctWXMSPmlqlaCQaDSLv9xoV5vCo6ybEtCmMSIRGLd9iZUxoPRjPbBMeqTvk
         VTGYW9wwoAb1BXeJlzPHywQC9a2b1nBjuDF5ZRdiaXEFJzWGMxRloxs/Sp/9L2pSQc
         S5+kua538nZUylwUDK+AJPW3ro/DOuSTIntTiDZ/pw4tz5EyPqOwSx6CVtlYmy2LM4
         Jhl6tgoBgVe/CRlkn1jXUS7QrC+oOKDfOk93zMGC1kNBKOm10ixVAfrHo1xqLCYw+C
         aKcVv3FOWJ+dg==
From:   Mark Brown <broonie@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Use of_device_get_match_data() helper
Date:   Thu, 25 Mar 2021 17:37:06 +0000
Message-Id: <161669370550.41585.15435158368623711168.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616385476-53327-1-git-send-email-tiantao6@hisilicon.com>
References: <1616385476-53327-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Mar 2021 11:57:56 +0800, Tian Tao wrote:
> Use the of_device_get_match_data() helper instead of open coding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: imx: Use of_device_get_match_data() helper
      commit: 200d925e236f1a839bd52680f13649b23f727d51

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
