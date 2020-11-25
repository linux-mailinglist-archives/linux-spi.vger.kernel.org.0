Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C243C2C418E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 14:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKYN6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 08:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKYN6u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Nov 2020 08:58:50 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E6E206E5;
        Wed, 25 Nov 2020 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606312730;
        bh=kMWPLddZeJ+iT1zpRIFZnAm9AkHKhLeUv8iaxlk9Cvg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qnuaQW+uX8hpgq3lWYBTfGUCVPq6+QAYukHRnsbhQgYtuYRE8XDyaQlwFuv8nQVHY
         gwi1g8J1snDO2660Hu917IR+c504zKPIi5HRmMyEkLd0iTVj8xH74iA3bRMlm1oSt/
         FAkg85eHOZFWpUuIXABOl1wGhs6Q2Nt/GPuknPbo=
Date:   Wed, 25 Nov 2020 13:58:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, Tian Tao <tiantao6@hisilicon.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1606114975-31362-1-git-send-email-tiantao6@hisilicon.com>
References: <1606114975-31362-1-git-send-email-tiantao6@hisilicon.com>
Subject: Re: [PATCH] spi: dw: fixed missing resource_size
Message-Id: <160631270510.29611.2327233732036915740.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 23 Nov 2020 15:02:55 +0800, Tian Tao wrote:
> fixed the coccicheck:
> drivers/spi/spi-dw-bt1.c:220:27-30: ERROR: Missing
> resource_size with mem.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: fixed missing resource_size
      commit: 459ea85049b01708e364c34deac24b00909c73ed

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
