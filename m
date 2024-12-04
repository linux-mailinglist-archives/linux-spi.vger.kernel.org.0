Return-Path: <linux-spi+bounces-5910-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A329E3FAD
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B9C282350
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095C23BB;
	Wed,  4 Dec 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwd2JMGI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9420CCDA
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329816; cv=none; b=mZO1Wwh3nPtbxcxedr5prNCaBunCj+65v5TDJlhGlzBuvAO5YibZ7MeRfr4yXJf6sHEqPi6GNjCAYRPN1aVOoW7ZPj2XSBMtM6o7FH0QJca7hemgN4slkH3ktczCgtE3UCql+4NEvp+BlBywn8U3dul6gNTtpPzptGXusf+T8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329816; c=relaxed/simple;
	bh=nxGKPgFbQNzar4hM0st7abtkWWyDOw8/f9/C5DR7nmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BQNWFfjXD20jXPp68YrvQycN3pyVyd6IgB/+4DI7fnC7HL9uV1nncTe8pywSXbiSa5SBQNqT3q5oUrLARnpY5kpOXZ6ZKuafXJxN51npn225SNptPT2VxeWIn/FyWqQOBBxjnsSqfeE9bpPwQS+5x99edMvFDd/iCuDfP3sKXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwd2JMGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E089C4CED1;
	Wed,  4 Dec 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329816;
	bh=nxGKPgFbQNzar4hM0st7abtkWWyDOw8/f9/C5DR7nmM=;
	h=Subject:From:Date:To:From;
	b=uwd2JMGI2W/5bJd36JeXurdD33wmlRfPZgxRpg+O0xaxd8paTXgUXPIwB/v2l8knL
	 1J2FtpZXqfqbtemVXoCdyPV3lYLU4FHLVkonSw3Sd/MVm8S1c/izNT0wpITHMIM0fa
	 xXYyPhBL6yuQr90AWJPNqdb7Uk7WYWeZdZiA1goCUCACegMgSdl1PaCGansfAuQd+b
	 qxmrA9hESObRCwIuJR3s91XZ3sXhwp02T0iX6VgNu/TKCukb+dbqor2N7D7vllkTZW
	 cBAamC3t316atURLISuC1JGAXtr0Yrh/hz3jgHj3mQdrq0zBzh2qyYtPrDP7Q8T3Q8
	 knKGact0XXIhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFFEF3806658;
	Wed,  4 Dec 2024 16:30:31 +0000 (UTC)
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
 <173332983044.1253401.859067792588647664.git-patchwork-summary@kernel.org>
Date: Wed, 04 Dec 2024 16:30:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rockchip-sfc: Optimize the judgment mechanism completed by the controller
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=913957
  Lore link: https://lore.kernel.org/r/20241203013513.2628810-1-jon.lin@rock-chips.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



