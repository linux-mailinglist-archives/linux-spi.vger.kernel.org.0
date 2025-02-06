Return-Path: <linux-spi+bounces-6640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF3A2A53F
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CFB16230B
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57932226531;
	Thu,  6 Feb 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqaUeq0V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7A226522
	for <linux-spi@vger.kernel.org>; Thu,  6 Feb 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835815; cv=none; b=UqAOKgdBruzZ5Uw9bv87yOUtH+JJcadMCmiv6v4Jw6Dj3JBFIciRgFUxaWiDy3NlV7FKV5raDfFsWotAbEXX8+1UToGKVO31WGKOgG+ozAELAmjSIjeYZKrbaXM0u6y9MAEVDmhEjITYd1ykwYbJHv9goc0nr6wRYzoQ5eHVTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835815; c=relaxed/simple;
	bh=Zeq0XdoQCTPx6xW1D90qkWkuX/Gw/LBIBy8xnufs2KI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ki4BNaYT3gXFizjFDO+62cSDQ04EIW829sqkEHZMyJSdInumPODZ92G4/503ZeB7d4SKXK/GLmcErMtPYCaFbijGerVMZa5jmvunM7j/JgqYCLRuDpUFGRvFfJvOeO8BxL73LLrIM7S9YURMruUlBEKctq7r/dqyacRPlclO3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqaUeq0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F9AC4CEDD;
	Thu,  6 Feb 2025 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835814;
	bh=Zeq0XdoQCTPx6xW1D90qkWkuX/Gw/LBIBy8xnufs2KI=;
	h=Subject:From:Date:To:From;
	b=CqaUeq0VqIpTqgQG7hGoiGKN9nSHJqTYJHzA/x6lQ87bYE7naZ4zDwiBYSCm51cJL
	 okqPOXJsKyY0x1qd/NV4HBUoH7kRLkKd9X5RJm3yHhwwoTM2v1s7ljkPcPco3PhMnQ
	 jQasfTcxDZAccmjCu9WU5tW9iATvYBJL4988W57GXuh5JnrYg0zJvXavMf1nutS44H
	 kL6KorCO+3EIznDvFJPgcYJ8fxInT5l3E5hDPFr+CvUjR0Zyt6ZRBKMLh2NBxPdScj
	 xQfWhWu+QstbDKPV3ZjAs8YKNMegB6vH7uf3JwLJjiM2lgowEMeSTe6z2v5ipwZBvV
	 fxJejVrBSShjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4F380AAD9;
	Thu,  6 Feb 2025 09:57:23 +0000 (UTC)
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
 <173883584208.1416072.9169668680319225063.git-patchwork-housekeeping@kernel.org>
Date: Thu, 06 Feb 2025 09:57:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: sn-f-ospi: Fix division by zero (2025-02-06T08:57:47)
  Superseding: [v1] spi: sn-f-ospi: Fix division by zero (2025-02-06T08:27:17):
    spi: sn-f-ospi: Fix division by zero


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


