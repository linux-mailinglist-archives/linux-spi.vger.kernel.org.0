Return-Path: <linux-spi+bounces-8276-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E9AC2B3B
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37ED7A2A48
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB8E19F12D;
	Fri, 23 May 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nggQatbY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297517482
	for <linux-spi@vger.kernel.org>; Fri, 23 May 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034594; cv=none; b=raSj2zRSDOk/Ozv/J3LbMjBwKwzkYe1tS3wSbjyyIxys6hwMXXAQKtYxixmZOx+xezYVFVF1cSsEypJBLiMie0bKlE3IdoWnHsx+y/+TUJN+P4DBg/x4e4NNs+SDKeOxRZzVtQcWRkN5227Yj1dUEjitnpAvZOB4568N89P5eIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034594; c=relaxed/simple;
	bh=LTN7xUELxq7/xK7akYkV1xRsWOMXfxRpKFP1J0H4HKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dkayfkXN043ozupvepBi7debVm7MAa9xiiaC6oK3C9NsbdBdDDv8yxLdaT2B2iYEqIZipBfu93kUYK3kcxiSNhMfG+650LVu5RDB75NQ5EGYAMh/tEyoO8+Sa9ABt45ldpVsA9/QQhpaPakZLAA5kNuNQ4TdXIGha6u3enXixgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nggQatbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA47C4CEE9;
	Fri, 23 May 2025 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748034593;
	bh=LTN7xUELxq7/xK7akYkV1xRsWOMXfxRpKFP1J0H4HKg=;
	h=Subject:From:Date:To:From;
	b=nggQatbYtj5dOR9McdyuLIZBFwD1a2nln0gD59hMmbP/JTc5u32ADUDrv+NryTAb+
	 fvr12tXSYillIJ5ikU6R7l9jLt1t3CW+RPAQEY+WzlZbMu/PaSzXY/ceS6y+NfVbnm
	 HaXMTe4OcuUut9BQoYMJvukgafbetP4EIw/JOxcpP4G/GwUUc2fpDhamdZS7JFi955
	 RWLE2CctfZTNWsG2ErlyVeuHFNfi/8zIYF2oRffGOy7HOCNqWIOy0cYU/7vKdqXOwb
	 c6do4SB/iLyE2rAIIur49YVwIxwr5GrWH9dzLYFjrJzd/5wbSu02KEu3LMcw5qPI7l
	 CMsqMzVquvC9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1BA7380DBEB;
	Fri, 23 May 2025 21:10:29 +0000 (UTC)
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
 <174803462833.3730264.3324127836503021246.git-patchwork-summary@kernel.org>
Date: Fri, 23 May 2025 21:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-qpic-snand: extend bitmasks usage
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963347
  Lore link: https://lore.kernel.org/r/20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com
    Patches: [1/2] spi: spi-qpic-snand: use CW_PER_PAGE_MASK bitmask
             [2/2] spi: spi-qpic-snand: extend FIELD_PREP() macro usage

Patch: spi: spi-qpic-snand: return early on error from qcom_spi_io_op()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963373
  Lore link: https://lore.kernel.org/r/20250515-qpic-snand-early-error-v1-1-681c87611213@gmail.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



