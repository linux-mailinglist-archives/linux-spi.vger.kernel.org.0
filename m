Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93501E848C
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgE2RSn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RSn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:18:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9BD2074D;
        Fri, 29 May 2020 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772723;
        bh=4mxOlAMlrg9LOuBVaJ3Lv63Dwxs9nV/mEb4tMFkxJgw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yDnEn002K6KwchpFjotldajIe+XsklIQxLjooaQAfTmiJQaLFkNQpsnnXxrRWA/hM
         we6k79QKxDHizz+AdRymGN1R4SX+nVldVnWGN0jL4gdZIDmQpv9R51nr97O6mzSkHx
         cJJ5IoZnE5uctXhjLWv0GhyoTFmawqiU01cSQ1i8=
Date:   Fri, 29 May 2020 18:18:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        liang.j.jin@ericsson.com, Sergey.Semin@baikalelectronics.ru,
        lars.povlsen@microchip.com, andriy.shevchenko@linux.intel.com,
        fancer.lancer@gmail.com, robh+dt@kernel.org
In-Reply-To: <20200529155806.16758-1-dinguyen@kernel.org>
References: <20200529155806.16758-1-dinguyen@kernel.org>
Subject: Re: [PATCHv4 1/2] spi: dw: add reset control
Message-Id: <159077271266.17043.7681179786954514180.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 29 May 2020 10:58:05 -0500, Dinh Nguyen wrote:
> Add mechanism to get the reset control and deassert it in order to bring
> the IP out of reset.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: add reset control
      commit: 7830c0ef26cb73b653c2db2f3ca7be08f44fa046
[2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
      commit: 2604d48702fe14fb3e97701269dd5e66b392b904

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
