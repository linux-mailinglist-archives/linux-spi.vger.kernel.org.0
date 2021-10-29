Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0414440496
	for <lists+linux-spi@lfdr.de>; Fri, 29 Oct 2021 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJ2VEb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Oct 2021 17:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhJ2VEa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 Oct 2021 17:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB7F56108F;
        Fri, 29 Oct 2021 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635541321;
        bh=k/9gRXEgqeRODD1rKbqGVKZ8T6xZHRQBkmfRxa6qNlg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MwKL/aS5jw8FFXHLlhD40128JLZ9XvWfrSZ53F25wOMaIPp0xtIvowrfNsx7Ghhvk
         P6ZJnJmJbdQQQ4EcMgAA9CUaK/pwpShz9Drv33GoBqq73c5mGMu26jxQzWRa/neO0+
         QK7PKeaEcConKeJafkmiNt6ZPYKBzWx145OKDzXuhjYLi+H+qkBThAEakviCCcKpj5
         d5pN1wu/rb3rOw8Ms0FvyV5f5+W/ZcODR+MlEBYOGFWosk7eT6M+2l1ANNkepl3r1n
         7lOHq/Ev+bK/8S7vye01agc0giykUGRbVVry3Cv1qhmNVa4E1iTERxrs9AGncf6Ecn
         HkjBsuKk1YGYQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210927105818.445675-1-kuldeep.singh@nxp.com>
References: <20210927105818.445675-1-kuldeep.singh@nxp.com>
Subject: Re: [Patch v2] dt-bindings: spi: Convert NXP flexspi to json schema
Message-Id: <163554131964.1998521.14158610050772698166.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 22:01:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Sep 2021 16:28:17 +0530, Kuldeep Singh wrote:
> Convert the NXP FlexSPI binding to DT schema format using json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Convert NXP flexspi to json schema
      commit: 28b5eaf9712bbed90c2b5a5608d70a16b7950856

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
