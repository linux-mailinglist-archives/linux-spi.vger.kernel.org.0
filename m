Return-Path: <linux-spi+bounces-8406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E75AD230B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32A13ABB7F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCC215F7D;
	Mon,  9 Jun 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRrdPyFE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE033398B
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484580; cv=none; b=spLkhlw83BrlHbDC4XdkkouXvot5Z0iwgbcMosz0BKnBAh0ICoBbReGdj8avE0w9RgGzC1VnXb2eMN/Pah/7ueErYbFNmVuNG0Rxn8pvfXP89+Q8WMgmSKnEFDfJfswr9xbu/5UiDCxuh5q5+/WWA8WQedCelXSXz5BRlNmhZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484580; c=relaxed/simple;
	bh=W5+C04vuLHo3SJKcCQIcEy2yemAt/lUKtquEs9riFYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=onP09Vh20A/v2Ygh+Wo44E/0UlTtC/QSWouFsBS/JMv8XR0xzjIwXXxCL2y+9z9JQOfr0YS6ESiGsmeqfe0YuZo1cqLZV4S6DZOPw8YmL4A5O18KPfGV77Hxf22FXrWZKEmCEerS0fKs5Vd9IIa26cBHF9OpZ7CRucTpl9r/DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRrdPyFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4931FC4CEEF;
	Mon,  9 Jun 2025 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749484579;
	bh=W5+C04vuLHo3SJKcCQIcEy2yemAt/lUKtquEs9riFYU=;
	h=Subject:From:Date:To:From;
	b=uRrdPyFEG7iw+MKWbMgyooS2pAW3zd6wOdkzBsA229RtkbSxBBDcUO5GMsIoNzkcE
	 cxY0hO/oH+WKcqD46jzTgqnLyMNav4uaCeNCYlDO30wXvvnFCwA8BCr1no/pD1W5NY
	 b4TRwgP1A1l3BGvW92NjKXeVsQ4jaSIQAS/G8PFu/Re/9KPXVjIdX3vp/GzXm3WD/i
	 ZvUKi/Dm6sHw6kLPfdSEmxy0h4lgMMAhzkT2lweyYstamQ7W88Kfh3+pNlPgGS/8TC
	 vni6t0JahGtyf0VPo8/QlZr+jNVJwVhelxbwConLfuZ5jIX0qKYFy1pPXtlvAbmL3u
	 +pzf2Nhv3pV0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E94380DBE9;
	Mon,  9 Jun 2025 15:56:51 +0000 (UTC)
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
 <174948460974.1351555.17728148883184208802.git-patchwork-housekeeping@kernel.org>
Date: Mon, 09 Jun 2025 15:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-06-09T15:05:04)
  Superseding: [v5] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-05-14T13:56:01):
    [v5] spi: stm32-ospi: Make usage of reset_control_acquire/release() API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


