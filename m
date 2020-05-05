Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E161C5831
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgEEOIS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 10:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEEOIS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 10:08:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A949220661;
        Tue,  5 May 2020 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588687698;
        bh=MzxowHiHuV6EfUUx/dMO8MA0TgI0ybbZ9kt0kVrDuKU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cR+kkC3s5iYfkD8m+xPznxM83ZfG97rBItS+w/oWcJkM6pu0H54v3HYpBg6vYyoiw
         h/WM3hj+yHBxgGGfEh/MYXrR46qXflWlpPkkkETcITcYizDdN7dH0SK8lvzsOpJTkd
         jWQODTB4un/k4t7WfYUlexsZ+qAtTEAv5RBjbpDM=
Date:   Tue, 05 May 2020 15:08:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v4 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-Id: <158868768979.34203.10218273503106374655.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 May 2020 21:02:39 +0800, Wan Ahmad Zainie wrote:
> This patchset adds support for DesignWare DWC_ssi. This soft IP
> is an AMBA version 2.0-compliant AHB slave device. Existing driver
> already supports the older APB version.
> 
> Intel Keem Bay SPI controller is using this IP. This patchset is
> tested on Keem Bay evaluation module board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/7] spi: dw: Fix typo in few registers name
      commit: 299cb65c9dd4791242a102f216583773d962c1ac
[2/7] spi: dw: Add update_cr0() callback to update CTRLR0
      commit: c4eadee21fa9afd3dc9dd867c71b642177bf671f
[3/7] spi: dw: Add support for DesignWare DWC_ssi
      commit: e539f435cb9c78c6984b75f16b65a2ece7867981
[4/7] spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
      commit: 3812a081d2fcc297d039c4ffafa7778d75abcbe2
[5/7] spi: dw: Add support for Intel Keem Bay SPI
      commit: f42377916ed534649341777669628f22ef1edf59
[6/7] spi: dw-apb-ssi: Add Intel Keem Bay support
      commit: c48e0c533e72ca264ac914addccab8a328806ed3
[7/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
      (not applied)

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
