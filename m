Return-Path: <linux-spi+bounces-7876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35925AA8363
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A217D0F1
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC518D;
	Sun,  4 May 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBcC6z+F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B730A29
	for <linux-spi@vger.kernel.org>; Sun,  4 May 2025 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746317387; cv=none; b=MYhb12PE1CLzRx6fdvPeGOde6VFsuujJRZA+W67vvqsFiXINQluOFrr641Dkc/Cn9EfAUrl8316p/f8dziOKjVNfgB9uUY+TpoiVvp5tc/QfTRTaQ19X0SHmODBFnT6GgZUHEVrKpcFU0oct583yNEDQQiPByqTlqTrl+ZpF2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746317387; c=relaxed/simple;
	bh=B8vOYFP65UFTUG2J+mZFhzEshg+YU8NBqmxVfrBqDfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n0srs1dSi1l5LjQECT3WhJ3C2FQRwsOyWPRXeHpYT8E0B+Td4w/P8bfJpdW8IHdoHvHwPRAPctJ1dNogvT19p16+tz8wqPkqsENvcyRQ8K/pHvJHeVPPxDt+WWLTYcZKPUvNc9CKpKnBQa8RlC6/c8DoWArWfDekkqhaMXgNCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBcC6z+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46FCC4CEE3;
	Sun,  4 May 2025 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746317385;
	bh=B8vOYFP65UFTUG2J+mZFhzEshg+YU8NBqmxVfrBqDfg=;
	h=Subject:From:Date:To:From;
	b=cBcC6z+FJ0RUqgQA89Sl05Uja3+DMBG164iXsf0df3nlxU8x2KwRpmvl0PC7tQAqy
	 ik9YsX3fFx0S3ZgjUtw7xXVnHmrqoqa8BaerjWIyzRRLtAdmo28zE4RMMJtYiS8WIL
	 JRqAe08XgJThadDuXTHu7/dFF787Dk60468zHzb86AuR4CAeRjuXVLh01nXOAfKduY
	 AmdvPqwZeTnXZ959p6+k8lCu97rdfiiYFGcegkT5A3mU9MpH+dDeD2/Dog+Rmhorle
	 7l5AjWaji3ef0qkMXZoASSzeD8oo7ACtSznUA3qeT1xO9eyHC9qjJfzYl8nr2VzPz6
	 4Oyjh5O0/TO3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37AFF380DBE9;
	Sun,  4 May 2025 00:10:26 +0000 (UTC)
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
 <174631742464.3944607.10746022867752897775.git-patchwork-summary@kernel.org>
Date: Sun, 04 May 2025 00:10:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: loopback-test: Simplify strange loopback value check
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=959045
  Lore link: https://lore.kernel.org/r/da612090f543c8c7cc99fb9dc6ef4abc9560abe4.1746184293.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



