Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70001ADE2F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Apr 2020 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgDQNW3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Apr 2020 09:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgDQNW2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Apr 2020 09:22:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB5F2087E;
        Fri, 17 Apr 2020 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587129748;
        bh=fDlDCrBXL1Hrgj28P+I0Wp6MAPvYyysu+6jvwshAplE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=a0j5IILXh6EbQWLLTR5nivO1pcKu599TldGW4k0lPFG1EASWMZbIvIGD52H/8L+x5
         QhWmiHOw2lUzMsgV+G6WSu7I/5Ctq+8Lg0uZhMHOfeTSolY2oDUFaiwyW42gupM+LG
         m6IKkm1I+BLWZUM51MmaLQ1zgaSiP07cgmNyBTWk=
Date:   Fri, 17 Apr 2020 14:22:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>, linux-spi@vger.kernel.org
Cc:     john.garry@huawei.com, linux-mtd@lists.infradead.org,
        linuxarm@huawei.com
In-Reply-To: <1587109707-23597-1-git-send-email-yangyicong@hisilicon.com>
References: <1587109707-23597-1-git-send-email-yangyicong@hisilicon.com>
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: add error check after per operation
Message-Id: <158712973997.35869.11831394586423684759.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Apr 2020 15:48:27 +0800, Yicong Yang wrote:
> The controller may receive instructions of accessing protected address,
> or may perform failed page program. These operations will not succeed
> and the controller will receive interrupts when such failure occur.
> Previously we don't check the interrupts and return 0 even if such
> operation fails.
> 
> Check the interrupts after per command and inform the user
> if there is an error.
> 
> [...]

Applied, thanks!

[1/1] spi: hisi-sfc-v3xx: add error check after per operation
      commit: 59fc9ad5cb108bce18043281c7cf67f2b425d55d

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
