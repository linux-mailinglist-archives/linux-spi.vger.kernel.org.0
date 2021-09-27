Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4023419D4B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Sep 2021 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhI0Rsm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Sep 2021 13:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238191AbhI0RsX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C3360F6B;
        Mon, 27 Sep 2021 17:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764805;
        bh=ifPF+UcUXnzwfj8bP71GwRKwkLT1YQAGO8JasLucqUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNxvzD74ZLCXlxOjndqKfol0T1xS7wIERqWUY4dsllEENGIa2DJtXP4/Se8RsrmLt
         MTxrOMfOW47oKbrtoSpbvMylX2s2/kIA7NDvltz6qdKTPEtLWmnf4CtxouJgSalUy5
         Ze1owwWdJnCfXE7ySk2kWN38VY6jlZ04QRQHa9uCk/mbMDs6IrKmAhxGkz8IC95i4v
         JQNGcXm0VYv11SxnFCEGfQ0SA4njcC4+wG3+EY0E1qBW8CTYPUCFfqB7vhj+zTqffq
         EnDUEH0Qyg6LeV7XinCXifIeNUQYSiXxUbVdbpDUazDk65m8FXn1i0rBFhUJyjYDpz
         SLoXyDZsSAxTQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: s3c64xx: describe driver in KConfig
Date:   Mon, 27 Sep 2021 18:45:19 +0100
Message-Id: <163276467077.29936.11453903446746575185.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924133114.111777-1-krzysztof.kozlowski@canonical.com>
References: <20210924133114.111777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Sep 2021 15:31:14 +0200, Krzysztof Kozlowski wrote:
> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: describe driver in KConfig
      commit: 5b71cbf08a1e0508d1f0f63ac417ad836d801e1a

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
