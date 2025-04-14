Return-Path: <linux-spi+bounces-7566-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F23A87845
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 08:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAFC3AD83D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31A1AD403;
	Mon, 14 Apr 2025 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukhBcFZW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908B1A2630
	for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613808; cv=none; b=AvY8/3F1R7cjDZFQDpHVVYOLLvQVf/KWvtOA+o2fKE4IQml7qhmt4iVCrej7kkr1QCcukIevvkPhYryvx3b2tEfYM7Ku7sGx2sPriK5vkQvgMMaspjAcw/yrcSEOujueQbS9Fy9LfgzlMeRKYdANbwWHzdoqfRgw+/Oj+3VYgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613808; c=relaxed/simple;
	bh=6P72zCwd5wZ8hWryIyrN9SEb0+LtuD3Bi8RsClPrhMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KoG1xJ06VPa93ZncAC3HVlglPt+vzpFLVrG5l8wfYMUkjokSRKTnil6boCmcYYz23TM3nPuAFoU1kdN4EybmUyE4Tck9/o6zezat7fMdEPj6kQs+qfFCWHNhY5lFfHIHrGmtpYU5u4KncWV9Cf/y/aluVeBTW+iHX/Y0SPJvmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukhBcFZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB9EC4CEE2;
	Mon, 14 Apr 2025 06:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744613807;
	bh=6P72zCwd5wZ8hWryIyrN9SEb0+LtuD3Bi8RsClPrhMQ=;
	h=Subject:From:Date:To:From;
	b=ukhBcFZW+DsOJc4rnU8OKq4/ZBmpX96oOFut+XR5NASExmhAMUg3gNKufstAV76IW
	 GyAeXD/VIZSLuhsE5WFJRmtGsjy5Q2YnR67IzWSeBM4JQR4GBcb1J6rQ5snQFFSJrc
	 AlhoDT+ox07IGZw894RKmISYNrvHHlA2engAk1JFfaaKh2M/M94K08zHjOQX7gAnHU
	 ROmV5VEaXKgntjCOLpCWgq282K43oNy70aG7WdFPIr+R5BU27z+sKHj2wZKoVgoUvb
	 TGQLPDWhlfNUJiBX82cEwZGH1+ROs2m8myhelBzQbOjQi7NKPpHW63FgcNhIUwknsC
	 pJ6pxReep6T5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B16233822D41;
	Mon, 14 Apr 2025 06:57:26 +0000 (UTC)
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
 <174461384517.1426576.3978270339757076182.git-patchwork-housekeeping@kernel.org>
Date: Mon, 14 Apr 2025 06:57:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: meson-spicc: add DMA support (2025-04-14T06:30:16)
  Superseding: [v1] spi: meson-spicc: add DMA support (2025-04-08T07:04:01):
    spi: meson-spicc: add DMA support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


