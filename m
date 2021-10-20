Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EEB434A03
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJTLbA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 07:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTLa7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Oct 2021 07:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAF7A61212;
        Wed, 20 Oct 2021 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634729325;
        bh=MKnIgjnyh4yy7GjO8B3cuE67a4nVGm6HvG6ka9bRt6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuklkKH9kwMi1wnEw4DTFIYV9gu8FJ1lmfcTHyCdK6QwIK0G3l/srztNVB4uuncZe
         Hp4uZ4VUJWe6VAetKQmxy9L68wTdlgY52WnCK8jAQXx317yy5JtaKA6BZyVvBH90BJ
         j+unApsnO/BP/+4ifRB6xQTYKHQJHQLrdDyG++qvpwV7tjzyb2DwffFssUhmiAxE3M
         tAQTmZ7P8SxrVWjmurBk0Uykzf5QEDM893542yljuELGQfa/OxlWNJ230M4uyDdpW9
         bS5sM3UQzxJcCCrxSNsTQCo/v7hshQ6s/h7n0Yv/8/vF/JIRRIMU1b6WxdYbv36qi7
         yhDzYor+aKIyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, yilun.xu@intel.com,
        hao.wu@intel.com, trix@redhat.com, matthew.gerlach@intel.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Date:   Wed, 20 Oct 2021 12:28:35 +0100
Message-Id: <163472931597.2896731.8898998554270520843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019002401.24041-1-russell.h.weight@intel.com>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 18 Oct 2021 17:24:01 -0700, Russ Weight wrote:
> The spi-altera driver has two flavors: platform and dfl. I'm seeing
> a case where I have both device types in the same machine, and they
> are conflicting on the SPI ID:
> 
> ... kernel: couldn't get idr
> ... kernel: WARNING: CPU: 28 PID: 912 at drivers/spi/spi.c:2920 spi_register_controller.cold+0x84/0xc0a
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: altera: Change to dynamic allocation of spi id
      commit: f09f6dfef8ce7b70a240cf83811e2b1909c3e47b

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
