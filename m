Return-Path: <linux-spi+bounces-5609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9B9BB739
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 15:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC371F22C4B
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827C69959;
	Mon,  4 Nov 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMfLPgGP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64754502B
	for <linux-spi@vger.kernel.org>; Mon,  4 Nov 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729421; cv=none; b=OCWO7CDk82/xYRhQWg7DcFjqNuGMlA330lJXFyt18wdMc3X5RHAbxY+FSIXMXjU97srPPUO0ffddzOkorZeqiF2ByroK6N0NThRpD4pEZA9ZdGDb846fB6rql221bxqEwphAJI8PTROx9TQCEwGd9Sx8WpqDCvCCsIwj0lgIXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729421; c=relaxed/simple;
	bh=cgmowa4R1CjQCpue1xwJ9L4ouyXAANKkWGbAIsl/Fak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IdaOK8EH38g/vJP77NdkpqBrDWSHWV1B2SY7IKMX5NUhk0f3oIggzaT2X6EAQGWIvu63+YgZ168A/E+HUYXULAKZcxq3MV9HkSoksXB1zTX7ShsWP831PErdzKkWWrL0+fRSwPX7thSgiU/rHJqcLs7s+lwPA8zRKfdhLXxMT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMfLPgGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B084C4CED1;
	Mon,  4 Nov 2024 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729420;
	bh=cgmowa4R1CjQCpue1xwJ9L4ouyXAANKkWGbAIsl/Fak=;
	h=Subject:From:Date:To:From;
	b=WMfLPgGPxZJzs+Y8wooruOjZnDYW6bw3qXoIkGy5dQ1IrSkhKqovU4woNidjCYxIK
	 tIVHPTtrU90CjdTbRdvabV7yWdlXfX/TXIOFGRox7xBKHbbkwif5hfieUKkZiaXEgj
	 By5hxfB754lbBXenqqFeA0/rfoa9jzxV65pmgLad0MYNF2KH2sGnFbzpQIrVIVhtRa
	 qhciIFJffzDFgR9R5xkYK7ncOdcBC3HokgTcTSN+2FRwbGRcA0O4pEHuIVFGIAjF17
	 UumOl6gDqbVsCUBDqLGcd5VG0/Ub1aAJ/EDbZUz6hdmtwTbtBVRmGUq58o0h5rSmQs
	 4ANA7Ju1XWHeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3760B3805CC0;
	Mon,  4 Nov 2024 14:10:30 +0000 (UTC)
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
 <173072942882.4087814.8417602018286776109.git-patchwork-summary@kernel.org>
Date: Mon, 04 Nov 2024 14:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891639
  Lore link: https://lore.kernel.org/r/20240920091135.2741574-1-ruanjinjie@huawei.com

Patch: [v2] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
  Submitter: Chris Packham <chris.packham@alliedtelesis.co.nz>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=904804
  Lore link: https://lore.kernel.org/r/20241030194920.3202282-1-chris.packham@alliedtelesis.co.nz

Patch: spi: tegra210-quad: Avoid shift-out-of-bounds
  Submitter: Breno Leitao <leitao@debian.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=895564
  Lore link: https://lore.kernel.org/r/20241004125400.1791089-1-leitao@debian.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



