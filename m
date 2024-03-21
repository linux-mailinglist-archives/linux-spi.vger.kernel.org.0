Return-Path: <linux-spi+bounces-1949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4BD885535
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F931F21378
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50352F70;
	Thu, 21 Mar 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdCEXrZq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EE3A1DE
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007799; cv=none; b=mc6k+QPRsrdTwF+801ANiSD/GlhzrTI+kcKX1SjmBeDaj9WiGk29rWAHog/Io6HhIgCCwhRBcSfd7P9Cd9doLsVECVEKDrfaBpasSamhRU500ACx45InAHRyZcI8ReexxOCUXK+XZhaxWhnzWQAx979wZlzAVPMvummf6hDJcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007799; c=relaxed/simple;
	bh=lnUIiaJPJhC0Cyw3owD+LQ9l+LkDaVSYODDCoLyuokQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sK4zBZidBXtunxcZy1vNfaBYDXGeuyyFFth3t7xsek/dOL9SFE1mGPcyi3DeFRUxA8CBpFrvswUvSuhVa+NNqS3g64krj+rJjXlbgGLg+f9tbj7ywZ22DskFxgjEcJhmVuEG3fDngIXTHwtQn1NgpGfMHh231gsd671s1p0tzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdCEXrZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC46EC433F1;
	Thu, 21 Mar 2024 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711007798;
	bh=lnUIiaJPJhC0Cyw3owD+LQ9l+LkDaVSYODDCoLyuokQ=;
	h=Subject:From:Date:To:From;
	b=qdCEXrZqFRTnQDGJcViMDWgdWmVUaG5rpFegPbE6sGV9hZO7yuwckh2+BuoE13aLr
	 WdXYC1XfUajeb0q10sdzXGI14VYHB8hl4JQgKRU39QWP9ttwmRK2QAgaislLvdtFOU
	 g+JJ8hiPOe8bGjaDAyyE7mYpZEAsbcD5sYgYVgLs19VAgz8LMS4bgRCWaMGVsLR70Q
	 o3oNybgqDSTV2CJVbxAeBScW9T0nn/6WB7h7uu09P+/UKxONVfoy8fxjxXb/Xol/xO
	 yDZ0NZeQuy1EOce9i+ofNkDyYm57pRudJt9PvHnvwaYrzvCz20D+CCHPWnlqX8HzI7
	 BMhRL6UJUVU8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE91DD84BA6;
	Thu, 21 Mar 2024 07:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171100779877.31541.12655717320816389973.git-patchwork-housekeeping@kernel.org>
Date: Thu, 21 Mar 2024 07:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Fixes NULL pointer access in spi-mt65xx.c (2024-03-21T07:08:56)
  Superseding: [v1] Fixes NULL pointer access in spi-mt65xx.c (2024-03-21T06:41:02):
    [1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
    [2/2] spi: spi-mt65xx: Rename a variable in interrupt handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


