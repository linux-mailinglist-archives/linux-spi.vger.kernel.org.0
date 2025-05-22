Return-Path: <linux-spi+bounces-8241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA5AC0CFE
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 15:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A891BC0746
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215428AAF9;
	Thu, 22 May 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duvBQ7fm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D63010C
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921198; cv=none; b=ky2Hc9+ele0RxrU7k3PYfstSK9HiI3PFMHLovBNGlJflfMb1ub8YDo527wCJ74Ul9KV9jkr7kDorV/s5rvx3kYJee/4HzLzIKo0HNZttFcUdwBWujOeAQimfP3VkIgTfZD9WGYjzk3kdX7LEOanQ/1VKmhEe50lvOqyJbxJ7T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921198; c=relaxed/simple;
	bh=dUKBXEgj5Rk5PfCCgOCVBZq781ss/TGbHs+nNQum1E4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W42s7crU7qs704TeRrQhfjQNY6GD/YoZfY5a3TnkAedkVxCkISwe0KsiBMCrsB0HOK5KXCz3BXtkOIc0mE7EnnbHqMgS6VWz/kp3ASp79/UH/VnZjcQbrorOwGpKr+oiEIO97sWsDqEk4dxCbHYU4MvVpUPAfA8zX0fi4148IzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duvBQ7fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E100FC4CEE4;
	Thu, 22 May 2025 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921197;
	bh=dUKBXEgj5Rk5PfCCgOCVBZq781ss/TGbHs+nNQum1E4=;
	h=Subject:From:Date:To:From;
	b=duvBQ7fmw20tSBt5EZ9MBVk7Qc8XAcO3zLRF/eLVxk8SmDZnlIAo2UOvHTYixD6L5
	 mJ5TBWphjUIBELklsEMtOdLVIR6304L9nFbOM5Dgzp5CeriHiwjnqgBGFj11kMHFAm
	 fUaHQk8dhb8IRIK4fHVsbYfVD01ENlwtVz3br6BQbmrgDPm9zDhdSoeozL+/ZVqr0I
	 PKVJjXlS6Jbzll5fhgHu0thkxz6ixohUQGaWDbc1gMfQSB4SL8ez2bPhHnSzA6eoid
	 5ubgwcuahU9H2HcaCVupqs5hoJEyV0ieIDBVx8ssvABkU23QlPWGL/K1TZbfZHDy1j
	 qx8mJ9N+M0nbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 754933805D89;
	Thu, 22 May 2025 13:40:34 +0000 (UTC)
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
 <174792123311.2878676.17586111763909640855.git-patchwork-summary@kernel.org>
Date: Thu, 22 May 2025 13:40:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: loopback-test: fix up const pointer issue in rx_ranges_cmp()
  Submitter: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=965368
  Lore link: https://lore.kernel.org/r/2025052213-semifinal-sublevel-d631@gregkh

Patch: spi: gpio: fix const issue in spi_to_spi_gpio()
  Submitter: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=965366
  Lore link: https://lore.kernel.org/r/2025052225-scallion-ritzy-dbbd@gregkh


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



