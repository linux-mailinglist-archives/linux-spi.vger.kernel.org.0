Return-Path: <linux-spi+bounces-4067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A714493FD24
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C58B210FF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDD158DC6;
	Mon, 29 Jul 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL4SJ593"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA21E86F
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276645; cv=none; b=PAPse0xuH3/MQIr+2SopzLkLahNqy1795KIOC04KFFIFZckEnuyjjX/vTD2g7fHdITQHMP3ZhMrJMPOBww1DLhhNrmr7jhIkD6U5XHw913XSrgVRaJAt1GzhaGXcvPO3PJ3B/gimta+SI70vFJQA2TkiF1ErbxJyHFB1DkFnREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276645; c=relaxed/simple;
	bh=oBRggaPk4K9NyD5i7PSLvxP5R9QmMDXPmCsQOqRu0Rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PRQuin0/QMCq/DpUot+eI1FgRwD8ZK8xUch14E7jmXm8MNZD10T7/Bosrf2KXTtURI8XrkJXK/MhS4o6JnaCqdltL52hxio0UG7fFNs3r5/lSEMe7nW1WVBEzXl5y5Wr0ebSK1rsCHXa2cxI2HqyzExI2/lGdCHh8bDg708GGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL4SJ593; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 566D5C32786;
	Mon, 29 Jul 2024 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722276645;
	bh=oBRggaPk4K9NyD5i7PSLvxP5R9QmMDXPmCsQOqRu0Rc=;
	h=Subject:From:Date:To:From;
	b=OL4SJ593jKpnss4zQ9Lp/Qv3LHiAS6w0CsquhvQPGnnDExmZ36XiwDoFcd6NaTeth
	 sPfbl9K5oGRu3s3+PyALfYnajuLEIAdkxe3zhJROslXR9XZqG+Q4ZgCXcHAwWlEfPg
	 PpXzyy/BYJqpalHFg0YYW1ygmiv8OtsxNU8wYGoSfCL+Erhe3XB1djg4qmmXv6tYmB
	 Mu9Ss33XvtvW5HChoVUxn2vVDYqK464dErvtSwzcO3dG1hOP0Bul1mfnRXDHHr48WT
	 Qfva4dMB0f8ZzRbujnlXM54m0D1tvHHSA1jMG5LQRrU9e11ng4bAlLx9a4b/sX2J51
	 ENYznV56TGxxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E3F6C43443;
	Mon, 29 Jul 2024 18:10:45 +0000 (UTC)
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
 <172227664519.2181.17329330086966726347.git-patchwork-summary@kernel.org>
Date: Mon, 29 Jul 2024 18:10:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Marvell HW overlay support for Cadence xSPI
  Submitter: Witold Sadowski <wsadowski@marvell.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=873580
  Lore link: https://lore.kernel.org/r/20240724154739.582367-1-wsadowski@marvell.com
    Patches: [v11,1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
             [v11,2/9] spi: cadence: Add static PHY configuration in Marvell overlay
             [v11,3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
             [v11,4/9] spi: cadence: Add Marvell SDMA operations
             [v11,5/9] spi: cadence: Add Marvell xSPI interrupt changes
             [v11,6/9] spi: cadence: Add Marvell xfer operation support
             [v11,7/9] spi: cadence: Change resource mapping
             [v11,8/9] spi: cadence: Change cs property reading.
             [v11,9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI

Series: Add support for AD4000 series of ADCs
  Submitter: Marcelo Schmitt <marcelo.schmitt@analog.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=870940
  Lore link: https://lore.kernel.org/r/cover.1720810545.git.marcelo.schmitt@analog.com
    Patches: [v7,1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
             [v7,2/7] spi: bitbang: Implement support for MOSI idle state configuration
             [v7,3/7] spi: spi-gpio: Add support for MOSI idle state configuration
             [v7,4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
             [v7,5/7] dt-bindings: iio: adc: Add AD4000


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



