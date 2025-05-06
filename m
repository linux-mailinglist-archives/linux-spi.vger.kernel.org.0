Return-Path: <linux-spi+bounces-7933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61725AACA36
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7D18823C1
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447128467D;
	Tue,  6 May 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbnLH8NO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFE283683
	for <linux-spi@vger.kernel.org>; Tue,  6 May 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546983; cv=none; b=lZ+nOQTYduZWfN/W4cFMGYskk6KHH9pMW1UWo79cURzDrFPDTUWY1KAdnQ6uG6Z1MjMzjUCMqtNGGm/o8utbtxrKpntTo4JZrpHiIO41jdinbI10cl76PC6o1mEsiLWUY55WP3fjBpX4sayjSltGlOjwHHMBR0hAfQk/VVTG+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546983; c=relaxed/simple;
	bh=xIJnD1YSRIyUxEINq2hJSBfdm0qtRRY8Q/mgOBjRFMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qdH1F9/ZJYo2AiYW2xQ/GpAkVs1tzqqQAuOaviC7G54FlRONIH7URF6dawVRTLEQdMlzYdtRwBkLXdM/J2e2aDEQFfwrEN3uJ2mnCW8H0/ua8JvtF4aKC3GTqowCy1bvXBIq+u/EJivTb2NB+RbxXBepbudw9o0nzafkJsbO4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbnLH8NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F59C4CEE4;
	Tue,  6 May 2025 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546982;
	bh=xIJnD1YSRIyUxEINq2hJSBfdm0qtRRY8Q/mgOBjRFMM=;
	h=Subject:From:Date:To:From;
	b=RbnLH8NOxnrRFgQ4jiAKRdGlx68yff8UjB9lRuoBFpuw6mbxzkBIhHH7NZXd9lJpZ
	 3+52fkUhsCeQnIYhbAdM3Hn5r2V2JRdd4f9dlPegjRik+BxonrrJe413zD6qi/VaBG
	 ylU2uiqjxkcpNKufVXIjQjN2QlhHYNfdlMLdgy9fbzYz6wYCg2eTJcYqCDxnNh1NCn
	 TiTVD7xZaHrN88av063+k6s/CWQhoqSWD8fBV2cAH2IZLVCczV9os+yso/Yuh2a8ez
	 5W9FBH/GAkZiQhM5gRk+68Bt6sHYwEIGvCENCeZRBBBhuvODwhJI18Gox0LkxAwPDw
	 QUgRmJYyR0Ulw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB69D380CFD7;
	Tue,  6 May 2025 15:57:02 +0000 (UTC)
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
 <174654702142.1570284.13338987320704376394.git-patchwork-housekeeping@kernel.org>
Date: Tue, 06 May 2025 15:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: tegra210-quad: Add iommus property to DT bindings (2025-05-06T15:23:48)
  Superseding: [v1] spi: tegra210-quad: Add iommus property to DT bindings (2025-05-06T12:22:20):
    [1/3] spi: tegra210-quad: Add iommus property to DT bindings
    [2/3] arm64: tegra: Configure QSPI clocks and add DMA
    [3/3] spi: tegra210-quad: Add support for internal DMA


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


