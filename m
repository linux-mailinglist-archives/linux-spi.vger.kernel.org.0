Return-Path: <linux-spi+bounces-4514-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58268968AC5
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8ED1F220A9
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A72C1A2;
	Mon,  2 Sep 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwj0QY/Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89A1CB50B
	for <linux-spi@vger.kernel.org>; Mon,  2 Sep 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290428; cv=none; b=LqtMrzVN0zQlnhTGmxwUIuVzizADQqqwtkEuewDKV48QPWzzNDWjNnnbqNU1aGXt2/QynR1e/9lAQU8kB2C9OZi50hrhMkf+bP9bXk4oLWeIXODXfMftW8jtzAyaSH16CYdEqueUZAMP8thewPmBXVYe9fenammwJqcQMfVOcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290428; c=relaxed/simple;
	bh=ZWzF9Y3bq/Vl+qsj0xUHCQIs3txwHQQZm3NIQbehWeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=usA0/nDUzn2kuW8wpBrW5LoBOVxVKyz66Qsdf/9mRalfM7d7WJMC2Bp10hhzCtZALNFjUP0ED9xWBuPOuFSZHTbpADsYnvZVr3zfUBFGiNImqQMLpo+syjJQfRQ+XnkXw08G6eZOo/3PR26vyssczpVCiNGNZBnWqH3MjT9WywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwj0QY/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7346DC4CEC2;
	Mon,  2 Sep 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725290427;
	bh=ZWzF9Y3bq/Vl+qsj0xUHCQIs3txwHQQZm3NIQbehWeg=;
	h=Subject:From:Date:To:From;
	b=Nwj0QY/Zm8MW70en5s89wnqyr1TRj7npkXTrnpuG+ICTFbo43loneBqkkQ9nYhaOy
	 dhWfNL32JogruDsRuOPSyp+UYAyjJpjVEzuRE3l2Wv98MRZwVk7uppvExQsK51DV56
	 LzLnY7kMpyWBh0wo3WHhhKT1/1zOaiHOsu6jjPgR8iZrPtv7Uhn74hIV9zgedj//IW
	 M2zaN6m5RJX3kDoBHmUU5557gWRPbwWh3hDh/tL/WsWNHoXCKAZ0f6Yz3D7ze9XGgL
	 BYc/Eb7BkJoQGcKFJmTpWxtE7GhpzbpSXDfszrizb1hGzydEJS4wX1OlWJKPb9rKLH
	 UAfvkfGYUUI2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 399993805D82;
	Mon,  2 Sep 2024 15:20:29 +0000 (UTC)
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
 <172529042782.3918011.1807091241677486699.git-patchwork-summary@kernel.org>
Date: Mon, 02 Sep 2024 15:20:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: bcm63xx: Enable module autoloading
  Submitter: Liao Chen <liaochen4@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885450
  Lore link: https://lore.kernel.org/r/20240831094231.795024-1-liaochen4@huawei.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



