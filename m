Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E069A2FF4E4
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAUTnR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 14:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbhAUTmo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Jan 2021 14:42:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F254423A00;
        Thu, 21 Jan 2021 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258121;
        bh=I6c2xwFnsHq7GSqhf8pk3pLRL+0KSezCNtPWsHEboYg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rjoxXBMY0pqQXYoty8NKLZDdAHUg05gnIfOpmTtdrughYvtzRQcHtTnVlPFjaXYL/
         NJw/KtHMkSRdgcxZTgldcrS/DECVPPNBmlGW6GDbJ0jqVARJjmp6C/45DIBY8MIV24
         FfLRmoj99LdMEOUk96NMMUcBUDh1/pVVQyGoF3XgsxGed4aZogBarG8JcLx1s3ZFUB
         dLITNx0/sW5ybqiMGupyRbYduRA/1NYrS0LNKrJQp66pRA+I8s6LNC/SozlP3V7ltR
         /KGHSGpDDfP4NU2/+KyA7B2At9CQNIFENebIAp6zeWk3K6DZw9vFVTDlsZb+SHBxgO
         2f8ePYbhR3NNg==
From:   Mark Brown <broonie@kernel.org>
To:     corentin <corentin.noel56@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121145236.26460-1-corentin.noel.external@stormshield.eu>
References: <20210121145236.26460-1-corentin.noel.external@stormshield.eu>
Subject: Re: [PATCH] drivers: spi: spi-au1550: Add suffix "int" to all "unsigned"
Message-Id: <161125807797.36053.5140573069391915245.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:41:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 21 Jan 2021 15:52:36 +0100, corentin wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: spi-au1550: Add suffix "int" to all "unsigned"
      commit: a783de290fc599606504b180c8f44f34cd201808

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
