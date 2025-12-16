Return-Path: <linux-spi+bounces-11933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45929CC0E89
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 05:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AFEB30FC2E6
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 04:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1F33CE8D;
	Tue, 16 Dec 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSdAS0uI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857533ADB2
	for <linux-spi@vger.kernel.org>; Tue, 16 Dec 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857592; cv=none; b=mwgqMCbBMPEsJlx13XFPnOYoIYvnNIe5ItwQce903aw/42HPUCok5cFE8d2CwCyAJNQB2WxlPCelRgKDv1jSuD+91uqJ+LhKXqTONG8IYykt3fG/xx8LGJdEhpquHHazrrPCyh0DJwBeAgcCgk8t/c9k93lZEDymqt96eIN2Z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857592; c=relaxed/simple;
	bh=DlW7ezOREJD//KrOfOqHKQ0idiJBWcIrEg4Wbvr6Q54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ho44jMSKGkOyz/sOVdbp9mOeFdOZDSlM/nBlhWTVVfY0jS+tYHbULhzoH71Zu0II8CaiaczOvg/eKDGVK4hMpg3Lw4Uj5b/7aLyNKJ5F2RYheydMGg43QmgbUuXLfqqb835LHOdZey3xzXy28pkf2qE5Preefc8MVUhV9z4zVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSdAS0uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6427C4CEF1;
	Tue, 16 Dec 2025 03:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765857590;
	bh=DlW7ezOREJD//KrOfOqHKQ0idiJBWcIrEg4Wbvr6Q54=;
	h=Subject:From:Date:To:From;
	b=YSdAS0uIrj886WzbMoRI7jjM8mroFjPqGCoTM9pOzWXreQMpQ/wKSP9zopc0WA2hs
	 aSEY50RxdUL2q+JgmxeVMDafkiq2w5ZQgF4gnndZtSUfIEH3xu9El+WnFHR5TK5zIh
	 oFBY8JB8EsxOnYUayf02DkO26EERu/UZua8od4hTwQXagiPnJUjq4/1pt4jxb58aoc
	 COSkiadxOwhZP7W8BXfYpq/xxb09aAKKQctlDA6h5ebTSoVi+R9FvmK6rHVMr7knNr
	 higa5qB6xjPdJG6nkySSHmVjKoKetAZSiig9fZEylW1YMqCtapcaQS6n/niPWiT3ai
	 z8NozX3tuRHDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A0A380CEC5;
	Tue, 16 Dec 2025 03:56:42 +0000 (UTC)
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
 <176585740147.839609.185031218404697900.git-patchwork-housekeeping@kernel.org>
Date: Tue, 16 Dec 2025 03:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add support for NXP XSPI (2025-12-16T03:20:12)
  Superseding: [v6] Add support for NXP XSPI (2025-11-25T07:42:17):
    [v6,1/2] dt-bindings: spi: Document imx94 xspi
    [v6,2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


