Return-Path: <linux-spi+bounces-8918-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C5AEDFDF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A8F17A596
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43B28D8DA;
	Mon, 30 Jun 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLd6SZCW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD428C02B
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291967; cv=none; b=FBetl6ydR5AMFZRV7SbkTjntAuGgGJmpYkBI4w+u+D7OdOUGeZacqTm323ZZZsABuHTR3atW45NIy1gCAtUdTqxRScO5kVgkQRsxjbfSsqwojxVQzxQv4Nh3zGlm+vhdO33bFlpemH+6gRAaSyHmdp/N2AxUsvBZTLoLeU6wJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291967; c=relaxed/simple;
	bh=De0rACTIajhoIrxwBPaHTmx0R62enSdHm4epo2dL8Rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=J2a39e81YmLEgrGjjkgSTAf53GvZDJt1dfBDQZdkC9PJiOngs8C0spI1PPfeH9bJg3lf3HXrnf8gtszWZtQqAd1yvNf/ux9fW0GgY6kpPqDccv3cUnrmQEeoWBGN1m10TVBd6B3v12696GeVKiznoqqDrGWjkdK3LFu7dYXiR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLd6SZCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25B7C4CEE3;
	Mon, 30 Jun 2025 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751291966;
	bh=De0rACTIajhoIrxwBPaHTmx0R62enSdHm4epo2dL8Rc=;
	h=Subject:From:Date:To:From;
	b=RLd6SZCWsaLwzwBeUFR5uQHoPvSAQnXqhw2mmdnGIg6rVTreKin0iyelqfI0HvDUu
	 5AjEm4kYU2c1hiqHcj2B/XXfdFOtcYxpUlzf+XbhgGXzV+raIYwNpzQaDEx8dsSnNh
	 hBAvFzkbYMACCXnPlppaNF1WlgIWmsIxRoEDWcS3UTL/9dJStKqJdsecLmIeMzocRs
	 fZI13EqXbPNF79QTddwSNK0qtRJiQwInCUm9xpRBtJrBh/xkxSKmBdjFcF/2dmPKlX
	 APF+7DhFKabefRlsywc55pZ+nNinWoYi5BmKE/FiovFFETYhboXPvwM6P5ekEpFxpV
	 nFVF9j/T3AM2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3774B383BA00;
	Mon, 30 Jun 2025 13:59:53 +0000 (UTC)
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
 <175129199169.3392669.18264052183250248837.git-patchwork-housekeeping@kernel.org>
Date: Mon, 30 Jun 2025 13:59:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: stm32: fix sram pool free in probe error path (2025-06-30T12:59:23)
  Superseding: [v1] spi: stm32: fix sram pool free in probe error path (2025-06-30T08:20:13):
    spi: stm32: fix sram pool free in probe error path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


