Return-Path: <linux-spi+bounces-12028-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC5CD0006
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 14:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84CC30C4A3A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EEF3233F4;
	Fri, 19 Dec 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPiFh7sR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1C322B87
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149397; cv=none; b=NK1QC7Rg74Q/PrTx2AO2vC+hwxaZ1bHzuTB7z5tubn7zsZUuz1VWOtY19iZOsq40unqq++N5cV8Z/71dTEgoTlioZsqQ9qarSQIvzP09Bl3/g8EBp40wUXNiw7OC0wqIDTlYbjUyDnzO/6O6DLx3Yb4rRhHUsqA6hgb1jaivB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149397; c=relaxed/simple;
	bh=Swq9FaPwOHzXZAlXciCt3Y2d5sLvn5zi8SWgWjjDl9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SA26KDv8x/37ZWeVrnxyDr3L9wBbCzmid+wnPsmesXIzgtmrcWwdcqfqCzd70tDKuxS7u+PvqiZxYDDd15+EHK6V7Cmti+SPcU9v1uNqE34Hz6ds5LA1gzjMAtfDeGe6xNUD+AA/IRdB+usfSvTPl7Eyq6Lt09dWjMy9ne2EqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPiFh7sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9BCC4CEF1;
	Fri, 19 Dec 2025 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766149396;
	bh=Swq9FaPwOHzXZAlXciCt3Y2d5sLvn5zi8SWgWjjDl9g=;
	h=Subject:From:Date:To:From;
	b=rPiFh7sRW8I8EUF2ThuYDVtXU7hnYIA+tCj5XF8RuINIbs9Y3CPEs+pLg1wPhHXL6
	 bB7xxFED6HwoSXN1S4FYmy8TGcmC39L6f17y42EnA+SojbmfIBxaWR+cwHuSCcr6Wk
	 ZrGirZBfmjxs4nFdYg2rCLCGUYu6nYOsRCDKgKcH56qAo8ltbicECr8adRzTexBGkU
	 M4HnKL3lyFYsfq1TbKnP2jZtAUhso28A1wAz/SBMs91ugLnqVIdDHdhpRaqG0Cu27v
	 1tZD+NjHazezixOk4OrIaklZwHyG6A28d5yW+tTrynUMsr5o52U5SgYTP/nmUDVprm
	 AIk1stkme9spQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E59F380AA75;
	Fri, 19 Dec 2025 13:00:06 +0000 (UTC)
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
 <176614920507.3845255.12719435771558041113.git-patchwork-summary@kernel.org>
Date: Fri, 19 Dec 2025 13:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: stm32: stability & performance enhancements
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1034541
  Lore link: https://lore.kernel.org/r/20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com
    Patches: [v2,1/4] spi: stm32: properly fail on dma_request_chan error
             [v2,2/4] spi: stm32: fix Overrun issue at < 8bpw
             [v2,3/4] spi: stm32: perform small transfer in polling mode


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



