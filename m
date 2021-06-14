Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951523A6F82
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhFNT43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 15:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhFNT41 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1418F611CA;
        Mon, 14 Jun 2021 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700464;
        bh=6+jWKpDPCaLLPDz72qGZDobMO4QiVYKqrHRjzmR1Rbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSGh2x8Q8QVNVKUh3a7BPqeQd4xqQBMkCNTSaq9xHcF+QZA2r1qDpmLJThnsiJw18
         7YJut3tJ5DUxPGzAbEkBC1qsIMdC0wteARrVoDliKvhz9BsYAZB9rUw7rUZ+t24nyP
         xvwm4cE0RngTHlcJX5cuUcX0Knwy8K+ckTHVIUvnnJvBKPuyHhRu6NbMODFQ6Kf0k+
         x3Gvt/8Xb8K3t1ABHgORxlKZZhD2IWWF63/drVuVNnAaqPC6mvac8MP+XnZBmFoSPI
         f0JDSYz5T3yzcda0Bo3U69AdfZlFjDm6maQe6PaIGK3CgFk4SqGt++4YRbClcT/Uzo
         yiYhZg6Um3F5A==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: remove spi_set_cs_timing()
Date:   Mon, 14 Jun 2021 20:53:33 +0100
Message-Id: <162370043177.40904.7910320297802442191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210609071918.2852069-1-gregkh@linuxfoundation.org>
References: <20210609071918.2852069-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Jun 2021 09:19:18 +0200, Greg Kroah-Hartman wrote:
> No one seems to be using this global and exported function, so remove it
> as it is no longer needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: remove spi_set_cs_timing()
      commit: 4ccf359849ce709f4bf0214b4b5b8b6891d38770

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
