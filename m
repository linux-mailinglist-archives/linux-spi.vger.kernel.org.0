Return-Path: <linux-spi+bounces-2667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D060D8B74FF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719B31F22C5F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB7134412;
	Tue, 30 Apr 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfP9N8kl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AA12D77F
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478213; cv=none; b=hU0YPCQiBiNtDG11HLx6nVggNtG8CvkAaUtvwdEchwR9stXFYo/itTHSOalgcm61xzJ2PHYfUdtxg8ockIALctBA6gF9hTDtsUhgLEtb1hFRSyR0ocDWntGT0VU5ZU+91Kal8wtHhf8OwVDyLKlfIGYG77gwlxZV41Ytl7a441k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478213; c=relaxed/simple;
	bh=GTfMy2+tRxAjaqfPYikgg3nJ5+dJ92L9+6Qe/sZREeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rH3x7m66msr5vx3ZfdTgd630sZbW2QD8aXkUP9mvlsn0RBUgc79SyFNgb7H3e0xS+wtvet/fCX6RREohzwO6Zr359mH4aRW4Sw07GIeYhgR422JvLr97DbV55/4WH3iDCYLNSQvoovuFUlzO8pyg6sCyMfJLg1Wt3i7pT6DWbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfP9N8kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A8AC2BBFC;
	Tue, 30 Apr 2024 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478212;
	bh=GTfMy2+tRxAjaqfPYikgg3nJ5+dJ92L9+6Qe/sZREeU=;
	h=Subject:From:Date:To:From;
	b=HfP9N8klNJe/YuCaKyq2kMa8yBWG4n5bZkCU0EV7YcaEZ90fW9A2lJ0+srZSAumU5
	 oIOyMn9bE8rFF+dYaah7+foduz/AG3Vt2jtsCpGcL2yZzEatWRYSYSySc873c5ara6
	 BR8IL5a/HZhdQ2+xzgRRdVv9X2WJjEo0WheK8WESVEa8FB5bIMetJuNnRI9KJKIhbR
	 GmezFZWHga8byRpcVn4U39Tkmj8r61DL7r9pDZbnkzbI1/6w6yGjkH24Q0BXoVdyt1
	 E79mWSnDqFEOOLaB/+ENuEQfBAmFl8iiAGdD3xq136za6a8mUWdUyUrDKeN+vDbbbP
	 JRRvsYIVlSyvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5008C433A2;
	Tue, 30 Apr 2024 11:56:52 +0000 (UTC)
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
 <171447821280.20726.5533317763243995257.git-patchwork-housekeeping@kernel.org>
Date: Tue, 30 Apr 2024 11:56:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: use 'time_left' instead of 'timeout' with wait_for_*() functions (2024-04-30T11:41:34)
  Superseding: [v1] spi: use 'time_left' instead of 'timeout' with wait_for_*() functions (2024-04-29T11:28:33):
    [1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
    [2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
    [3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
    [4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
    [5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
    [6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
    [7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
    [8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


