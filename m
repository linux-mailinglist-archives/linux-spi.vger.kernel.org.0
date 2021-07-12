Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66123C5AE9
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGLKtg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhGLKtf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2F260FF4;
        Mon, 12 Jul 2021 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086807;
        bh=4hxoHQk9VGPSDfRrvIYdu/uB+u362R250JFmE8dm8P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaYdxr8dt+3xBpmPfDNesLY+2M1ZHuT4e4RnC8hCJexQ35PQyjr/1s/YnTn3we8tR
         DYSjMg8gzokzNePjUFD07xdamKf+ytZl9kRLmYLjFJT2Xv9o5GLhu/2bjYjcvw/LJC
         Ik9ooyVCJZsZOhOLay9MZ2bL/0iP/3OtHCqYwFZQRDHXwOtdwwIGkJeIKEkkGMGJ9H
         Jj13kJxRxdA1zVHUW06VVKKDnE8Qtpl3MvjpTLa5Q1fgtQFNPAguqeVRcCBsDDnIYa
         YWapDZRNdldytL6oqYTkwo+K6GdSTSgwP/JdLsWxyoncEAO2biswr+RbBrZf+BgHZL
         Lb7z/3RyLFGCg==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        "William A . Kennington III" <wak@google.com>,
        linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry
Date:   Mon, 12 Jul 2021 11:45:38 +0100
Message-Id: <162608669455.4543.4279353560890809082.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210628210520.5712-1-rdunlap@infradead.org>
References: <20210628210520.5712-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Jun 2021 14:05:20 -0700, Randy Dunlap wrote:
> Fix kernel-doc warning in spi.h by adding the missing kernel-doc entry
> and also correct the original comment so that they both indicate the
> correct polarity of the flag.
> 
> ../include/linux/spi/spi.h:673: warning: Function parameter or member 'devm_allocated' not described in 'spi_controller'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry
      commit: 8dd591ad0104593f315b6b2ab636a18c002f7d86

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
