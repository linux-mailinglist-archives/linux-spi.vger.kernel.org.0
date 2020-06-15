Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBE1FA49C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFOXl2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 19:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXl2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5F5208E4;
        Mon, 15 Jun 2020 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264487;
        bh=fg+QK74w7DovwX+kaioGzFK7Y14YlPIKeG07Nz40WuQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EduD8uu/VZNaReB5hEYoCb5RlzG9hh/MsJNenffiwAA1mSuanUEBX7lgewmcFaWku
         iZq7UsZYtghm3YVXeQTxeiDFpaw3y8+GXmBow5GYZD0w5V31caF6o5SNtT0VDHEzDr
         HUy4QB+D2ERdOPvQ1eTMSPZ1dv1Imk2mqbWQdw2E=
Date:   Tue, 16 Jun 2020 00:41:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-spi@vger.kernel.org
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
In-Reply-To: <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com> <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
Message-Id: <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 13 Jun 2020 22:18:34 +0300, Sergei Shtylyov wrote:
> Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
> using the "back end" APIs in the main driver to talk to the real hardware.
> We only implement the 'spi-mem' interface -- there's no need to implement
> the usual SPI driver methods...
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: add Renesas RPC-IF driver
      commit: eb8d6d464a27850498dced21a8450e85d4a02009

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
