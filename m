Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4C79D033
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjILLie (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjILLiX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 07:38:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053F10E9
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 04:38:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43EC433C9;
        Tue, 12 Sep 2023 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518698;
        bh=GazCs2Kf1iDiEpkpUgz0UITCBvE/baB+4EE9STJQldk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SnO/OSfv22IW0OEkOEp9f9mMNUdCuBVkbCNur5ddLrBS8Er76AuQHSrw5Rh6YoYQx
         tS+NkYDJ0hzyO/todODkTySEE8/cM8sm+tI8hVfrwbnjlSYdn+suJanpEBR7uXjHlf
         oJ2iMbtEkCYe3WfrWAsAGOam5KlHjfqoVqeKZW84ZdNjv1bBUdfew502nmEbX9ZRnh
         qhxlYq3imcNZEPQy97KHLUGO2PXS3Mxb1h9AjP+wTUa5dI8GfuiSdOtyblLylbNQKZ
         nq7ctfFpTA+X6kYH/WzxKqMfQXyuT8D66LN35GPAnqcia0SwgUz2rS5vRXOqjl6v/+
         xAELorUFWY3Jg==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230911074616.3473347-1-mika.westerberg@linux.intel.com>
References: <20230911074616.3473347-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel-pci: Add support for Granite Rapids SPI
 serial flash
Message-Id: <169451869721.2398433.18209726711096429200.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:38:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 Sep 2023 10:46:16 +0300, Mika Westerberg wrote:
> Intel Granite Rapids has a flash controller that is compatible with the
> other Cannon Lake derivatives. Add Granite Rapids PCI ID to the driver
> list of supported devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Granite Rapids SPI serial flash
      commit: 9855d60cfc720ff32355484c119acafd3c4dc806

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

