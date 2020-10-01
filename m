Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE9280A7D
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgJAWs1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWs1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 18:48:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729DF20754;
        Thu,  1 Oct 2020 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592506;
        bh=PzxAGyWkFMs9bDUO/DayB4OFoapt5wo8XOfBXkyWiEk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FiMCbxH+j2Mnmq5jaWra0qY6BOvCdl7pgCpSCxxg/zRoleH5STTfAkU8tBHN+Mqq6
         u2PmZcxaMlwujLfOMhr/sqqhAiZg6p9mlp9l77a5cH82lSIIwQ5MXJLe7jIF+ZrBIP
         IWi9qwE9dvQBUvpRVRwP8SB495qcMhuS0fskXeqc=
Date:   Thu, 01 Oct 2020 23:47:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Cc:     tudor.ambarus@microchip.com
In-Reply-To: <20200921071036.2091-1-thomas.kopp@microchip.com>
References: <20200921071036.2091-1-thomas.kopp@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: Exposing effective spi speed
Message-Id: <160159244787.45030.969410843987771816.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Sep 2020 09:10:36 +0200, Thomas Kopp wrote:
> This patch implements the reporting of the effectively used speed_hz for
> the transfer by setting xfer->effective_speed_hz.
> 
> See the following patch, which adds this feature to the SPI core for more
> information:
> commit 5d7e2b5ed585 ("spi: core: allow reporting the effectivly used speed_hz for a transfer")

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Exposing effective spi speed
      commit: 23f370c748580643d17b5e064478b89cba3fdc78

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
