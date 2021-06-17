Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72A83AB6BC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jun 2021 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhFQPDt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Jun 2021 11:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhFQPDt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2FE60C3E;
        Thu, 17 Jun 2021 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942101;
        bh=3RE7WRrA88CdxT7JvZykyqTLFvdVb+YMRibG14mS8LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pd1GNfenFPnLQaobl+oQhagXfO2dbKFv8POIZgo2FkTelsWvmx74wqC3BjKU1XRLT
         26TWPgGNbND4XlIb+oHeC21ZCpPmGEcMQ3LnFw77mJpGxpJzm/OvAcsAUYMQNuMSjP
         Lm+YTR/ktxssHyYxI1mO1BnEgUCuRG/bBeezBaQ8aGh+pbiKtJWBkJMDPc6Zsmkodb
         abthEJVkKdn2Zo5emkpWS3P9CcTRBgmdspXinwbVwIiLKbLh62+Ch5p9AnMKQ/ntLV
         JQTrZOMbp9Kwpt5054MwtH6ab0D8RxyW/5Ne7PCwsbsSBzEGUAFMkWmsPEGsKfH/7h
         v1j4Ero+rtxgw==
From:   Mark Brown <broonie@kernel.org>
To:     michal.simek@xilinx.com, robh+dt@kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinik@xilinx.com, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: convert Cadence SPI bindings to YAML
Date:   Thu, 17 Jun 2021 16:01:13 +0100
Message-Id: <162394121400.19455.13291098800034403183.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605003811.858676-1-iwamatsu@nigauri.org>
References: <20210605003811.858676-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 5 Jun 2021 09:38:11 +0900, Nobuhiro Iwamatsu wrote:
> Convert spi for Cadence SPI bindings documentation to YAML.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: convert Cadence SPI bindings to YAML
      commit: aa7968682a2b8a9cecf1d7d07e1c8ae8c08d211e

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
