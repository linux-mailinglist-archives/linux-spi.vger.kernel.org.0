Return-Path: <linux-spi+bounces-9886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84225B42AEC
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 22:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F913AAD82
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EE30ACFE;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TktU3t78"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223C2FDC27
	for <linux-spi@vger.kernel.org>; Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931402; cv=none; b=Nsl6kHKxBrXNAg1jaG4tkqH44a7VVtTw9WGw3WnO4zFSbilOw5vrRqMDzS/z97dc1m/TYPA/xszSLJRxwKH2mJlUoTqP34DnqYIbpOnvMh5WauLCDijAy1DJfwo5PDH3EB1uZwSawGE5PD9jhbTyvwTAATZ5gA1vrNHDXUeyO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931402; c=relaxed/simple;
	bh=KOc/+rGZuyXKd9JgYsLoMhK/so7b/FqdEJkCZq+ZUpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cfx80mDqMlZMpnFRRfuWdc33f6SOaz4EQ2qokeeDneFVNWme3W/zKavNKdcGKb42GP7bwLzBtdwwKEnNgNJnJH8I6wlAuHDLBNsI61AnsrCkNVYim/BeONR6Vs+Uq3chzia2Q/sZT9WAiMmPqG1/zBhrT64hXXMRhiL/8Xs0fSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TktU3t78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3634DC4CEFC;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931402;
	bh=KOc/+rGZuyXKd9JgYsLoMhK/so7b/FqdEJkCZq+ZUpo=;
	h=Subject:From:Date:To:From;
	b=TktU3t780qrgfma5nVj11QETIZ4AqXDzhVnc6hpibf+Jpow+QNYlyeam4b60LiTw0
	 HQ5urBEIg5CJzu3pJtSgs/zMPAiqQyNOOcXoX0Ss1LOQLGry38+0EzpiyQLIVlYrjV
	 AKuGmqts01YT0j0AXmffOvW76sf9k8hx0RbDoMdQYsxDuNk8xyEcmymerQuKJXCZD6
	 SfQoq3ObRnrOMddSZRTImSv/Vc0QYTYL9zaIKPmX+m2fXjDBMd/4eTHh3Npty/pomn
	 9OFiY3e7QdKXuZoeFiw096PqlaXGEpgu3glruwCxBKtRXytBW4M0InOz1gETgY9Yje
	 F/TnuAbzX3XSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38925383C259;
	Wed,  3 Sep 2025 20:30:08 +0000 (UTC)
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
 <175693140679.1190499.10615587080714339716.git-patchwork-summary@kernel.org>
Date: Wed, 03 Sep 2025 20:30:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-dspi: Target mode improvements
  Submitter: James Clark <james.clark@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=997997
  Lore link: https://lore.kernel.org/r/20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org
    Patches: [v6,1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
             [v6,2/7] spi: fsl-dspi: Store status directly in cur_msg->status
             [v6,3/7] spi: spi-fsl-dspi: Stub out DMA functions
             [v6,4/7] spi: spi-fsl-dspi: Use non-coherent memory for DMA
             [v6,5/7] spi: spi-fsl-dspi: Use whole page for DMA buffers
             [v6,6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer size
             [v6,7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors

Patch: spi: spi-qpic-snand: unregister ECC engine on probe error and device remove
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=998389
  Lore link: https://lore.kernel.org/r/20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



