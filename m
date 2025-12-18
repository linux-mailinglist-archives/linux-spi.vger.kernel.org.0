Return-Path: <linux-spi+bounces-12026-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70267CCDBE9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 23:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E550302531B
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0B243376;
	Thu, 18 Dec 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua5t4Hmj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005213D539
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095198; cv=none; b=Rk81QzfzNc4kFgtXIES83yP5fzRtKaQ9aZQL8Zbl4yHUjb0wBCLRpOUD/3h+0VsFbNPt1vVhldQA4YRc4CnNc3EfzK0LED8fVvkirJExbctgFLZ7a5nXEbHw2x9R0SQECHRWGDlmKrJXkbyRFFsRN3xb496oqfQff55CcVx9HNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095198; c=relaxed/simple;
	bh=j6wtyLBEXL2MG9vSJpFeuDuWv0yWvIopp9jTj89E2ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kJJGFzFjJRinX7Hps0p+Y8JAvIogYOmIBi7qV/kNa1OIR3WAKVGJ1QsOrthUyR6J3jRiKHADnOZY537LCE/cY7Xe3n/L7GUsqhYokD8mx8b5/8sp6GrId2qJ0PVdnHLIT2StwkCtcQM7aVnbR0A6s/TqKV2iud3jX6or+BDHWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua5t4Hmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0975CC113D0;
	Thu, 18 Dec 2025 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766095198;
	bh=j6wtyLBEXL2MG9vSJpFeuDuWv0yWvIopp9jTj89E2ag=;
	h=Subject:From:Date:To:From;
	b=ua5t4HmjKyyqRwZlDUnoIBoNfGsgdenD14CeiYBOz5O2Ir8lTwn0IMlix9tYUv3FO
	 0nERIcMCJZIq4AC3vI8HX6yjmdZKXoNPJJ/GMMlIO3TxhzqvrLDWwvDf1+m/cH/uWU
	 ZPxHoZn2wKZSvyBNNMI5MNvuGwZvlAUzg8GOMNFte6YawawmYQMY98MjTYwPkuayB2
	 Jgt5UJ56pdk6AZvNj5iPkhMri6lvl7jk4DSNL6Vdyx8h6z/eHJK34cM14Vc/Lz2xDg
	 i0X2zyHOGqHhsVvzFOiPtkOy4ie19LixF/jT0NToP7lgIc9hrK0h5gDUY9nfJBh6pm
	 c5dA5adJZTnsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6C441380AA42;
	Thu, 18 Dec 2025 21:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176609500733.3147890.7678915926206611873.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Dec 2025 21:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cadence-quadspi: Prevent indirect read timeouts (2025-12-18T21:33:04)
  Superseding: [v1] spi: cadence-quadspi: Prevent indirect read timeouts (2025-12-18T10:44:32):
    [1/2] spi: cadence-quadspi: Prevent lost complete() call during indirect read
    [2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is slow


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


