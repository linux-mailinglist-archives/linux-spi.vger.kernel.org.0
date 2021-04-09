Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60B35A30A
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhDIQXw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhDIQXu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 153676105A;
        Fri,  9 Apr 2021 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985417;
        bh=FC85rjP9iluvlNakgNyxCcfjQMrwMM/pqcP1lgIxhZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skIsBSVMH9Ofo9QjyMg82J638Ax7nCX9VpTtPTxr8nvHSuFRbbDaJVkZ5AxCVnE4w
         7vToqRJrKz4yS3emLyyKOfWoKTNzpfSzSLRMC00Gs3640S0wVhjT2TrEAO47+h4VHF
         hw6tadW/st7XMnVBGoDXoHJDe0YdKCUtAJJVheIRigF3uPdHtXF6TF8xKarUDrZcBl
         FvL7HeyYVKMg5nDn3xBpNMk4yMJYtbZrrilqzF5uQBKBUFEtmNMe0aPwEoRYd6GE2X
         3yg8cInPsSkEOjjP0WG44W93zWDsQXTsfojuq+vxn/RrNRlsYhqJR0t5MyevHkhin0
         rF4inOrUmazCg==
From:   Mark Brown <broonie@kernel.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        Wang Li <wangli74@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: qup: fix PM reference leak in spi_qup_remove()
Date:   Fri,  9 Apr 2021 17:22:46 +0100
Message-Id: <161798356987.48466.11674282962470154203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409095458.29921-1-wangli74@huawei.com>
References: <20210409095458.29921-1-wangli74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Apr 2021 09:54:58 +0000, Wang Li wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: fix PM reference leak in spi_qup_remove()
      commit: cec77e0a249892ceb10061bf17b63f9fb111d870

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
