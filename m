Return-Path: <linux-spi+bounces-11271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE731C67324
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 04:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86A974E1582
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16A1EB5C2;
	Tue, 18 Nov 2025 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6SBAPK7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8A35972
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438281; cv=none; b=tJQeQynLQeHoKdZ+7ir38VhFJOaw/v87YTvaCYE8fBPGgWOHdhwNd+HyPS9M1yvUOlJ8GKsiWgOchjA42zRonDtHG0CrX5XNvipVKbHXHqmtTM6/8uLER5sH6sMBVb/bVPUdjMw7APMX5owcwUNqboY+v8UZ8kF6+X2gkQsEiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438281; c=relaxed/simple;
	bh=6Wq1ZU+lsg/P5px1163x45eB0FgdacX3/A7TPPtf7aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WPUVdO4IQfn6uMANUqKSmQFfu1Mx17tTnqNWG7B9FXYgQBWFa6oN0VJrdj8wpe5xmtHjjeWrZ2k9MxvDE8pMWlOD3YWfw0AXAnRg958HEmA1R2EmTfngt40euCyKQOhge41J8+d6/et3Sxof/hPgVx/hUCl1b1ZQzbyxlCdj9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6SBAPK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC30C2BCB0;
	Tue, 18 Nov 2025 03:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438280;
	bh=6Wq1ZU+lsg/P5px1163x45eB0FgdacX3/A7TPPtf7aw=;
	h=Subject:From:Date:To:From;
	b=L6SBAPK7apI7rTiz7K6aeIS8kOLOau9IrWI+yfQd79ND3/6ze7Lgn497Abj3Vuj1Z
	 Mf+4WuEAsLMf7p7oNPaLI5Uacbv7JhCVmnJeaHHHonh+wIms95IEOHIHeADQa8AzKt
	 39scpOnxlVgRH1RtuJ18xc4Ym+fU2UgCTqYWO3jWLPOriiCSZoUu65fI2nBGjM4dYr
	 whTCpZ0H/3/SXTPmZx1SdeDUbSMhxs/3/bgbiqt5O6GUWWTz2+LY/ujqyava/W0Ctd
	 +geNRzrU5F0GGGIGNdrLl24n5vdCvzsvUoVRrqu7wgU8mhXUvrTZjbprYvZcSFT2jp
	 6smOS9LF/M6nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDE353809A1C;
	Tue, 18 Nov 2025 03:57:26 +0000 (UTC)
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
 <176343824547.3577564.9383433938770869906.git-patchwork-housekeeping@kernel.org>
Date: Tue, 18 Nov 2025 03:57:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add support for NXP XSPI (2025-11-18T03:34:15)
  Superseding: [v2] Add support for NXP XSPI (2025-11-17T11:04:23):
    [v2,1/2] dt-bindings: spi: Document imx94 xspi
    [v2,2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


