Return-Path: <linux-spi+bounces-11069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC8C3A011
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 11:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 019034E3CA5
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD02D9EEF;
	Thu,  6 Nov 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opD3wA1d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906A2BCF4C
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423053; cv=none; b=RGvIztyUcRRoEV0LJMD6NiD2heACA3gYXlxT2FUnlZGk6OwnLscsmGnZDIx0fSl1blqrnzL2w/tSZwlShYbT02UEqAOunqHEUmasZHoSrFM7lRZJQEYuQBROe6f93X/XT4MUlJ9APQifuow4V/cS51EkkpRgjy4XWDPPrC5qqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423053; c=relaxed/simple;
	bh=oOYlfpUpBICZzRtVPYOImtfhGgn27liTggfSNzaqsXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UuyThN7qwOCcFViICg7EtCw13DSpvksGRWC2t6wWHGwS0gnLLJtCNIXNR1C9qLQR1pzFRcuXGQt6x9nq/M1S0jzuiqxrzgZk+zTMKZ3svUcGUrhiFcySv9Kqk1t1Eg9byk0Ob1sXQRcbt7b6X5B6Iv7VZYN3pC2TFZL8LVxZw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opD3wA1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3F2C4CEFB;
	Thu,  6 Nov 2025 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762423051;
	bh=oOYlfpUpBICZzRtVPYOImtfhGgn27liTggfSNzaqsXY=;
	h=Subject:From:Date:To:From;
	b=opD3wA1dvipjrD76eF7SW8BlmMTjvvlTU90pzh6lBZRGTbdcHtr1q7AMiLkA/o1IM
	 zFzfnCDE7OvUby73D/tNyn1KHDeVcwgCj4TPZNFXLcfI5dBHP2CGT960rrEDeo7huz
	 HdcMVBIjWfC0cKkfdVKxNiHR4B6RPnRShmkbEyAeEmHPYrUetgiIWnBTEA8De2eeop
	 ofwSGfKSuWTgiWci7Uy8XmaGfkoY3+njCh6+fPENBx4Bszjrisr816MPV8H27A2jZf
	 2L3azIxfMEaPGLUpFeVsvj0NMNIsCJYrH0i8vVz73TXBsmlLNxqHVMr1Zq/5yuhITL
	 UrAb0Nbx8ulww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB7380CEE7;
	Thu,  6 Nov 2025 09:57:05 +0000 (UTC)
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
 <176242302458.129656.1554394857063897387.git-patchwork-housekeeping@kernel.org>
Date: Thu, 06 Nov 2025 09:57:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory (2025-11-06T09:19:03)
  Superseding: [v1] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory (2025-11-05T08:49:52):
    spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


