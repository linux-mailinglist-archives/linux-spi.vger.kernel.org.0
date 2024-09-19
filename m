Return-Path: <linux-spi+bounces-4865-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8297C607
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2021C21132
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3098198A3E;
	Thu, 19 Sep 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuCeBvfx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47B198A30
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735229; cv=none; b=neLwQfTxEHlgE7ybk6h7trpGeYPgHaSilNWQdWHkdx+cJlwL0DJQ0UKobrcaSLVU+JLyvK9wfMdtRt2MpyJs4wY6311d/djdCdAcEfPYWTxXufxG+MOIR0chDgdjrswOqQsqiL/55hCX/env+0Ln8upe7+ZgMEP5y/nIwfwsAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735229; c=relaxed/simple;
	bh=ziqOhio+Ungz35AdF0HbwACMIYzCVYFFWL5tw6SjDe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lQJCRbOVRgmJuMhL6VMzgKnQ90rdZ71m5wLoVyntkxZ+uDb/wRpbXrUcy2/NinJRY/+z46TBOxlar+x4DANgGn9wsVkhPnR9lgdfcoz0vfEjQ9RCiDNWUIZ/dHyndGH94MWbfqAFm7/pEkkZCS2LdswQTqkM0ZWqJLlNd19oGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuCeBvfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD762C4CEC6;
	Thu, 19 Sep 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735228;
	bh=ziqOhio+Ungz35AdF0HbwACMIYzCVYFFWL5tw6SjDe0=;
	h=Subject:From:Date:To:From;
	b=TuCeBvfxL1LwaZhrPDGq1/c0rnf90ra+GHXsDAx8NR6GT8YzIGdxv8gAtK77JZ/kZ
	 xAXlRL/V05fdQZEY8zlku13RZnyNEE31te9yLrUYDLiL2f5dAt7SI+KQIJVBQaPrVZ
	 1WFFVoxnva0jLgd8kZTuWIYvirVnwIhitcV15aZTqhs9XcZELnW6dwd1Su/IcXruhP
	 BN3VYUNg5nDr/M3XpDXkjwUE5pAj7NUWFv871OL0onuFsijteamPhAnryJ1q0hu78o
	 X5kV/AGE+ZTrhh09EUsZY5UcDossfD8m1wPAmmB7evsZ9GE7sHDL0ZobuULuLmM7OD
	 FoR+eo8HMu8pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B81163809A80;
	Thu, 19 Sep 2024 08:40:31 +0000 (UTC)
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
 <172673523010.1405011.2185489453170120522.git-patchwork-summary@kernel.org>
Date: Thu, 19 Sep 2024 08:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: airoha: Fix errors reported by mtd_test kernel modules
  Submitter: Lorenzo Bianconi <lorenzo@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=890282
  Lore link: https://lore.kernel.org/r/20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org
    Patches: [1/4] spi: airoha: fix dirmap_{read,write} operations
             [2/4] spi: airoha: fix airoha_snand_{write,read}_data data_len estimation


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



