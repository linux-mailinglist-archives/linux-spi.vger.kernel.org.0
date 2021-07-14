Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF163C8811
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhGNP6v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 11:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhGNP6v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 11:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA1B2613CB;
        Wed, 14 Jul 2021 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278159;
        bh=TT8B40G4FziVL0f4va1Rbl5gfyVf7JeFYXNQYLowgX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgW43q6f6rqrahLliz8Usrk8sJV2IO1Nm1HQdeV/Q91udmukL55QXWw7HvDeeYJhv
         Y8vnTY0VjbJ4gOqg2QSn/V/zxwkmY78832Re3Hm8BEWj1ODjopgRSCcjmiKWQROco5
         gKa1Ed2//EvYSoAX6DlzGLAsYUruDaqxLftjYETX0Jyp+3ST6wlyEACUD0Ol+vV+XU
         xe36uEpo9wTDi0bzjlkc+FBvvPyidjYvQ65QLYOJ3GVJgs07PXcPzD798QkEv2+TLq
         df+XTBk5fiZVdJl+c3yG35lK0M6lz4w3clxyHP6DxdRQrxGxptZg8LDqu1WA1pN+7c
         Om3bwAzK5yP0w==
From:   Mark Brown <broonie@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spi: omap-spi: Convert to json-schema
Date:   Wed, 14 Jul 2021 16:55:13 +0100
Message-Id: <162627784666.55213.15958004001064972749.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621092900.951-1-a-govindraju@ti.com>
References: <20210621092900.951-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Jun 2021 14:58:58 +0530, Aswath Govindraju wrote:
> Convert omap-spi dt-binding documentation from txt to yaml format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: omap-spi: Convert to json-schema
      commit: 014861c2fb3d7b38b8de32baa953082bb9dabaf4

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
