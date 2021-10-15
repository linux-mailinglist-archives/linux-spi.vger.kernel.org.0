Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977BA42FC71
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbhJOTuA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 15:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242743AbhJOTuA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:50:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F18B960FE3;
        Fri, 15 Oct 2021 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327273;
        bh=MJPsHvidCacfE7+zHjY1MkUSKSDOfvcCzA2XngQ9imE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWLMGfEMDqKuk1Czt3VlK4DqZ1+9s5CRTEgYKo4O34V3OcdrHY1HGF0v0cr1J6y4B
         lfuJxX7QVmR+XDo00d9HMrLjswVDhxmmOog2n9uWDqCp0gsq/868ShJH/gdl41HEpE
         iEVibg7GAZfUM3InWBqcKLWfvou2Yf/OHUL/v00r04byEIxWBIR2L11pLSSLkeOTXY
         kYdjmzytQboq3Ibf/GCmAClPwLiIhdu7Dv5pB+0Tb8rT9hCBj3go43uWyJkN4vVH9r
         Dy7dld5iHvXMhAD0oYVj5otzJ54x9IYR9r3k9vrpQRUUvuXTB/uhOqqKQTCw+TfVa7
         0wYfUb7BugzrQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] spi: orion: Add of_node_put() before goto
Date:   Fri, 15 Oct 2021 20:47:48 +0100
Message-Id: <163432719233.1317044.6376662105873340933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015034008.6357-1-wanjiabing@vivo.com>
References: <20211015034008.6357-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Oct 2021 23:40:08 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/spi/spi-orion.c:738:1-33: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before goto
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: orion: Add of_node_put() before goto
      commit: dbf641a10f6138fb84866d33ac05f9e1eae95e04

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
