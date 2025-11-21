Return-Path: <linux-spi+bounces-11463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D293EC7ADC1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8505381319
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309552F851;
	Fri, 21 Nov 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA1w/ojJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD723D2B1
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742646; cv=none; b=ltnVdf+/6WQDxyK75Ds6G37q+JnjiEsa5uvkxdlg2fZUmM7uQkjcaEWPnGVcc57YF/nK5iIoyK39C3jzHG5Ox3is3jjYy8n6gZdATJLvurJFhWXAcCj1sb+YrdM5KtPEbkxyv75ydcck1b741/0vUlMoPwmNpTvJggOv8jbR80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742646; c=relaxed/simple;
	bh=9GYhWvQLIbbMPKxqMAjO1PmTvxIwgUeeH+jRgkVvm3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KgoyThC+cteioOEdCVnIdhP7hbHv1wgJE+jG2GXT3rNaM+Y7zEyRLfWfbKP3Tk1jxaFYjJ27TK8AQeQR2+xCH69RAoKzq7J22vfKdNL85GzRucNRdAYnZ/dH80NkuY38PcuBySBiTYufV3ND/nagqHbDLZAnGLLTU0dd9Q5h3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA1w/ojJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B612AC19422;
	Fri, 21 Nov 2025 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742645;
	bh=9GYhWvQLIbbMPKxqMAjO1PmTvxIwgUeeH+jRgkVvm3g=;
	h=Subject:From:Date:To:From;
	b=EA1w/ojJFVAkYK0EMD/vm7nsX5kfGrwj54IbJ1wWvXBfOAp4OMVoXcWRKyBs5PzME
	 a3oekqrWoxFxUfWv8EPcj9myyDyC3O3g2x0vmwSieg3+mM8iy/golNMGculDzcXIYQ
	 /3KCQs3wz0K+oSLk5sIgT+f2SfTWgVpQT13qVjZUek5vBnL72g+Ftkw3MnqDcqF/Ha
	 V4OnKIWLDm2IQdWhr0wwntm4l/UCFjjSBvH+g0lqOt1Dm1iMiNP3vKZS2uYZXlCkyN
	 OmPZk9e14X4pgGg2HE3SUu276Kqimw+Kv3c3Hl1H3ZkM3QJHpZVk3ZhCQXjKxaeh01
	 R88dTdZGd5eow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 755FE3A78593;
	Fri, 21 Nov 2025 16:30:11 +0000 (UTC)
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
 <176374260988.2499077.3228310246385811924.git-patchwork-summary@kernel.org>
Date: Fri, 21 Nov 2025 16:30:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-lpspi: fix watermark truncation caused by type cast
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1024079
  Lore link: https://lore.kernel.org/r/20251117030355.1359081-1-carlos.song@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



