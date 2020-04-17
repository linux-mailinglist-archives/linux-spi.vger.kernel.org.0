Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3D1ADE2D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Apr 2020 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgDQNWX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Apr 2020 09:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgDQNWW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Apr 2020 09:22:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F231E20724;
        Fri, 17 Apr 2020 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587129742;
        bh=ApBjG0GzABKPlb6hTloJ5iIZRTvdSJEPOLZX/3D9xdE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aybB42pK1v8St7Ynd0lCznycB8uo8tw9o7vLKnthk6G+Nir90qAFjZiUGikUjSWaY
         Pjqeqk48sBzHh5XJN0uOkSvEj6N9muanljwWT9YOzpKd36mnD8UL1sDd6jV+ulGi3O
         7wN2ZI6jQwpvnhu6QzeM0YJ1TtfcbAPWIC3Sy1EY=
Date:   Fri, 17 Apr 2020 14:22:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        "patrice.chotard@st.com" <patrice.chotard@st.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        mcoquelin.stm32@gmail.com,
        Christophe Kerello <christophe.kerello@st.com>
In-Reply-To: <20200417121241.6473-1-patrice.chotard@st.com>
References: <20200417121241.6473-1-patrice.chotard@st.com>
Subject: Re: spi: stm32-qspi: Add pm_runtime support
Message-Id: <158712973998.35869.11870096143660307572.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Apr 2020 14:12:41 +0200, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> By default, STM32_AUTOSUSPEND_DELAY is set to -1 which has for
> effect to prevent runtime suspends.
> Runtime suspends can be activated by setting autosuspend_delay_ms using
> sysfs entry :
> echo {delay_in_ms} > /sys/devices/platform/soc/58003000.spi/power/autosusp
> end_delay_ms)
> 
> [...]

Applied, thanks!

[1/1] spi: stm32-qspi: Add pm_runtime support
      commit: 9d282c17b023a97516a63255ce7f7ee65c39bec1

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
