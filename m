Return-Path: <linux-spi+bounces-9324-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239ABB1E9AB
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4809017115F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44EF126C03;
	Fri,  8 Aug 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvdJJex+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7A81732
	for <linux-spi@vger.kernel.org>; Fri,  8 Aug 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661394; cv=none; b=howWZQwNOCo1pZClxb3RoSndOSXlvXvMS49eyJwtdPf7bxoGDSHtm/zGAtu+cLr54ESO7ci0Qh2TAdoW27FtwqDaFmL2LzkELxqG6Na0BCYmMctiL259oWyOgHqlvfeeghpd9O4oCC4D4iBkRu+FZ//P/1nW2w1vvwA++omVZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661394; c=relaxed/simple;
	bh=fuw7OmvJIySvDDynDM7NLYqXrJaDcId2yK/z4xTkD8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tBdmSiy5aEhs/day/FrZjfFobWkBEy+Rk0OZWv8OXF8P/+qr3GQhlgpK4SBtsUDfUhMxnphed+Teo/3UKHkG2pQZWTvgYo61Y/RXnf8ahePSRVSJ1KaZOnDNCuAsw1tZ13Qy6O4li/0ZF62coAquSkUNXMFpWSGbCbdsKFH35c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvdJJex+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31021C4CEF4;
	Fri,  8 Aug 2025 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754661394;
	bh=fuw7OmvJIySvDDynDM7NLYqXrJaDcId2yK/z4xTkD8g=;
	h=Subject:From:Date:To:From;
	b=cvdJJex+MNP2xDuShAEvfzr1bm9bAKpn565OFSghHz3oTNCtsmXO87n1qMfqEKU8N
	 xkaAT7XCdMYnT8U4L9R2LH2UkXLsAIvW7rSz3ZETYk6/1QMKVkruDrjcSZkVCuv4EB
	 7lCSSZqPz028buIDqqQv5vUeIfVIScD0FqCLOo7OqNbE4OygTEdm32dNsztwbDhjBV
	 c28ckxcVBTAMFUPmc4NS/u7zFw4z9Dmyrm3mj71Prujq3lKi/YKhVqq0q2w+02fJUW
	 z+FbE9634NSs6hhpP5pLw9uxoQPGoZqFXLhxsixzp0K+eFA4+W1zkU+BZT2UjA806Z
	 aI2BCq9YybD5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD04383BF5A;
	Fri,  8 Aug 2025 13:56:48 +0000 (UTC)
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
 <175466140716.129617.7755654810577292014.git-patchwork-housekeeping@kernel.org>
Date: Fri, 08 Aug 2025 13:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe() (2025-08-08T13:15:32)
  Superseding: [v1] spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe() (2025-08-04T07:52:12):
    spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


