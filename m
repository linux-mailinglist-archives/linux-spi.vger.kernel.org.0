Return-Path: <linux-spi+bounces-1092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D818B84B524
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A891C2455D
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD175B1E8;
	Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfQp2Ykb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A112C54B
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221428; cv=none; b=CqxHBu0eMxdguh/IBC2Fje3ucOERGws5ScpXTnuD66cpXiyRR+oD5ztQ+xcOLhwX1p8T+Fdweg/PVmRC2YHck6/g4u4IxlhlVYwsF/8pNRrGgQgnNc7f3TDMh8d/3Nn3t737FANveKd9hiC0bRbx7ZhzhBuJ4sOjjVABKCNU+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221428; c=relaxed/simple;
	bh=FkUZg06AwUksnw1NfY6plEy6C+nSQYN4HwPA/szwJrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lqvubeFDv2kd1wsl1JKCZSWEN0qzB8zpJob7NwVd+2ovrI30xwpW4sDWh0homfycfMtzB59YG0xJvuZ55sKWJjoY34zj2JGJPYt70mW23bw6NgtB4FN4X4b4P1bEcUj34qZDmfD1mC9pgdRond1VY9Sn7hbxRwsVz5gREsNBO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfQp2Ykb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42645C433F1;
	Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221428;
	bh=FkUZg06AwUksnw1NfY6plEy6C+nSQYN4HwPA/szwJrw=;
	h=Subject:From:Date:To:From;
	b=KfQp2Ykb9Gmw3WWbnOVb8RFnd4oqXV2KMROF2+UhtV+ev+L1SJhdNC93a4IoKb3Qx
	 01U5ayLk9pJ2jQLx084/auA99CXQ2Q7gHrxqoNQPlJ1yi81UV7BHYlnFjtuxGZT/hE
	 llzxh2zYTqs1yxgIQ8+c7R2MqTU53JdrZm5ULaj+qPPElYqiCiNkic4+3v9r61w5y7
	 tCiffKHye4XI0QVsWx2lt2Q6uaLmlMkRhmSInZEplkZz4u6z5vqL/zD1CQiZ7YD4zb
	 yTrODQj/3TxR7vzb6M6hj5Tl10VbTYU7TlvzsqI7NYqKwXdq139w4njFSVageVuft4
	 EvTsf+qZ9Mr0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2343EE2F2ED;
	Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
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
 <170722142808.5713.12094789112693625168.git-patchwork-summary@kernel.org>
Date: Tue, 06 Feb 2024 12:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-rockchip: Fix of chip select lines handling
  Submitter: Luis de Arquer <ldearquer@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820380
  Lore link: https://lore.kernel.org/r/08e518f54f94b78a3985a3c9247bced5b275433b.camel@gmail.com
    Patches: [1/3] spi: spi-rockchip: Fix out of bounds array access
             [2/3] spi: spi-rockchip: Fix max_native_cs

Patch: spi: move split xfers for CS_WORD emulation
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820403
  Lore link: https://lore.kernel.org/r/20240126212358.3916280-2-dlechner@baylibre.com

Patch: spi: axi-spi-engine: use common AXI macros
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822677
  Lore link: https://lore.kernel.org/r/20240202213132.3863124-2-dlechner@baylibre.com

Series: [1/2] spi: intel: Add default partition and name to the second chip
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822092
  Lore link: https://lore.kernel.org/r/20240201121638.207632-1-mika.westerberg@linux.intel.com
    Patches: [1/2] spi: intel: Add default partition and name to the second chip
             [2/2] spi: intel: Keep the BIOS partition inside the first chip

Series: spi: fsl-dspi: A couple of error handling improvements
  Submitter: Andy Shevchenko <andy.shevchenko@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822963
  Lore link: https://lore.kernel.org/r/20240204203127.1186621-1-andy.shevchenko@gmail.com
    Patches: [v2,1/2] spi: fsl-dspi: Preserve error code returned by dmaengine_slave_config()
             [v2,2/2] spi: fsl-dspi: Unify error messaging in dspi_request_dma()

Patch: spi: bcm2835: implement ctlr->max_transfer_size
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820408
  Lore link: https://lore.kernel.org/r/20240126220024.3926403-2-dlechner@baylibre.com


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



