Return-Path: <linux-spi+bounces-10054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424FB59C3D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F5F32212E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE8340DA6;
	Tue, 16 Sep 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN2+fE+W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E630DD31
	for <linux-spi@vger.kernel.org>; Tue, 16 Sep 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037064; cv=none; b=WF/igoqqXyoi4pz8FQBNVi7cFUyQfO3lenxQT7p8Q1Cd4eDEF9tyR6ZP2MwZHHQwCM4tNfDyUx3I1m5HPOq/OFgBRlhbYyVBD20Q3VHlUaQiTMuofRiPwUJ3fk18jV1tWbkhcZ63Woyhg1jaMZ6jlJzFgP7rmfcsxKJPCf6lDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037064; c=relaxed/simple;
	bh=RC67om2MSGODY+kXZylRhOkYOgnOlrntwhv6JOWgqUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AnqUKRmHPgj+0gRYFQqEBL9SG/YNGZnWQraMJVmopxpGolw9YleKK4bKrpn/u6ZReziV3wRH99R+0/2FHEA4sY1pkmiC9WkA64Pn1U09/zvIIAQhIv5xijQZKTVZeEXP3pzDJu8/rogfGp4q/ygUaKHed6cI9MgOceObp9yXMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN2+fE+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44624C4CEEB;
	Tue, 16 Sep 2025 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037064;
	bh=RC67om2MSGODY+kXZylRhOkYOgnOlrntwhv6JOWgqUs=;
	h=Subject:From:Date:To:From;
	b=eN2+fE+WeRXiyGIDrOdYaE33f6ut5N0Fx39FH2ZsMRHf8spIesaNUwu8+XXYTwEIH
	 oQ9ce2nLZgB+IS1mHyE4zPOmuGLFARbrL/q75fqgpGnquSdczQvJ73EWue6ClqntGT
	 l/Ntu3xI844i9ADH2jQ0F1Mej4C7pIR60toZeUbaCD7Kuu+/Fm5muept4zgUK+kWFB
	 VhJVhuxZ87Ud/gti+eUeRH6OYT6w+4vuwVrL5YJ6AJToPyJZ5gbXCOWkiz+6MedcE/
	 7lAdo41OD6QGpcnq0kMK5PwGJ2uzaOzbEzo0DfF/dszCgA9Cu5plKPb3cLV4+MyEh3
	 kVNygQYRxiGzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A0439D0C1A;
	Tue, 16 Sep 2025 15:37:46 +0000 (UTC)
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
 <175803706499.1166060.2856180733588975460.git-patchwork-summary@kernel.org>
Date: Tue, 16 Sep 2025 15:37:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Miscellaneous fixes and clean-ups
  Submitter: Santhosh Kumar K <s-k6@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=999491
  Lore link: https://lore.kernel.org/r/20250905185958.3575037-1-s-k6@ti.com
    Patches: [v2,1/4] spi: cadence-quadspi: Flush posted register writes before INDAC access
             [v2,2/4] spi: cadence-quadspi: Flush posted register writes before DAC access
             [v2,3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
             [v2,4/4] spi: cadence-quadspi: Use BIT() macros where possible


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



