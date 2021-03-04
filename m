Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D725432D5FE
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 16:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhCDPHA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 10:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhCDPGz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:06:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65E6564F68;
        Thu,  4 Mar 2021 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614870374;
        bh=UZEqoiIUd+AChmFNV4x9e+9lJhJgHFmgQLoyhWdFl+8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M8mUWvn25dVXmw1Gguk6F4UX1CUKaaOOj29FZ0I/22b2Q/qMTN2QUOg+nLrY8NKOL
         Y4Ji+3kM3bZXaWIE7fyJQBRq397Z9iRH1G7EbqHYJx2zGYIGr9Kjr9Sti0KTJovesN
         mq4bbW6Gca7PE5kEB2RVLRMiZUOTNjY0IE1GkGQsI1aUDZLgE02BpDaEY7IEj6roFa
         ajELaKTVTginww9uzcN6OUmRr1QvWvDMv29GBSzRO2CqtHJlRCr4rRMGYnlKPVGx8W
         YiIoG55Pe9i0GJm7f69gaXPwEiC0DfYlRXhIviYLNxGnup+rSWR/aSYyJcbNOIJOqq
         NvAE1xyCm6hcw==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     hanks.chen@mediateka.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>
In-Reply-To: <20210226110109.30500-1-Mason.Zhang@mediatek.com>
References: <20210226110109.30500-1-Mason.Zhang@mediatek.com>
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-Id: <161487030159.30767.11054945560843841398.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 15:05:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Feb 2021 19:01:10 +0800, Mason Zhang wrote:
> this patch update spi document for MT6779 SOC.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] dt-binding: mediatek: mt6779: update spi document
      commit: 483a27f372345a1d1a2cd0fd95da987e30ad0e01

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
