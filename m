Return-Path: <linux-spi+bounces-7200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79726A677C6
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 16:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20881786A1
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511720E70B;
	Tue, 18 Mar 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0NzQfnh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D420E013
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311797; cv=none; b=Hti+CR23hsAe+T7SNvC3fW5CbvIzO3jEhyTsHRGlgzfaVfVW3gSC3VvHPTPKsXngoUPawy5P/wfAWj/5m9t5Qlqc4XghtjP3n4OoojWlivDJld5cbb2k+re07yc7tHU6SHNLDFcz5tv32oNpirXKa6l1Zl+O1wsEOTSzwxg5RXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311797; c=relaxed/simple;
	bh=ZN7CcqGTIDBAZVHxEDGWyPZBWVxXREXnW3ZBLVqvzng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C/TYCDPQjjl0ApVpC0dSOAHgDQhZ6Ag0HiGmQtsOf9EZZuPzLeAzBYqslXiyb3Wmblohy5QnOl9q5azdDtvjfGSXum3uNlKQKF+5nkKW7eAL7F5hxae5lDgG0+qcNzFCtrbc8Q7dUGLLp7ZdKJ1abT1V9EG/CqFzjyAe7Q1utfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0NzQfnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E94C4CEDD;
	Tue, 18 Mar 2025 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311797;
	bh=ZN7CcqGTIDBAZVHxEDGWyPZBWVxXREXnW3ZBLVqvzng=;
	h=Subject:From:Date:To:From;
	b=K0NzQfnhH6l8Jp3rPL6mi0+d1DhOzugXxAp6fFLUOs/z9cMt7RWEJysym5AO+DgN6
	 ybXAxWEyLjSwzkpp4jWKxGPSqyPTRRSZX/CeyfHdAvyJSNEcLLv0vWipNNpt6IAUgL
	 qzhaEfol1ediTXe25HUmJSF2dJHCC92vp8KLal018mKhpuEwaD2Aca54BLWhkVt/U5
	 tZIUAyLN4dcICvM/y3SIH1eNtp7H5OpBPweZpy62rGeuwhyjl8td0g4trtMxR4tJi3
	 Cr5MKwUIlp9V4cpYA0B7AsDb6NxnKd2s+rbKzBAzjt1RcykRxtDdHBVugkvrok6+Be
	 VaOOjwdbbsXhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772B1380DBE8;
	Tue, 18 Mar 2025 15:30:33 +0000 (UTC)
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
 <174231183208.355766.2928591729344949915.git-patchwork-summary@kernel.org>
Date: Tue, 18 Mar 2025 15:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sg2044-nor: fix a couple static checker bugs
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943914
  Lore link: https://lore.kernel.org/r/79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain
    Patches: [1/2] spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
             [2/2] spi: sg2044-nor: fix uninitialized variable in probe


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



