Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E1280A7E
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbgJAWsc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWsc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 18:48:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66EB92074B;
        Thu,  1 Oct 2020 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592511;
        bh=HJAceHjNmI0w6jMzcsSCsQTUfL3f+tHLLMztyFqbahc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Oc0Awc8+MAzul9ThDS2GbMegypRn64C7XB+TNrsS5cArO7/OERV0fqRZgnL/pVZKU
         iEJeY2g2XH/TeZwpbEdhqoSXIPDa18TTWDVyH8vRXI8vsMPFrrcfu3/g2oyDf8w1BE
         sAFvN1DcKQtCdmrzF35Tuvjaw7Wmj0sfWEx6ujZo=
Date:   Thu, 01 Oct 2020 23:47:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, bayi.cheng@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20200924152730.733243-1-gch981213@gmail.com>
References: <20200924152730.733243-1-gch981213@gmail.com>
Subject: Re: [PATCH 0/3] spi: spi-mtk-nor: make use of full capability of
 program mode
Message-Id: <160159244787.45030.10393633428346828071.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 24 Sep 2020 23:27:27 +0800, Chuanhong Guo wrote:
> "program" mode on this controller can trigger up to 56 bits of data
> shifting. During the operation, data in PRGDATA[0-5] will be
> shifted out from MOSI, and data from MISO will be continuously filling
> SHREG[0-9].
> Currently this mode is used to implement transfer_one_message for 6-byte
> full-duplex transfer, but it can execute a transfer for up-to 7 bytes
> as long as the last byte is read only.
> transfer_one_message is expected to perform full-duplex transfer,
> instead of transfer with specific format. mtk_nor_spi_mem_prg is
> added here to use this extra byte.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-mtk-nor: make use of full capability of prg mode
      commit: e7edd2cf4c7d06c6ef3e2030f66eeefa5150f0ff
[2/3] spi: spi-mtk-nor: add helper for checking prg mode ops
      commit: fd806575921ab78c8f0ee7f4dd3d4bb7c16206c8
[3/3] spi: spi-mtk-nor: fix op checks in supports_op
      commit: 81f13f2116cd93910d958c58052ef7dc22f1e577

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
