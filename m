Return-Path: <linux-spi+bounces-8126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB5AB7F01
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458753AAEAA
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9151A275;
	Thu, 15 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0qVHcbY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEF2222CB
	for <linux-spi@vger.kernel.org>; Thu, 15 May 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294794; cv=none; b=g90n7iuOkqJyxfDwc6ApXT4Lj6pfooOvqCPdRtENK/MHWZfRm3ID23iozkiYWnUKrFBt17c7yQ7qaeyudFDZ6/7iYkTXTNl4jf/bV4lLQK3MdPEFzoSiu6jaBieKpvuFHdwsviXVbOpQRDQaDEWOSGLlMlrBmSkd7DlrxoPfDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294794; c=relaxed/simple;
	bh=urwbFeZhlz/ae3+ciLOYEeWWHyO6tazZ6qDcXR2HQQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TrPwd1shM3RMSADJFQV5YYr5TVXuch/zaqduT+67ywmYc1AoKkKHsdQHb3NhZQNh5Aj9afEtqTomcjMavBF+1cxPpOLzq8pao3xyYBUBfCCGtZNXthtKD5Z2pu5hyJ2Wh10oqQCWHBIBs5Zp7O8ux2UUmOF9cP6/3a+ADy4m/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0qVHcbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF3C4CEE7;
	Thu, 15 May 2025 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294793;
	bh=urwbFeZhlz/ae3+ciLOYEeWWHyO6tazZ6qDcXR2HQQI=;
	h=Subject:From:Date:To:From;
	b=U0qVHcbYcBDmmuezMbUh0w3Y4EFRn386Tuz7t2+YDuLQ1D9o6vcOL5yOPndCkjKt/
	 H87GkGIQRxyjEQYxJqVAB0amAVRoen0Qb9fpm4ToGn5+eX5FRATgf151NkpWx/yByi
	 BRG6W+wRlQwN5z4RBtsoeYks2RRbkhFndu4P+tWn+k3xz14kz4vBoXaXMmEY8M1BAu
	 8ExGBOpRJZ4SJUqbUJALSRL1IJtUIWPjpUkZtJSPnXtcxfLin154CotdHtcN3RuGJ+
	 pBehLfxKwP9wACqlyhKbd7t5wN1Eivndl1Kh+Hg6ueBg9VpzayTbpUMJ2OIGOL4zdS
	 NflEgf+loOZdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B191D380AAFA;
	Thu, 15 May 2025 07:40:31 +0000 (UTC)
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
 <174729483024.2650959.14450722330283232524.git-patchwork-summary@kernel.org>
Date: Thu, 15 May 2025 07:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-sun4i: fix early activation
  Submitter: Alessandro Grassi <alessandro.grassi@mailbox.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=959018
  Lore link: https://lore.kernel.org/r/20250502095520.13825-1-alessandro.grassi@mailbox.org

Patch: [next] spi: spi-qpic-snand: validate user/chip specific ECC properties
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=958825
  Lore link: https://lore.kernel.org/r/20250501-qpic-snand-validate-ecc-v1-1-532776581a66@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



