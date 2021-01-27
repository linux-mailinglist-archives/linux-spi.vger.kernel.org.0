Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9173061C4
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA0RTH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 12:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235673AbhA0RR3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Jan 2021 12:17:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909D860187;
        Wed, 27 Jan 2021 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767779;
        bh=tgc2UpnkFEr+6Oo2VTYkvyACd+6I6bE9ssogdiQszhw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jGMjbqt7jRh8sraHfE9Ul/AJPDHzlAyqHNyuRtfeqyEWthQR7DvQC2F9j7WHgIzdq
         0zNH72dhj8ecNcizagYbKTPmKfDDjKg/LCMZKfp22IQyhhVL/tosmxf07rZ8X3W861
         I/DZSCcdigP2cTF2h8AEWyvPnG7xOHjlCRXdw8Sio7lkkTG3xnQso79XsjgrDI2Aq6
         ZqYRXKnfBHa7Hyf6/IdaUC3dSIbqWTRezow51OX9qoDZQBdgRXgh7B1p/UeNtw2eVH
         2HFbWjsYkaEiSSzZZ9zZBMtLQNm3lm8xWZ7nQeMKULVL1NNtNrAHBAjq+00E7hf2Yn
         FP3O+lV22na5Q==
From:   Mark Brown <broonie@kernel.org>
To:     richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com,
        linux-spi@vger.kernel.org, Yicong Yang <yangyicong@hisilicon.com>,
        tudor.ambarus@microchip.com, linux-mtd@lists.infradead.org
Cc:     linuxarm@openeuler.org, john.garry@huawei.com,
        prime.zeng@huawei.com
In-Reply-To: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
References: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
Subject: Re: (subset) [PATCH 0/2] Add check of 4-byte when parsing SFDP 4bait table
Message-Id: <161176773014.34911.1124682946060569750.b4-ty@kernel.org>
Date:   Wed, 27 Jan 2021 17:15:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 27 Jan 2021 17:40:48 +0800, Yicong Yang wrote:
> Add check of 4-byte address mode support when parsing SFDP 4bait. Some
> flash will provide a 4bait table and the spi-nor core will convert the
> address mode to 4-byte without checking whether it's actually supported
> or not by the controller. For example, the 16M s25fs128s1 provides the
> 4bait and will be convert to 4-byte address mode, which makes it unusable
> on hisi-sfc-v3xx on hip08 platform.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: hisi-sfc-v3xx: add address mode check
      commit: 6d2386e36440165da782dbc5c0de40f31665e108

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
