Return-Path: <linux-spi+bounces-9188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F4B1222A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87223AA9C3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834123AB90;
	Fri, 25 Jul 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CprlJ8Ri"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718F3BBF2
	for <linux-spi@vger.kernel.org>; Fri, 25 Jul 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461598; cv=none; b=LE4zTD7LvA75BP287coCackNKRQZf50c+ryKZBMsfZZMbYYyEh0icunglhah09xKAo1MQBAU2/yAiwk/QeUMHucNrN4P5KmRwCPyYaheKuK2gzX7BXhfM+6OYpZFI0X4nEZKgAJkR3SNPOqZxX2MAH3iO71Lyeh6hmsZvXLn1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461598; c=relaxed/simple;
	bh=t36Cs2i9WYAtO1MF69l9H5lJItniT7Yvkmial9arwfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EeT3vLavIFDlg0lqfuT2mJMr4WQKinfkEmElXOQVCgHxhxULSNQ9Iw/zIUCzqQ//IKzEsXY/1NpGZAfmjwdHs5zQXK+ipSiB1iirUNiFPkaogQL+MmxEIJtwAtp/Wyxri3WsofrSotjdhmXgCW51rgVMCCOHmfkp9pwV/OOE3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CprlJ8Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8067BC4CEE7;
	Fri, 25 Jul 2025 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753461597;
	bh=t36Cs2i9WYAtO1MF69l9H5lJItniT7Yvkmial9arwfk=;
	h=Subject:From:Date:To:From;
	b=CprlJ8RicLT2O/vvr196Wobemt+duYDscOWa7gBbQYXEURPcw4MNgdHYsq6EMh7U+
	 oOhfJSy7jD3ZWPVtAyYB6Ioq96OwKG0nnrMrt+OQ/qZPSldzM3/1pA1y1BMbynsbPb
	 nwG1dQ+cfCWbs6KRmO6aeVTvkIvSPaUgfT7ufEClm/P7uDmNWOT44kO5RpfOErfWFT
	 3eevAVIp9wHJ7oV4I2oUa2kkv/bw5FZWBFxTt5p6ZXrPqiZX1eU2aPA+0cNkc9Ot6t
	 NISCXepIXSN/tQOhwcnQeYr7vpJYFclCqPPWrIJXY5ky3FdjbODIDu3rcltjQK/UIG
	 Wd5vd2cowt8hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37561383BF5B;
	Fri, 25 Jul 2025 16:40:16 +0000 (UTC)
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
 <175346161464.3195355.10108290030929848752.git-patchwork-summary@kernel.org>
Date: Fri, 25 Jul 2025 16:40:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: intel: Allow writeable MTD partition with module param
  Submitter: Jakub Czapiga <czapiga@google.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=985942
  Lore link: https://lore.kernel.org/r/20250725122542.2633334-1-czapiga@google.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



