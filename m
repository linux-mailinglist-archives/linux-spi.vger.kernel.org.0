Return-Path: <linux-spi+bounces-5994-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865799EB1AC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5991B16681A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED81A7046;
	Tue, 10 Dec 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLumOamS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2378F44
	for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836212; cv=none; b=pqped9v99YT7K1+uAAaSeLpH8Ib7lrB/wGmqMwFaXJqjj81Yq8qaGSEygJmWKqA3TrrO7cHzwVdc7MWh+ugQuDlMsqchTF9/bO+gFvALhp4k4VPa+qUr5DOskQPcOGatxLJw+477KVngyyA/BFYX4UKmXmS4T7KlxwwYUe58nLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836212; c=relaxed/simple;
	bh=ZpEZwisYTdSbfWrJ6Flk8WcjaOXsyaH2IF5X97R6ef0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OBS1jreUceaiuko/d4veBtaotUkw/F9Dmz7zc2Lhhb09hHxLRfkyM1bKM8zt3Jtrff9U6h3QmqFJXXWEH0oAyXFmOsd2Mp4aH0uKbKkeoP0xEtCDCcuJk37vlr/TFt+jTGIwvIORFRjc436IH+eBatK4aFJvvie51B9NS9t/QvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLumOamS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E0C4CEDF;
	Tue, 10 Dec 2024 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733836212;
	bh=ZpEZwisYTdSbfWrJ6Flk8WcjaOXsyaH2IF5X97R6ef0=;
	h=Subject:From:Date:To:From;
	b=FLumOamSR6kVYeM8MDeE8FBqI00o2ZtBjj1v5BUW06INmfd9mh2Cb4YQ8ZDvwlo1b
	 Z7Rpd0SQld0/9xg6eH5tTGjfYcC/xwJGw+Mt9lb1ZY0HYr6bN6lW6VjFiI3NqYLggc
	 FiOpcxF5PDFpp3F0PonwtO8aWugH2iSO5/giwpFOdNs59ui9DljBgXdysN3b8u+HXc
	 TzD74rzwqRks+iztyXEHnxob1IlamNnX923XaUscGIwJ5x9Ekpli9vuMt/7ghI+7rO
	 tFi5Yh8dBN+BFRUZGu1LBFdN/vgku8jUA7GAbZUZ6TEG65aM41/TJVZFfacCV3Zl8Q
	 3qf4sRtJBIfng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFF6F380A95E;
	Tue, 10 Dec 2024 13:10:28 +0000 (UTC)
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
 <173383622764.803719.3331359822493441171.git-patchwork-summary@kernel.org>
Date: Tue, 10 Dec 2024 13:10:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.
  Submitter: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=914427
  Lore link: https://lore.kernel.org/r/20241204063338.296959-1-niravkumar.l.rabara@intel.com

Patch: [v2] spi: zynq-qspi: Add check for clk_enable()
  Submitter: Mingwei Zheng <zmw12306@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=915569
  Lore link: https://lore.kernel.org/r/20241207015206.3689364-1-zmw12306@gmail.com

Patch: spi: rockchip: Fix PM runtime count on no-op cs
  Submitter: Christian Loehle <christian.loehle@arm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=915485
  Lore link: https://lore.kernel.org/r/1f2b3af4-2b7a-4ac8-ab95-c80120ebf44c@arm.com

Patch: spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911089
  Lore link: https://lore.kernel.org/r/4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



