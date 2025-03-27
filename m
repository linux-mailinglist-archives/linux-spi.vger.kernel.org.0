Return-Path: <linux-spi+bounces-7354-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F3A73FD5
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB431B63B6B
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEA11C5D44;
	Thu, 27 Mar 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+anwWHz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D016EB7C
	for <linux-spi@vger.kernel.org>; Thu, 27 Mar 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109003; cv=none; b=Oj8uw1KSanuPhHGql24vUo1erxmWaJT0DYdRB0GkX+hmYyQBcP2tO5zMJxx1RpdUTH7zETkQ1F+3qEoMXWnEtuaTBxdu1Uwjrp934+meGHfDU1QDCaDP2KHYdqoDLgGF+BKnVw2TbBeBGk65H2YrHQr54SaODEacKh4RYzVcUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109003; c=relaxed/simple;
	bh=tjOcZ+xJxF0njxpKyNJRxf6u7jd5PBFVew/s1aqTMtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O1T3BzooAG5+V9x51g0F12Au7Rht/velUMxKJtXxaMH0qFlSHIgtVEWtQoElobJwsZxvAa51K2Tpf6djUpbC6iNyKE6CPbvdSquGm53GJmnk3BlA0ZaojXUhTxA0Hzg2Of4iFVsNmBlI1tOTxJ/VQdEm0re8eDEAUKHDoaUFdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+anwWHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A3C4CEDD;
	Thu, 27 Mar 2025 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743109003;
	bh=tjOcZ+xJxF0njxpKyNJRxf6u7jd5PBFVew/s1aqTMtE=;
	h=Subject:From:Date:To:From;
	b=t+anwWHzN9ySWN/q5WdZ+ZfZLspsJJZDRxKJ1rsPLclLvNYpFXK02FGXmw47+xygT
	 o27S+GE0WDTo112GfjTFXFmAhVYs63Z9l2jBVdsoZfbH9R/34Hoh/VL6heH9w9Cdi7
	 lQvWCAHqdUFRb6bhGZhS4h5htW8PwxOG/WiclXCi9gIVcCEdOnC+uubwD30AUctxLS
	 kO34bwkVWjScM9mVO1C05H5/GWF13YozVR3nsjsMBX/9owcjEXV4OUyH3eAUQ2JlNc
	 nDl1rUVwUJMQrlbUcMXOm9Ml7Ot7icLq/grRvMtzNvfyWmmflyvr3nP5TXHfQgWW+o
	 xkz5lRooxg63w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE39380AAFD;
	Thu, 27 Mar 2025 20:57:20 +0000 (UTC)
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
 <174310903946.2217446.3989736422449046866.git-patchwork-housekeeping@kernel.org>
Date: Thu, 27 Mar 2025 20:57:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c (2025-03-27T19:59:25)
  Superseding: [v5] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c (2025-03-17T09:34:43):
    [v5,1/2] pm: runtime: Add new devm functions
    [v5,2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


