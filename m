Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D551BA824
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0Pin (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 11:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgD0Pin (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Apr 2020 11:38:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593D820656;
        Mon, 27 Apr 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588001922;
        bh=MoIe11DQSWtChVptu/m8TuymgTP9ioN5hAFwu8OcYcg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wLDDt+GptShmRbKn29dgwTGGpPlHiDyZWHlmkcXA/DyRzOxaHrye6x8lnW8RMqF/k
         5T1EvfNrXWHjK55ISLZr6xNqyS6yzY+cAJaIGd80hpdCWiI4lnZbcADvyBwCbDjSHf
         l4sd383PU3tO4tK4zALWqYuJjyk2JQja6WL0mgeI=
Date:   Mon, 27 Apr 2020 16:38:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
References: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
Subject: Re: [PATCH v2] spi: spi-amd: Add AMD SPI controller driver support
Message-Id: <158800192031.8067.12914149173076417179.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 25 Apr 2020 14:59:48 -0500, Sanjay R Mehta wrote:
> This driver supports SPI Controller for AMD SOCs.This driver
> supports SPI operations using FIFO mode of transfer.
> 
> ChangeLog v1->v2:
> 	- Fix up to handle multiple receive transfer case.
> 	- move chip_select in transfer_message, flag device as
> 	  half-duplex and some cosmetic changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-amd: Add AMD SPI controller driver support
      commit: bbb336f39efcb1b5498f65f59f9af5773ad6dc2b

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
