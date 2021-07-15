Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D173CAD64
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbhGOUA4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 16:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343525AbhGOT5j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 15:57:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC736128D;
        Thu, 15 Jul 2021 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378885;
        bh=+yWHiwRe88Vm+5OR1ESQOollo0+ARjYmZEJ+FVjocGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgFl6necZAdMnke0oB2Mu/aL+E14cO+CWRX3WwvUtEY3MD9QlMsCIGQCAPwqfBu5l
         ZnPQtFInQl7CGu2BZbrvt1WroZTOGKZbcXNptWht7HTiEUNCgCqVnZuEmpXXCjNSmE
         gYcowu7PSqPJ072OzccGA7Mcq//tRc+MBKhrE8hbnQFg9Bw7HDgkIYZRaPzwWLsBMG
         PUomF/WMtuJzQ9WkwmyVd7rEfg70tMBeZPYHdlv6tXZrCM4ufI5gYj1mK2+PyNTTwB
         tgMkvNoCKaDHoOZCwbi2isEKIHY/4vb4xPGYqjG7Zjkfpri5RzmPv37PVOE7fkXive
         staj+lR7MDrbw==
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        linux-spi@vger.kernel.org,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>
Subject: Re: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero warning
Date:   Thu, 15 Jul 2021 20:53:59 +0100
Message-Id: <162637883861.27669.17456981215797184810.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
References: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 15 Jul 2021 00:46:30 +0000, Yoshitaka Ikeda wrote:
> Fix below division by zero warning:
> - Added an if statement because buswidth can be zero, resulting in division by zero.
> - The modified code was based on another driver (atmel-quadspi).
> 
> [    0.795337] Division by zero in kernel.
>    :
> [    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
> [    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_exec_op+0x3b0/0x3f8)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Fix division by zero warning
      commit: 55cef88bbf12f3bfbe5c2379a8868a034707e755

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
