Return-Path: <linux-spi+bounces-3374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F8903F69
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD66B285D4B
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D0171C2;
	Tue, 11 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgbX7ACJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051022F1E
	for <linux-spi@vger.kernel.org>; Tue, 11 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118032; cv=none; b=IN6YX9b0loNU0+stUDj4g1hNKZaay/TswRPgZrjGXfiDexJr5QBaKhPfwGKNwFdnidaWRKBvguM8+0D7XcCxXR5oweZipIOd32Pl0EKdYh3XVz1+9Gu/+blImD8gnXhZsC9u71QySXGQB7YkI8dNn4jZbSd6Lpd9HMgzka0AbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118032; c=relaxed/simple;
	bh=cAaW9L79kSHLDE+jWRAzHvKswxrcbm9NYREaGnc7Ywg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sQ8M7GiiduhG2NO4fwGMs6JZQ1nLR5zblAvgoHcX7X2EYM9QU1I2Y68RaKzivRAD5vJssY/gMBb7lQrnFQMDDMO0eH9a5aiFsjgrcfMPNJn1eUlGdXHg44frqdA6gxkEG5vYbaqtXwXBkdoj9iJ1wyYqcar063hZ5tYab1m9vA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgbX7ACJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1973C4AF49;
	Tue, 11 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118031;
	bh=cAaW9L79kSHLDE+jWRAzHvKswxrcbm9NYREaGnc7Ywg=;
	h=Subject:From:Date:To:From;
	b=lgbX7ACJaMGkCObYhBKPLJ8fqvY3eAbKAQDqRE8fBTI80G9r9gN47YtRvQ7JgK7Tb
	 XFL19bd3+GeK32RCjnPyieoqfyb0yZc0ahydWhTJqEDZx55zr6Tx7E0IZMuBjQn2TF
	 mlJlJrbrV4VSXXDpsHLI+CMGyFFnaJsYMg5Jaq27yQmZb2rAr9DBKEw0IeAfQPrwRL
	 Jt0eI+i0ft+GvHErb4IafRr2c/cfy7807beNkRvKgNJP/kEduc1FRJG7uVJhvRbe16
	 16irVJe3lyVzxrPl1gcECanMr1StxCko6S74Pm2NuqCEYPfRPzwZLm1lA1WEpxl2ak
	 a0GzdoRdodP/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E004C4332D;
	Tue, 11 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171811803151.609.5860490492897465460.git-patchwork-summary@kernel.org>
Date: Tue, 11 Jun 2024 15:00:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Rework DMA mapped flag
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=857814
  Lore link: https://lore.kernel.org/r/20240531194723.1761567-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/8] spi: Introduce internal spi_xfer_is_dma_mapped() helper
             [v1,2/8] spi: dw: Use new spi_xfer_is_dma_mapped() helper
             [v1,3/8] spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
             [v1,4/8] spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
             [v1,5/8] spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
             [v1,6/8] spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
             [v1,7/8] spi: qup: Use new spi_xfer_is_dma_mapped() helper
             [v1,8/8] spi: Rework per message DMA mapped flag to be per transfer


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



