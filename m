Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A811252F0E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgHZM4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 08:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgHZM4m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 08:56:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87162208E4;
        Wed, 26 Aug 2020 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598446602;
        bh=G+Aj1sDE0Iw3fhQGvhf1No/u/WSSFdZxXOH5VsoLXXk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=I+2lNRaBaHiMUxdByk+1UKBnPqSK2z0eLTz+Oo+s/JAyMgNluClLiYF0G1kHx/xy8
         inMKPdYOu5NQoPkhM8rSvcrsU7gJ/ZaODaX5EHo1GRThuOv4gQcnaRbwhwczLPi2eh
         RJFgQdknSdTAEgBwjdB13/4Gn+FQTADWPk2/CWnM=
Date:   Wed, 26 Aug 2020 13:56:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200825201743.4926-1-cezary.rojewski@intel.com>
References: <20200825201743.4926-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH v2] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
Message-Id: <159844656584.37339.9591149357617880501.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Aug 2020 22:17:43 +0200, Cezary Rojewski wrote:
> Update list of SSP registers with SSC2 and SSPSP2. These registers are
> utilized by LPT/WPT AudioDSP architecture.
> 
> While SSC2 shares the same offset (0x40) as SSACDD, description of this
> register for SSP device present on mentioned AudioDSP is different so
> define separate constant to avoid any ambiguity.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
      commit: a2bee00cccf4f2a80412d38328b92f448fd66935

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
