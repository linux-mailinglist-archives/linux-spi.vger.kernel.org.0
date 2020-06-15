Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3891FA4A1
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 01:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFOXln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 19:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgFOXln (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A79A207D3;
        Mon, 15 Jun 2020 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264502;
        bh=yLKprjvYdeM2ZZTs7QutXPbGketTYe8lmu80ENlF0jY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2a2G1SOVrPxDawm1pzTc1nYf1WLvIYwZ0Fv1oax7R/33p0WJZH8ZOrsHQevlBLf44
         5Dhk8UhA5WHoL+BdSPh/9F90ec2Z2qBQb4h1HcCJVOlyi+m/I53juMMlpZR74T25x+
         9xIu73DUK127oJJhxctVCxOGbpu2NhSw/c25tncM=
Date:   Tue, 16 Jun 2020 00:41:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Cc:     russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        hao.wu@intel.com, trix@redhat.com
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Subject: Re: [PATCH 0/6] Add more configuration and regmap support for spi-altera
Message-Id: <159226448570.27735.16680770943081080712.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Jun 2020 11:25:05 +0800, Xu Yilun wrote:
> This patchset adds platform_data for spi-altera, to enable more IP
> configurations, and creating specific spi client devices. It also adds
> regmap support, to enable the indirect access to this IP.
> 
> We have a PCIE based FPGA platform which integrates this IP to communicate
> with a BMC chip (Intel MAX10) over SPI. The IP is configured as 32bit data
> width. There is also an indirect access interface in FPGA for host to
> access the registers of this IP. This patchset enables this use case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: altera: add 32bit data width transfer support.
      commit: 3011d314751535782508a86bbd8de415ea99909f
[2/3] spi: altera: add SPI core parameters support via platform data.
      commit: 8e04187c1bc7953f6dfad3400c58b1b0b0ad767b
[3/3] spi: altera: add platform data for slave information.
      commit: 1fccd182a4694a848f2d6f3b1820d6fc71d9c99d

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
