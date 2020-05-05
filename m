Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D941C582F
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgEEOIN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 10:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEEOIM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 10:08:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF24720661;
        Tue,  5 May 2020 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588687692;
        bh=AoQ+QNUrZA3/rI32aJOVMR7iN0dP/ZQu8S525JZhojY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JVs7rDb7Ym1UFR/lmjF3UOYYYS5kxRbKXWnS3oWc2rmx/ciRUZgWZpCw1+6nxY+xu
         CJLEhMTcWIM+YFc0L3HHkyNPJY/QuNozRUBhPjpZupiTJFFPCkNE0PuV4Hc0Y1iujN
         gS5XZnUeiDji0bOKsHo93/mFve2uTPC8pxKixoA0=
Date:   Tue, 05 May 2020 15:08:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v5 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-Id: <158868768979.34203.2406918782261039757.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 5 May 2020 21:06:11 +0800, Wan Ahmad Zainie wrote:
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
