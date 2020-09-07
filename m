Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A5260435
	for <lists+linux-spi@lfdr.de>; Mon,  7 Sep 2020 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgIGSGy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Sep 2020 14:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgIGSGo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF8420738;
        Mon,  7 Sep 2020 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599502003;
        bh=CSGLZgC7TEScaQRoN9rKXOxHIB1UVechuf/uXlfBqqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ULzVERjsYSef99QHRBtWac2dbhoKGwuPBCWSJfbmr2eXCT6igcvgPMopNGGVw5r5J
         k77HUm3lRWWBi3LnGppw+X21pzCZngyEIVBk1TL7NxycgN5dFBAPS6keLgmw2rGex6
         AF7rzAqU5zpAj45PdY/h07pZcUQl2toMlDZoowms=
Date:   Mon, 07 Sep 2020 19:06:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20200904163709.110975-1-alex.dewar90@gmail.com>
References: <20200904163709.110975-1-alex.dewar90@gmail.com>
Subject: Re: [PATCH] spi: qup: Allow for compile-testing on !ARM
Message-Id: <159950195998.52926.7999875606949643050.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Sep 2020 17:37:10 +0100, Alex Dewar wrote:
> There seems no reason to restrict testing to ARM, so remove this
> constraint to improve test coverage.
> 
> Build-tested with allyesconfig on x86.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: Allow for compile-testing on !ARM
      commit: 2abaad678575acd54e9939e1174becd82ecc884b

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
