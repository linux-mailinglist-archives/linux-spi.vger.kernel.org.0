Return-Path: <linux-spi+bounces-9968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70114B514A0
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338677A2897
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690C265609;
	Wed, 10 Sep 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpdbC4dC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247318FC97
	for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501823; cv=none; b=ddrGAR9V43uUt3GzETzIx2uzwhUbuwauYOgsYE89yQFLmGA10s89mlyPBoiQy1aH4gWky1jKeiQPL+lILztcKyCvMsASTeNactpZjATXnnamZrkkoqFrX4D8DP5MeEGljAiyo0Zl3E1ZjImQMPGCGTHAjfMnyXS+qt+zIa2lBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501823; c=relaxed/simple;
	bh=f1vF24dCzKA986sBwlZ0UWopEv5TbZq/yUu7VghPUTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=a11CsbIwYa5KhzmjUw2uZqLj04zk4O2Ol2z0hp4m930u09ys5jYX87fbDTTwrx3ay76Os0LgK3jfmUhg2iPcNblzIpT+qX6NjTjsuDS0fKp0VkIdE9+BZR+GdMnBscGtY+z52d+ZVlAz/qkFO5sPNyPuPIxpQf39Fpdf4POGMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpdbC4dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467A8C4CEF0;
	Wed, 10 Sep 2025 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757501823;
	bh=f1vF24dCzKA986sBwlZ0UWopEv5TbZq/yUu7VghPUTM=;
	h=Subject:From:Date:To:From;
	b=KpdbC4dCKWtRStwAMZ5tIZLEr07dGyiMkBGRLZ/RhYkpmbL4MuVOJgJPSi+wTUH3w
	 4Y/KH5B56mLy6o/A09ByT/hEFp1MdC916lBhtnmY4QIUxZhDxncLAAhue5RNB6UUxE
	 7zs5fbBvQlC7x43LbH7HhADOtukm12XFm9LGSesGArvLKXSDniqdr5rIC0JWOwVXOR
	 k2idcE7L17JJG8wks72va3uO1sfRNt0etPnXP8yQBH/PRgggjYsCaWDzsQu/2FP6cE
	 QIapBbygZ//KmNQYYO9XjjHHaq1JTMwIA/Qt0IcJ98IbNz5I7Jkl0TzeSAWA6FK+aP
	 4uXmmqEt8CZAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC3383BF69;
	Wed, 10 Sep 2025 10:57:07 +0000 (UTC)
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
 <175750182594.1377100.15414137615213823657.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Sep 2025 10:57:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] support for Amlogic SPI Flash Controller IP (2025-09-10T10:18:24)
  Superseding: [v5] support for Amlogic SPI Flash Controller IP (2025-09-09T05:13:25):
    [v5,1/3] spi: dt-bindings: add Amlogic A113L2 SFC
    [v5,2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
    [v5,3/3] MAINTAINERS: Add an entry for Amlogic spifc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


