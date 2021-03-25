Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC30B349843
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 18:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCYRhf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Mar 2021 13:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCYRhR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F292A61A28;
        Thu, 25 Mar 2021 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693837;
        bh=qLec3gCb+45Rnn6+rTF/mT8gPNAycvWQxkeeRLxyZ/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koDkn7tTtgxBCVLKZ3OozAHFARA86K1TXh7lq0VTJzYqKBkrmPYDoNKW2JRXzN62j
         ip8TIa/zKPcyDVaHzedx6Ds2PTQRJsNljYFEFuoeWBslkWSi4T7D+eoqOc4AcqzWa/
         Le+N7O7snAFJTp1FKmwUvss/pxExenDZSYK/PnmiQBrpDYXJShKCjEoWQF0jmp0cNb
         huMZc/5BRRnPVNB6nXpbrkg/MPFxguUjnu8uXNDX1bf6CJmEGzn5r1s3EwUVvPEEdn
         gtlumbYhGkiCwUH+PcrkFMUbc/FH2ZftnTow+TUBmFKUiDP7HTFBZ5oGyXyj9Bk2Pu
         BcHSvssKAnBhw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>, joel@jms.id.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted chips
Date:   Thu, 25 Mar 2021 17:37:00 +0000
Message-Id: <161669381898.42255.17085051499776250683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324220516.41192-1-eajames@linux.ibm.com>
References: <20210324220516.41192-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Mar 2021 17:05:16 -0500, Eddie James wrote:
> Updated restricted chips have trouble processing multiple sequenced
> operations. So remove the capability to sequence multiple operations and
> reduce the maximum transfer size to 8 bytes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Remove multiple sequenced ops for restricted chips
      commit: 3ed4c84cc7ac59dd383f1d77f7b04148ede2548d

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
