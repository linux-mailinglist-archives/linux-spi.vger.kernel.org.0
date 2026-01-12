Return-Path: <linux-spi+bounces-12325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C450DD15589
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F62530155E3
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3F340D98;
	Mon, 12 Jan 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN7qw+55"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F13D51E
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251608; cv=none; b=T0d1SWkhOYA1BTUSJi8MOVMhbj/dn0DY7HaChJWpcEnD3GeVCBc2O2wLmGaIRG6X+FVi0RFBULbGe/eczuevuYROSMRKYYAdJn5oYfV7CXBEGZB5a9y+W3mrDGLQZmyNjFSD+QLS2s9J+SCf5Ef8DlJMJ7jf/RwmFdUwyKOrNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251608; c=relaxed/simple;
	bh=lCmveICjGKHhW2fNhhNPwHrduZ+0e50AJ5bnT8fnwMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=folIIjKLLg6byd4tBb6Nz+mYhCznHnFMnEi3BSV1tfgmv/bamtvPy69kNKXVlHph0ywJDun6dI0LU1FtMuVo6kIhzNlG1Yj/JFPQcEfql4hIXYwNWAtyBwd1MRctaBVGwSzR67t58o7dckeaQb4WCvo9aE8KyxN1R4N7MgZoVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN7qw+55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A919C116D0;
	Mon, 12 Jan 2026 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251607;
	bh=lCmveICjGKHhW2fNhhNPwHrduZ+0e50AJ5bnT8fnwMY=;
	h=Subject:From:Date:To:From;
	b=XN7qw+55gkBsdd7YnIS+28lfiDpgYCvnhV270nfkpHNm0eLBna2sipeEpl0bCvkUu
	 SzugEMYsAA3v/MqEbmrW0mBHx9rfki6WXzksXsDPZqNLkSBYecCN34RoYmEf/+Q9EU
	 gA0mhZahbGegcWoqoTTa2z/mo4N31qqzwLRVW6s9/Hrm5VOdcAXwvtFvuwnY8FA9gF
	 514u1zYf1DIqlhesTSogq6vJkv8W1pGAszMcRgOG1bfK5YgQb43sQUzM/HXx1i3aZ6
	 ztQeUAbDJPDMFFJS4sHpcFOClchfQ1FkU9u7X+0HL3oc/5Qj5/ZK9AteoXEwm8Lz0A
	 hCPwp8jpwU+uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C22D380CFD5;
	Mon, 12 Jan 2026 20:56:42 +0000 (UTC)
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
 <176825140077.1540314.2980669158413157044.git-patchwork-housekeeping@kernel.org>
Date: Mon, 12 Jan 2026 20:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Make SPI core to take care of fwnode assignment (2026-01-12T20:21:22)
  Superseding: [v1] spi: Make SPI core to take care of fwnode assignment (2026-01-08T20:23:37):
    [v1,1/4] spi: Propagate default fwnode to the SPI controller device
    [v1,2/4] spi: Drop duplicate of_node assignment
    [v1,3/4] spi: Drop duplicate fwnode assignment
    [v1,4/4] spi: Drop duplicate device_set_node() call


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


