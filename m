Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC601ACB41
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbgDPPpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 11:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409689AbgDPPpK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 11:45:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60F421D91;
        Thu, 16 Apr 2020 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587051910;
        bh=9ry9z5cPWT6b3qsfKrvwd1wOLF1JAP7Tyrk+39VbvE8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=i+W8m4d5EBX8ql5pApge80SNjO055BMgbvxSI7dv8kgwml5LUFY5/2iiEkoEe/OnE
         8c/5xUi4O0ZwtTT3qirjMXXRiR9wKzo0HqVDDyeE9ATpp/Jm279hN3z4G+ZJO3bx0N
         Ge6YHoMWFr4dTAeCpYFSxNset/qQnWJX3l6LgWiI=
Date:   Thu, 16 Apr 2020 16:45:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200416110823.22565-1-cleger@kalray.eu>
References: <20200416110823.22565-1-cleger@kalray.eu>
Subject: Re: [PATCH 0/2] Cleanup chip info in spi-dw driver
Message-Id: <158705187475.53607.4216901757113789779.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Apr 2020 13:08:23 +0200, Clement Leger wrote:
> Some mechanisms have no more user, and as such code paths are unused.
> Remove these code paths and associated structs members.
> 
> Clement Leger (2):
>   spi: dw: remove unused dw_spi_chip handling
>   spi: dw: remove cs_control and poll_mode members from chip_data
> 
> [...]

Applied, thanks!

[1/2] spi: dw: remove unused dw_spi_chip handling
      commit: ae9e6ac4d8542d1b16fad4bd3c3e447632437623
[2/2] spi: dw: remove cs_control and poll_mode members from chip_data
      commit: 33e8fd4bfbd7eb0921eb55caceed54e51912a4e6

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
