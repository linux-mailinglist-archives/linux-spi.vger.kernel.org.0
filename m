Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB80268E91
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgINOxD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgINOwr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:52:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F28D20715;
        Mon, 14 Sep 2020 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095166;
        bh=M2DIyqZOF1aOYfADXh4hvgjSrHg+ONJQHW16u8xBjA4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0d2IhcbTsNq3ez+y+kRsDIEtX9nWSFo8nFYmvPWfwl7rZ/Dt+D9H9A/+CU3+bFfFk
         a/zyAD4incso7WguvIDi8GCiGuKprme3/qQN79S57e2CJGeQNIBS6kicHaU3gLUdlO
         eyd4Vg3/HIctzsK49G8UImGV9DWEPrApD0H8q9SM=
Date:   Mon, 14 Sep 2020 15:51:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200910150410.750959-1-colin.king@canonical.com>
References: <20200910150410.750959-1-colin.king@canonical.com>
Subject: Re: [PATCH] spi: qup: remove redundant assignment to variable ret
Message-Id: <160009511676.5702.4493764455278443968.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 16:04:10 +0100, Colin King wrote:
> The variable ret is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: remove redundant assignment to variable ret
      commit: 4a6c7d6f940107d6383291e2cb450039790b752d

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
