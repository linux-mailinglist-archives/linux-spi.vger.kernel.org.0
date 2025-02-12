Return-Path: <linux-spi+bounces-6795-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E375A32F79
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 20:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD446165B7B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81425E47B;
	Wed, 12 Feb 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWtTF639"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E71D5CCC
	for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388002; cv=none; b=R4zSXtKKCaBml941koFHpcCBtTvmFfVMxoHGcvmucXqkfPlFul6sOHsNuXSmhwBzRRJMetYCyQl+nUQXQ1RBn5vKQIhQ2d4quod38fPNTDPOjx/ygQ2RDELZHfN+LX4vzSWjAVSo9UoffIGRReN7mMmdKvfZ12tILir9KgHHSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388002; c=relaxed/simple;
	bh=i4BoT8/b0toFruChS3mPwlsPY7w1RUlscOo0GQs4euI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pSUmRk5xQPYK0H+TzwWo3pGqBL6nw/uRKD4t/H/t6ISvsc+oF8DrBaT/Hjtcc7CyMERH9i4IG9DjKEme8Bujj776JmqCBssgnVVGFQowW3mU63nuMEnY/I8A+YRb+FH022s78MMDHFwN9k9o1/d/LdzZTF5nLvHeLfKq0cunfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWtTF639; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DF6C4CEDF;
	Wed, 12 Feb 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739388002;
	bh=i4BoT8/b0toFruChS3mPwlsPY7w1RUlscOo0GQs4euI=;
	h=Subject:From:Date:To:From;
	b=fWtTF639Uw/Htrxr+S0GBjEUx74gFESuln2T6xRlzfTmZQFvQfPC/7p3ggCxsobHz
	 E35SQ95+LMte5I8Q6NtHO9ARJgrJk7+RFFU2BeRJACM0C2BWKGIlpEzQGuz/u73rWF
	 o4jKeu+ed/VLujmMAxf60sMUzUh1xsNqtCx9A8z8GOEcPIt/3KyNJuR2sxAl8BIAml
	 tbN88x6r8qgj2whVLVOoY2PmtcVEuVtK/Id/fif0uymX1pz6dy1SfDnwp8Jo6z3efq
	 9OBW8XX5+vKqLH8cauyxrzO26VoZpEVwl2cU+HH+1w0SeqwJmfOuUT5ywCX8CK4qCQ
	 9/VViaR7hcQLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA37A380CED8;
	Wed, 12 Feb 2025 19:20:32 +0000 (UTC)
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
 <173938803121.632131.14968673393288505076.git-patchwork-summary@kernel.org>
Date: Wed, 12 Feb 2025 19:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: offload: fixes
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=933292
  Lore link: https://lore.kernel.org/r/20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com
    Patches: [1/2] spi: fix missing offload_flags doc
             [2/2] spi: offload: fix use after free


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



