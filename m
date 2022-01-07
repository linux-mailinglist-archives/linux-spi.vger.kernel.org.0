Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1043C487C22
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbiAGSZb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 13:25:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52820 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiAGSZW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 13:25:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F013AB826E7
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 18:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC65AC36AE9;
        Fri,  7 Jan 2022 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641579919;
        bh=LNmZN+/92hM8wUigszLDu2ZHByuf995Lq/6yE4EN5MQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p6DChL7+cwD/8wsVLVtLUc7XnEaC0EWFsmRLBTiL9TNhPQbMRc/VWMGKcgXZuB+mz
         EvTivNVsWCRbAC78gUJ+HKTuEkS7FUX2F/HaZbJHnJIJq9DjyVhIU4TEhBzbCNIR6C
         JN6RHWKSl+qwLwNYY+kKtrIw/j4YqVrtFZKygCjfCEU5GPPrmncw3NM+0Wc4cedIBf
         WURusYXN304CzhDp33v65X2G1gCIMGu9ssb9vr/4BgVZx6gzpLX+lWt2SAie1U37pK
         8OdpbRw3Nf/0ijDrX6tzwkOcrRLD8GtqOp4AA1jQkAbn35aIqEs71qAFotXFVbimao
         7CIOWKhSt4Atw==
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
In-Reply-To: <20210904013140.2377609-1-kuba@kernel.org>
References: <20210904013140.2377609-1-kuba@kernel.org>
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-Id: <164157991867.718384.7822662144649113269.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 18:25:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 3 Sep 2021 18:31:40 -0700, Jakub Kicinski wrote:
> Commit b42faeee718c ("spi: Add a PTP system timestamp
> to the transfer structure") added an include of ptp_clock_kernel.h
> to spi.h for struct ptp_system_timestamp but a forward declaration
> is enough. Let's use that to limit the number of objects we have
> to rebuild every time we touch networking headers.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] ptp: don't include ptp_clock_kernel.h in spi.h
      commit: 44ea62813f0ab3d718de480504f4dfd0bdd01858

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
