Return-Path: <linux-spi+bounces-9575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6194B2EDB6
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 07:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723A9A25056
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6023C509;
	Thu, 21 Aug 2025 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5PumElK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B417BA3
	for <linux-spi@vger.kernel.org>; Thu, 21 Aug 2025 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755802; cv=none; b=Vm/7lbRX/0FxWVp9z+2OVPm8DxX8NsAo3Gs78CvR2cWJLgzes9mFSL+Nggmjd9FPw5DsckvpQLPVpFq+D7lqX+IcAyPqLgkjISdSjkSzqmURAMyn1/ZvObiOkuWqzIJmiYYDb+0+KmR1Z0rYqTr/KbnKThY88NV5df6eNG9b1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755802; c=relaxed/simple;
	bh=SMmrukGr5rIu54FtPp5/P7JKZrJzIU5KrfimzCSkK84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Fp0ucZ5dN0vuZ8mM1MqYZKB9cbhwA6NjAdfhMVCExrecM2jxm6VNU+TDYm0KHE93PcMcTOER9rpEzxm6Mn1PgCMzwS6g8HtV+1o6J3E28OViodI8f+4KjFpr9ka8JRUl6ObebtUfuLKLGSpBYQS/3d8yJIFv3BLEYNwBPm5osKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5PumElK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2454C4CEED;
	Thu, 21 Aug 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755755801;
	bh=SMmrukGr5rIu54FtPp5/P7JKZrJzIU5KrfimzCSkK84=;
	h=Subject:From:Date:To:From;
	b=t5PumElKH9i20BiLI8JYmGa1Xl3fpD4k+cCSTFTsBQHWCacCd8qmupA5/plhHONmD
	 CF2UExgYiYck68rJ2kK0wUbS/xDx53kyuD0Fn/5RevPHqZv+U6vOc3lAg56imbkbZ1
	 6qp5GLIPcSAuiWIOJBolIAnhpxjx1m86Ck/f8rasnEEX6i1v8XK3AkNrUYZ6FXGR/3
	 1rlpqVB+MH2NxQ/6CL3Yl9X2yFfJso7GtK34Z5nElA6GqVMG9IAG+18OPZb8DhkiNr
	 FsFCZ5lNtX/slbRx8YFGdrTBMEA1HvExGNguJgKlp/dIjKAVIvU9/gdao0Cg48ERHO
	 qDx42kjyh7vGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D97383BF4E;
	Thu, 21 Aug 2025 05:56:52 +0000 (UTC)
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
 <175575581100.524997.12310208552928822322.git-patchwork-housekeeping@kernel.org>
Date: Thu, 21 Aug 2025 05:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] support for Amlogic SPI Flash Controller IP (2025-08-21T05:17:15)
  Superseding: [v1] support for Amlogic SPI Flash Controller IP (2025-08-08T02:00:33):
    [1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
    [2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
    [3/3] MAINTAINERS: Add an entry for Amlogic spifc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


