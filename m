Return-Path: <linux-spi+bounces-9384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347AB24C79
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3521888F78
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF71DF71;
	Wed, 13 Aug 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2LyNMx9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AB1EDA2A
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096594; cv=none; b=PBzSh+sThF//qh/0Yc0y8qVxwNc4WNl9bLYEHNGrfmHS7BDZFA0GYTvmhhEy6rO8Xjmc91DM+YK5uDGSwEX0N/7JnC2s3t19L7alEDS6gPDOOJLEDp7uvaTJK0yQ8IAA6Rm/iGkhF/ogJWj53EwPp0fpCGAVkKD5/Kox8RX6Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096594; c=relaxed/simple;
	bh=eSD0l0Vk5f9nTMiWCX5uHh8k4n7K4bjgPxe23iXt+jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NXMA9k9Jfbkz/68Zqb+ui7bOcPnTp3u5vv70m5BjiaraNw0u2B3gPLSfUHl5NsvNkaJfq/vtiL7RZ40I1LJ1FMeflsVU5lAuSwsdm19jQge7VVvP4VqgmqEeF22uEjDOFagG81b+bxeGg0WkAC4mdUA4dfsdE6E4YDnHe7c5iq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2LyNMx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E7C4CEEB;
	Wed, 13 Aug 2025 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096593;
	bh=eSD0l0Vk5f9nTMiWCX5uHh8k4n7K4bjgPxe23iXt+jU=;
	h=Subject:From:Date:To:From;
	b=l2LyNMx9RsUNraqFtH9yccaP0MwEW/vqg3F+scrUiDBX8rufUKSw0lG2LqgyomrpC
	 VlHQZxlVpRgV61wHu3qwx4suOklauLqHqHTCJHd15c1tymLOXlK7gyBilxohXoAQm8
	 2dj2ShB0N+ApeCwmaKj5XwaItTC0sVEQ6qP72QZiW0N5LwvTE7lGU9Fp8TJ1ox152v
	 cOTe35NlgpcVMSVH2EU/vA8WHU9LUb7a0VNJ/cafs+pKBs9S1v7DjavgGkbxuRtIHu
	 2mLr12fpZ0KJsR2qHq9nHRNbj35dmwKHah+Uqp9EzNNoFbT7xxsG1eR3E+7d8wCXpd
	 BP9m28cSgZqqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7479439D0C33;
	Wed, 13 Aug 2025 14:50:06 +0000 (UTC)
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
 <175509660509.3616213.10706170207347156983.git-patchwork-summary@kernel.org>
Date: Wed, 13 Aug 2025 14:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: handle 'use_ecc' parameter of qcom_spi_config_cw_read()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989482
  Lore link: https://lore.kernel.org/r/20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



