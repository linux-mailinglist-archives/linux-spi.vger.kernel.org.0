Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7138C3E2032
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhHFAs3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241970AbhHFAs2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 796BD611AD;
        Fri,  6 Aug 2021 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210894;
        bh=g0boiJUI20ohNR05gdJT6zHOQ29SdiPMy7CKsuLlabo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLdAZEZcOVQU2akza7AgcDopjV0flIcNP7s+yFMeKDRdRMCJG9bncuM53MpLXu7IW
         KbPbETFGcH1CvfcxRr7uu+iOTGwa6c6EqRIhm0rgYNw4m0uApEtaU3KZGnVDj6YOZ5
         2VugzLVvZ+WHgmuKMKN3yQwW+YmUm+DYtPwArKbGpszM7av0y5xk+XW4iqjaM9MVAq
         zliaV5BpzJc6xVp1xfMrDbFA/UN0lO6puNotMwSrWqNia0N3UMzUMwi6lBZTcflM/t
         yKDa3JDRzatHofRuMzcKHPhMBWi4XauoR3N1IcHzmnHubsWIZcqqCi+aelH3OGsAjS
         tnZzOI9M1oVKw==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        leilk.liu@mediatek.com, Mason Zhang <Mason.Zhang@mediatek.com>,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] spi: modify set_cs_timing parameter
Date:   Fri,  6 Aug 2021 01:47:45 +0100
Message-Id: <162821082762.19049.15691152650066711280.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719091642.24633-1-mason.zhang@mediatek.com>
References: <20210719091642.24633-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Jul 2021 17:16:43 +0800, Mason Zhang wrote:
> No need pass in spi_delay to set_cs_timing callback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: modify set_cs_timing parameter
      commit: 04e6bb0d6bb127bac929fb35edd2dd01613c9520

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
