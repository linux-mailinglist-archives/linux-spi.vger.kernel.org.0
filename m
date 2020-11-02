Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBF2A314B
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 18:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgKBRTN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 12:19:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgKBRTN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:19:13 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE62222EC;
        Mon,  2 Nov 2020 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604337552;
        bh=9vVh0lTE5lrIqf0Vlrah6c3QQDXVQYB/8zbDtf8TtRY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=18hv3bGgd3rNYYJqbok26eU9xGlwxgqe04q0gtS999B0y8ikyKPPYOxGvA+BT8iED
         EqdaOwVWyMqnnUt12vvd7QFevwI8H6yEbEbzpYhdphLq8AonDQo0RpV95FbPOvPyzi
         3itkOmzb+juodjpVnuIgrnzZrOf0lyZPRZctxun0=
Date:   Mon, 02 Nov 2020 17:19:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, frieder.schrempf@exceet.de,
        bbrezillon@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201031033042.42892-1-yuehaibing@huawei.com>
References: <20201031033042.42892-1-yuehaibing@huawei.com>
Subject: Re: [PATCH] spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
Message-Id: <160433754396.19045.17758426366195897910.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 31 Oct 2020 11:30:42 +0800, YueHaibing wrote:
> Fix smatch warning:
> 
> drivers/spi/spi-mem.c:746 spi_mem_probe() warn: passing zero to 'PTR_ERR'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
      commit: a9c52d42814a44472fe1205775320ec20f556908

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
