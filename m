Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564D13D2AED
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhGVQ3k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233430AbhGVQ3j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEC44610CC;
        Thu, 22 Jul 2021 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973814;
        bh=CICPC0K7i8ZnmYxOvNvLJEa361LHxHiMVcLPXgxl+nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Npgpt349pM2AdqnJEJHirXHAxtFWzJuUKnkFFF9HqMwv9e1C7VwKtOf9Pzh7riHTy
         YD6WZreDg8owbB8IRAwLyrT/OZJ8UHyN3y552xfW5jDnBE9G0uuXk1m8hM3iaGNEXv
         3MAem+MrgwJ20GL2Cacm6m3OX39zyUmjbQr2NEN1VRc14PxHIMQoH7lThUH1Vs06Bx
         KW68ip4ZsEhCuFJLu+evI/ldM5AcxQanL0x3lUx0RibBPFIo+lnxsR5rh6TzGgRJap
         +YSAhc6K6Xg49Af+zqgmdZSSwv/VTT8nl2IwW49sPcAHR4CbYAnfAjjRgFaSYgF8P+
         SRssuV7YF02iQ==
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: update modalias_show after of_device_uevent_modalias support
Date:   Thu, 22 Jul 2021 18:09:56 +0100
Message-Id: <162697114030.3066.1118388104811208682.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <mvmwnpi4fya.fsf@suse.de>
References: <20210525091003.18228-1-m.felsch@pengutronix.de> <mvmwnpi4fya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Jul 2021 15:48:45 +0200, Andreas Schwab wrote:
> Commit 3ce6c9e2617e ("spi: add of_device_uevent_modalias support") is
> incomplete, as it didn't update the modalias_show function to generate the
> of: modalias string if available.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: update modalias_show after of_device_uevent_modalias support
      commit: e09f2ab8eecc6dcbd7013a1303cbe56b00dc9fb0

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
