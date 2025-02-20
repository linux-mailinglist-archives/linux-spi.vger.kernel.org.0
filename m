Return-Path: <linux-spi+bounces-6884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEFA3E783
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 23:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1A3BFCB5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DBA2641D2;
	Thu, 20 Feb 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQNlsJ0N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC221516F
	for <linux-spi@vger.kernel.org>; Thu, 20 Feb 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090603; cv=none; b=Na2w5IKsrdZEAEAysSb89SL9G5WFJ/bDdaAuvp0yTY1Nvouk8RrdynYLvKSI3eeksFbPXHwXZjjLiG2gtEJh818uMW6K38omyAQHQtqC0Okr/ixGL3/AaNZ9lUr3CjbMytXIC9WlLoZ6cYmtENsg15RQODbXEKyd8ZM4yVDKfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090603; c=relaxed/simple;
	bh=jhD2JZxoxuj1tCzLMSTnJTmA8jObRe7rqj8+stJIvNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=s+B8RJxNv+kMBHi29m0DpSrz0E2acAjYCUL5bsVkk4xCISLr7Mwg6Qok126f9p82IIi7aVDlOGzPO6W8DNLkaxeuKjNXUxlFQ8kJ4jRcR7QiwPUII6hA25GiYq0TZNcnD6Cgy+Hj+Prww8aRODC2Jr1M8CRXmwOrXFfYR8hpX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQNlsJ0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B9C4CED1;
	Thu, 20 Feb 2025 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090602;
	bh=jhD2JZxoxuj1tCzLMSTnJTmA8jObRe7rqj8+stJIvNY=;
	h=Subject:From:Date:To:From;
	b=WQNlsJ0N5RAsz6ANaMIkbDaaoL6T7T5rMtPj8temCPVGwBvPuONTg+D71EvRWGvrU
	 XJH9QXs9XRUBSIaXLuvm6pilYRq2kkno789o5WdQ5NOW0fmch/xonpdaHW9kPXe+bQ
	 jxImOs2L9DaAWMG7ApBxaGIZXIMH4vCuttlVzl3TbeZER4mGhDTPm1emR6jVOoXLWa
	 my6A/e7o+IlrtRy1c2zHg5f2i7C8V4wb3okjfLFxsPRIw4ZTCON4RDNWDQDOTzCBAi
	 9IXJ/KDCju1U97U1iiuDKeBzP5gM2U1mFKoChAGuegS3gUl594a5oHZHxHZDo6DCEj
	 kzWYJVjm83riw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B77C380CEE2;
	Thu, 20 Feb 2025 22:30:34 +0000 (UTC)
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
 <174009063306.1498347.6613674612366161878.git-patchwork-summary@kernel.org>
Date: Thu, 20 Feb 2025 22:30:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] dt-bindings: spi: Convert Freescale SPI bindings to YAML
  Submitter: J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=936005
  Lore link: https://lore.kernel.org/r/20250220-ppcyaml-spi-v3-1-e340613c7875@posteo.net

Patch: spi: s3c64xx: extend description of compatible's fifo_depth
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=933915
  Lore link: https://lore.kernel.org/r/20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



