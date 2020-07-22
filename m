Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D49229976
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbgGVNpQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgGVNpP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC89120717;
        Wed, 22 Jul 2020 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425515;
        bh=3R/MABaRAiiOnMqmudmTDoOS3PJRYlSkFbhNILhNoBo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mXjKWxDI22gMpTj2CDCmbvxZB36C5f9iJkAfwAweqM4V4lGQ5K+MmkQxxPctqAp8h
         ICA5mCADFFoGJo4ghofLB0r2p5LsK/7IZtYt9wA8emeBFmHZ350NRFgARjAJdpEMrp
         OOS6vB0rJBEe/hZFqaXsawkPeF3V2dXPZ3HnpBGI=
Date:   Wed, 22 Jul 2020 14:45:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        linux-spi@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Cc:     qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Subject: Re: [PATCH v2 1/8] spi: lantiq: fix: Rx overflow error in full duplex mode
Message-Id: <159542550175.19884.3888166163609861581.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Jul 2020 14:27:50 +0800, Dilip Kota wrote:
> In full duplex mode, rx overflow error is observed. To overcome the error,
> wait until the complete data got received and proceed further.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: lantiq: fix: Rx overflow error in full duplex mode
      commit: 661ccf2b3f1360be50242726f7c26ced6a9e7d52
[2/8] spi: lantiq: Add SMP support
      commit: ddf41bf782d2fb1df605407c7fff1160f488c949
[3/8] spi: lantiq: Move interrupt control register offesets to SoC specific data structure
      commit: 8d19d665e0aca28c4bd8a024241b05f74841a315
[4/8] spi: lantiq: Add support to acknowledge interrupt
      commit: 94eca904cb97f9cfa90e3e558fb73c49d2e42f91
[5/8] spi: lantiq: Add fifo size bit mask in SoC specific data structure
      commit: 8743d2155aed9236202294e293ab13d33b3a7682
[6/8] spi: lantiq: Move interrupt configuration to SoC specific data structure
      commit: 744cd0f212d72758fb094c1d13ec61b27ab6de3f
[7/8] spi: Add bindings for Lightning Mountain SoC
      commit: 956284a304dd7d100730b85d90eac3f472b7d2a0
[8/8] spi: lantiq: Add support to Lightning Mountain SoC
      commit: 040f7f9729785363eb062a36f76467c7b7c9b7c1

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
