Return-Path: <linux-spi+bounces-12422-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8387D27BF1
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A96C53024A51
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42953C1975;
	Thu, 15 Jan 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdwsRsNP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248C39E6EB
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502623; cv=none; b=uHHmVAQE/Ep034iSMXm+hCfrfLkc+YqadzkktL6z9Bw7m3UbJD1gqIahUxovI2Va9yTgE7LnVJUXaPn3J1huYx8QitTn/88B9wvYxl8epG0LnbfYYtDeePXykLlKV4l/pbMr9bdgwqRx1cuWz19+7AF7hF89dKyBRNkfwPX0jdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502623; c=relaxed/simple;
	bh=JaTth9RJ1IL9tWAMh3KG8F0Ft/ZQhHgkjD8O7AVukw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fiuptMNodfGK48QOnFDdTmKDt3gqTUHrrO/P8iKUL043doQXkYnU3NFngcwIKHfCeygpg9KBYShro9xRny3xepT4G+uJAb1YNvAFtafc9MUfT049mCB0iv+Qx7yx+97JmSsy3eJ8AXiFNBcN2UPyqMECDeVVoB+gezo2anSj0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdwsRsNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7098BC116D0;
	Thu, 15 Jan 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768502622;
	bh=JaTth9RJ1IL9tWAMh3KG8F0Ft/ZQhHgkjD8O7AVukw8=;
	h=Subject:From:Date:To:From;
	b=kdwsRsNP/GkkYGjfSCqQ0DM/qnuIsZ+2oZFjIHq/fIUf1XGgJBtjeyF9YGtWfMhAb
	 AXfj3EAXxN4MkEZLTJCrqcsy/ahvHmDeQ14XuKvjT0p4cHDgEzug6M9SlIga7iCrvP
	 x1xTyjt3v3kh0uWqE9CEwbsrWbuhnNEpb95piBygwzES+JqNBGBxyPbAXqVxupo9Vh
	 3Nkrhc4OvsVoCKMYXFL0ra/5ZhYu/UoN45ojJcSKfcLadkRVW+QBUv3kWn2EVyfyND
	 DWZC3Uz677i22k4/PGMMK/8ISbFyGk8AsO2xuOukUt9H6/kOLKfRpaEWC23U+421IA
	 u40FB1+Ut0CFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BE8380A97A;
	Thu, 15 Jan 2026 18:40:15 +0000 (UTC)
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
 <176850241417.4118455.17782394572839183879.git-patchwork-summary@kernel.org>
Date: Thu, 15 Jan 2026 18:40:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel-pci: Add support for Nova Lake SPI serial flash
  Submitter: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1042787
  Lore link: https://lore.kernel.org/r/20260115120305.10080-1-alan.borzeszkowski@linux.intel.com

Patch: spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX
  Submitter: Jun Guo <jun.guo@cixtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1042719
  Lore link: https://lore.kernel.org/r/20260115091924.844179-1-jun.guo@cixtech.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



