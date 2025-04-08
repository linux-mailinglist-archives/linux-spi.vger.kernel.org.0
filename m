Return-Path: <linux-spi+bounces-7463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF15A81322
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB81B1BA0458
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C96A1B422A;
	Tue,  8 Apr 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyvxmfD5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0222F38B
	for <linux-spi@vger.kernel.org>; Tue,  8 Apr 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131594; cv=none; b=ngGoAriy/+L0uCRAFahfNqNz116ro90eqHMJ29lDYcu2XVtuxNhODY6XnVNZQm7ekQnOZuAQPKovNGxvnugIDMmvhaiXH1UUbFbcWz9AZWDD2BfBIMA3EzcdGdjURPtp4E51HDw4R5q2LENXWmIt3Gm3+aUvTca//Ny4v2QygmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131594; c=relaxed/simple;
	bh=XIkZeHAmM1C63FZ8jCxM3hMkt1Yh4PUpcMXFE1rKzDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rBr4U25Fstnx1qK+A8zEq/o8WQBmENlmXeiyiv+22s5u/l+XNE3ab8/PT+lOj9q2S37lpZHoT028wPsjhqRrZMUUldld8CbXyPewBefo3fJkBZcJssvKWvV11itKKn7jFIIKdDaqxIW33aOqn3aNXZhiEwvNE9a5ZpsogYBBIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyvxmfD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B01C4CEF0;
	Tue,  8 Apr 2025 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744131593;
	bh=XIkZeHAmM1C63FZ8jCxM3hMkt1Yh4PUpcMXFE1rKzDk=;
	h=Subject:From:Date:To:From;
	b=SyvxmfD5HbOXeKhFj6cNWQ3myTXJiDMqB7IWqd/EswdjP5zxPHWtucmkqsF2UcO18
	 vDRJtPN6Xm0UKDKPH3kS61hnqXdnDi3tEymElhTEjADY+jNtzEr+UHv7h87fevLBrA
	 EhAohKMtLpA5Jjvs6hWo5AoNq72lrMXbpRZTVq0Ocb9b1UOb84omIwFqmAyEkIMMI3
	 c4o0bwmB21Es9sgQdeApNc4XLFOc6pCoSuCgP1pg98q9/3Htk1aIW6wDak3yihOzG2
	 TIUto00xUv25EppqQaA7jpEj+Q8nIeq4c/JCHMnxIZw94zSXmx9AMY/ABKFSpxOYBD
	 gES5xtY9O1TUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3904738111D4;
	Tue,  8 Apr 2025 17:00:32 +0000 (UTC)
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
 <174413163097.2059534.4323521450349967121.git-patchwork-summary@kernel.org>
Date: Tue, 08 Apr 2025 17:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-stm32-ospi: dt-bindings fixes
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=946737
  Lore link: https://lore.kernel.org/r/20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com
    Patches: [v2,1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
             [v2,2/2] spi: spi-stm32-ospi: Make "resets" a required property


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



