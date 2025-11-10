Return-Path: <linux-spi+bounces-11151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0AC49D0D
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94433AD5F6
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A6303CA2;
	Mon, 10 Nov 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDJw1JGS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5202FD7CA
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818634; cv=none; b=WN4jc2xBy7uz2CZMFyLp1aLMBVEzevZPUylQK0kgRBMQyP1ylaze/0YQVsDpzCKT4rTpvVaE+xo6A+SYG++zW5rUyEILHK5+ZfsQEGklHR0s5rUD5NMDOFOqufJyoII9u/D37UZMC94WwEQ4ZqwXAKqp7Vms572RpJ6gqiGUwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818634; c=relaxed/simple;
	bh=AuOvqgWu26I/WI1nK2N3IBR+AyvUMqUcYSWicLDoTe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dEqbY3IpTnmYfLvXhd6l7zTrS2S2rhFfV+EYyWwyWXvD05saVMiXQCrKPumSV3OOEOjwSCPSXhQZ4ssP6Q/Yr03V6ikS7aebe9NoHwbJPcBLEj3V4TFVFyAqcFwrENcvP96hN4Ezw8vdVEmYb9QrvU5IfJ00mn3cwbSVYmG8Ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDJw1JGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B1C113D0;
	Mon, 10 Nov 2025 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762818634;
	bh=AuOvqgWu26I/WI1nK2N3IBR+AyvUMqUcYSWicLDoTe0=;
	h=Subject:From:Date:To:From;
	b=nDJw1JGS2s1/o4Mz7EJrn1KrJBjShWu6RSh5FIv+qp6LLDlrUfvwmRMWSTUKDbH+p
	 SSwJlOkedkL++wLXsBZ0EtcJoRbvwoUho84bbJnRUA8+nAVgknqCg77SqZSVYgNT+7
	 FbwLo+CQPOBlAKasUr4hGdA9KhQemF2flsAz+LJf0C9OCGxpmk/0PWdbUUcnpwg4eK
	 auYLih94yVkDKhS3W077tSswahZAtyY0GqvZOeYwKwIlq1qb0CuI5WdNTwzHGX0q5v
	 CtTasb+L44UW6evc2g1sqF/yFM1ugA2tUaG8o8l/C0rpyMCVrrOcUZ/IGhb6s3JQSs
	 R+2uub2XX3KHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFFED380CFD7;
	Mon, 10 Nov 2025 23:50:05 +0000 (UTC)
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
 <176281860453.2813155.1156010751168123681.git-patchwork-summary@kernel.org>
Date: Mon, 10 Nov 2025 23:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Add TODO comment about ACPI GPIO setup
  Submitter: Hans de Goede <johannes.goede@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1021314
  Lore link: https://lore.kernel.org/r/20251109155340.26199-1-johannes.goede@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



