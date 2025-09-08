Return-Path: <linux-spi+bounces-9944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B85B48937
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 11:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CAE3A4DCF
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE132E2EE5;
	Mon,  8 Sep 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjtF7bo+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB41231C9F
	for <linux-spi@vger.kernel.org>; Mon,  8 Sep 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325421; cv=none; b=P/hXbfRtTP289ew59F+YxsE1BbyP0XJiR2aVYQd0gEElLAiSUQ5yPvX1vw7FHW2917F7V606No9j69jgsnZrEVcz/roSpBImduPV7Eh89OCl+ehBVkqAvCNvpT2xn575So/40nyTHbqCdFAiUdHslDSajUSBkbX0UXg/vnFpaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325421; c=relaxed/simple;
	bh=bj0hV16bLNOSnS+3AlNsjvVrfGtODtbmvs2nk1gmFbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bRzwAmlXLIlAiUx5YvBjEWzIOd3yMIXjV5d3oo8OkNYCL5pnhIDhz3Yzyz/pmytG4VUTKHQ4/mNNDB4o8UP5y6TDiAVqZ7SpP4jMvH9A2+a2yfwoI5cBaQjyaLQkgFWfK17x1++DQf/3Q4HSiLKtaF9Feuy6l8eZ5ufoV3szdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjtF7bo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99184C4CEF1;
	Mon,  8 Sep 2025 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325421;
	bh=bj0hV16bLNOSnS+3AlNsjvVrfGtODtbmvs2nk1gmFbI=;
	h=Subject:From:Date:To:From;
	b=HjtF7bo+lYsrHMe7awcMvM4q3s5Kz5WXAMMWSv9FRCM2pHBUsPAoHp/wAYzlvuegL
	 k2vBZugGEitBjLF1pM68+dpG2sG3R3IozEndxKgYDObPHYJPaZuUkJEYBRwtsWPI/R
	 RsXsyk9V7O93oSimK/cUeFYiPGeCw2Vp0Ye72fOBd/7S0/pfXOtHo0rlkNeN7rzqCW
	 /Kqny3+aA0mNhgUkxsSqG//ZHCOCZppEsdsfwhfdi1UMOsDuYjiUj8MLt7iQe9czr/
	 S/gT7+t12hj22xORuhqjXsU/g9k5tPnmfmgN++kxEmMhR8f2peNsrFf2jfvdHhxcnI
	 WAGBDcSH3kjpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C82383BF69;
	Mon,  8 Sep 2025 09:57:06 +0000 (UTC)
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
 <175732542496.4008087.5387323246140009102.git-patchwork-housekeeping@kernel.org>
Date: Mon, 08 Sep 2025 09:57:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] Virtio SPI Linux driver (2025-09-08T09:23:45)
  Superseding: [v9] Virtio SPI Linux driver (2025-08-28T09:34:48):
    [v9,1/3] virtio: Add ID for virtio SPI
    [v9,2/3] virtio-spi: Add virtio-spi.h
    [v9,3/3] SPI: Add virtio SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


