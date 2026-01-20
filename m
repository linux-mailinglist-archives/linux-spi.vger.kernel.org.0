Return-Path: <linux-spi+bounces-12520-lists+linux-spi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-spi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CEzF2nEb2lsMQAAu9opvQ
	(envelope-from <linux-spi+bounces-12520-lists+linux-spi=lfdr.de@vger.kernel.org>)
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 19:07:37 +0100
X-Original-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F09491B8
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7FEC9840A2
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184D441020;
	Tue, 20 Jan 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppXQjISw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C33491C8
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932009; cv=none; b=X7h1sCwftIjGkwFUTUhwRshiMnMEP5fyrNvT/7wQhs2yprzkAeQm6t0no807L7jA5MNbpaYNX3X0nMZe0mK8RpuNmAH0L77neZX3a8ggXKr+wiJef55QbD+o6q1Ci1WQOYaqumRz7DCSOE4vaeMYdQ5KtQhRC0LPXCp7QWQ2iwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932009; c=relaxed/simple;
	bh=zlRSmCSahMPOGtnOD32+Q3hBVcqFI96OxyKIVoSKPwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=orQajZlfXPd08oocmB0tmBU9Apg941hrVjh6XZWx0p3EFWD7b9DG/tHq+o+At4hfLVGfXL3pc2fV4NKpVJ8395KGwBBUOXBe9r7+lRMH1pXgJ5IXTDi59cB2Kg9WroqgAaTmR6gOwB4VzDzAF4PM4MCNyHp7Ic75BJXbfr7b70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppXQjISw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD31C16AAE;
	Tue, 20 Jan 2026 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932006;
	bh=zlRSmCSahMPOGtnOD32+Q3hBVcqFI96OxyKIVoSKPwQ=;
	h=Subject:From:Date:To:From;
	b=ppXQjISwTyT7kVDLV/7Z3mmzaFwBEDuTv6mc7ou1xEyXRqxAOoIhLuW3W2Q/SFCvF
	 7SWjtdd1cwMDUOIQR5CphRM4df1VP1ln7iMjKrdmHI0TWnKjYuNegSPQh5Ju8SUA1o
	 K3I3G8Ll6yh1RsCz+wyFfkGpmddZYpldBrYZoC39P2sVBoAGdVEouZPjYaD6K9Fwn2
	 Fvr0KKSm5EdmkXVtXliSltHBNvRj84J7AHALzsnIJ97DBSNkjLN2kEfbZ/dQ42j/D3
	 mwPTk74DsNj2U7jIzm98fiwU5OgRmzT6HYEeyT07KjqDs8mf3KcCMb6KMi78UKh+A6
	 Y3XNhf9cNdyrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB1B23812FD7;
	Tue, 20 Jan 2026 18:00:04 +0000 (UTC)
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
 <176893200337.546485.269024377368034986.git-patchwork-summary@kernel.org>
Date: Tue, 20 Jan 2026 18:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-spi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12520-lists,linux-spi=lfdr.de,spi-devel-general];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-spi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: E2F09491B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add MT35XU01G SPI NOR flash on i.MX952-EVK board
  Submitter: Bough Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1042119
  Lore link: https://lore.kernel.org/r/20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com
    Patches: [1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



