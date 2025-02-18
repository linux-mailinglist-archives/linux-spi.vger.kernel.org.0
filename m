Return-Path: <linux-spi+bounces-6866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247AFA3AB3A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 22:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F3A173F9B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FDC1C07E6;
	Tue, 18 Feb 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUzSsP28"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612814BF8F
	for <linux-spi@vger.kernel.org>; Tue, 18 Feb 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914805; cv=none; b=JFbxGr4wB+w5+Y1e8YAuZBylOFUoSmo2yf8Oakdi4DXPRyDMHNEZ7Tbuzs1FITwurjF+Aj5NiXCxKh5jLH4cR4OjRYKXB5fHgBRcW+q2ZKR5lVoRsDsdFktRN9Huc+YQeJsOyUraFJ/cbBF2/94F4OYlAby3yGkAYpc0cI/JiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914805; c=relaxed/simple;
	bh=jbkN1Rvee99Fk4Yh5FBPTkeKszUbqeXlx00qnjuTtoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XsjRhVVS3vl45F1A833va+vYRq96DiX3Odg3i7GBkIr6Gr1LJCRZf5uLnUYpxK02dSoItUb11Nn4PHcnQyF1LJj8rnVHOO4RIKXRjRnoHJlV6NFXpTYjqyqI0kpBEI4yHzi+bO+883rBSNU6J1A3dFbx5AODWEy4GzoCGG7hu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUzSsP28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6916C4CEE2;
	Tue, 18 Feb 2025 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914804;
	bh=jbkN1Rvee99Fk4Yh5FBPTkeKszUbqeXlx00qnjuTtoM=;
	h=Subject:From:Date:To:From;
	b=BUzSsP28tg4mtXt/+y+9HbDk0nxxoZ2uD5PxM8baFx4z8znJjvATF6T5G/nWVl0Iv
	 rkOUBf9TKd8YpUswcwEMPXc0rZGEeIqyVdhHn2mbCinHarwGqfIreYJy13nGpgVNZY
	 AJmXNJxnmtdF8kmfOse+CCsDsXdmNzLvrJhPmB7PoPh7+PElMiygoF2XrJa7E2X/tq
	 S1PbUrVuGj3Jft6IWzKy/hC8NtGXYyj+CSQNr/9DnWytByjmdAOX3P1vXhnAW6r3gp
	 FjuTGE23+m0bAhgKsrPznsArYFdpIXqqHIk8B4avb6JXyoJZtyyBzlfVf33nozk5MX
	 mvMv5i0OdhpGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB14380AAE9;
	Tue, 18 Feb 2025 21:40:36 +0000 (UTC)
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
 <173991483465.39887.12052801662297951026.git-patchwork-summary@kernel.org>
Date: Tue, 18 Feb 2025 21:40:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: adjust the file entry in SPI OFFLOAD
  Submitter: Lukas Bulwahn <lbulwahn@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=934599
  Lore link: https://lore.kernel.org/r/20250217092851.17619-1-lukas.bulwahn@redhat.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



