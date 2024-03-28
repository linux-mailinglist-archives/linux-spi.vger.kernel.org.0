Return-Path: <linux-spi+bounces-2091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B100890DE0
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 23:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22421F231EB
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE94EB5C;
	Thu, 28 Mar 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/2ZGPVg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4F1D68F
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666595; cv=none; b=e2jToCxNs7zacnTBQtU/9v9bQhdPddtl5vO8X0cXjYLoBcC0Zu3palrR5YnIrM3hHXRMu5I663ZykinCATUAb/5OP0oG41jgv6eUl/fIiF4Uwg/1DLdSTbBl+1tYlyDcCb9x/bLR4v+Ns8z+MJWH/9FKwVyITIccfgjLQwMZ9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666595; c=relaxed/simple;
	bh=Gvy7ELMrtCGNNw1YLD1pPhs1kYXpcBZuEPDE+QhakUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QScwu7jxe1wCnSaOc5bXc6XNvRfkIaugXGBBdD5lxr8BpEtkFjIV9I14DGsQkRoLLhNnJykysUXt6h/AILAl4OEtgDAXxi9uVwwp7yo/BinHR1rdNGHIFX9nSkLDl2G/b6yKNYgo4oiaMdHQj8Ip4uxUBZ87XKo5iBeynyNe1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/2ZGPVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEF5DC433F1;
	Thu, 28 Mar 2024 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711666594;
	bh=Gvy7ELMrtCGNNw1YLD1pPhs1kYXpcBZuEPDE+QhakUk=;
	h=Subject:From:Date:To:From;
	b=O/2ZGPVgq5OXIrZ+8Q50hfcFnahyTBFxwrIowk4e5ro53OdkjT05UBGpgi8ivbGOw
	 y46whQZVh1Hs/jFzaX2DpFNWVBSbAMFDSvV3j5Zbi1FgbWEtBLc9tf9oQBCZOZB6wB
	 NZh9otHZsBcrIVbW4H4bfYLZXd2ReQfa4groeE2V+ZZETQ4J67I8PF8U312v+TDh0w
	 xJ5soGi4t2jYerp+9JMkwCdlrvDs4FGP1yAgZ4xbYW18rv/lwPWvpyu66apmLDYs1R
	 HwM83cYUfmx1A7frFFD9i7tLxrS7iQlYfWbDtFjO7giEnQ9ZV84V05Q0SaTy3Q9KA9
	 jYLnFfMDnJwqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3E7FD2D0E1;
	Thu, 28 Mar 2024 22:56:34 +0000 (UTC)
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
 <171166659466.4280.4973999635724821187.git-patchwork-housekeeping@kernel.org>
Date: Thu, 28 Mar 2024 22:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi.h: add missing kernel-doc for @last_cs_index_mask (2024-03-28T22:33:40)
  Superseding: [v1] spi: spi.h: add missing kernel-doc for @last_cs_index_mask (2024-03-28T04:38:45):
    spi: spi.h: add missing kernel-doc for @last_cs_index_mask


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


