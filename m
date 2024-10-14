Return-Path: <linux-spi+bounces-5230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EF99D5FD
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4657B25306
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6D1CACE1;
	Mon, 14 Oct 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEmC9flc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C491C7B6F
	for <linux-spi@vger.kernel.org>; Mon, 14 Oct 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928586; cv=none; b=H4vRclxkeQ/JBqWdogS+SHLZR432SM1eB1Zzp9ZW5QoPr4sB38AHohzONIRzDqVIXMPSlOgfdLK6Zr+1RnUS94I1e0Bwu1/H6gDa7RkQYgiUHNXGDOKah+uRRkeUEBOA4gNPLgyJBMifUaHeVkDp72YXPF/jbxE15yeFJAUUO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928586; c=relaxed/simple;
	bh=vzTlf0xyaTMOtrGAdSVInrYV1G3SBySHT3A+yAr1T4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fruCtakHnrM4kRSiYQDzeE4F7etBeDAVU2YR9CpFabDibzJTFnRCTfZdIMWcVnCYOSbUyRBVYYfEzgJva4ufUL4MhlRXuZPRGSDg6Q5TuQBNcBxrTUOSlqCHsz/6ptvMTwb4T0bcgcInfjP5DxNuDZ1ECSUDequn+swAoWHr3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEmC9flc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325BAC4CEC3;
	Mon, 14 Oct 2024 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728928586;
	bh=vzTlf0xyaTMOtrGAdSVInrYV1G3SBySHT3A+yAr1T4Q=;
	h=Subject:From:Date:To:From;
	b=dEmC9flcWBBFNjFDRMu6zhYegCa5j0qJ6pTLH82A6Iq5fQ9iG/Eui96StW/NcojCM
	 fM2fTjCzU5VCbsh9uXLYwwa+khZjn+aJsJC4+kxE1S4XwpMTo4bJtZaiNaD1rBJ7Qt
	 0A7gD2YXBlSOslkBofvZVaFw1Ab/Fv0TqtBMyeGJbfvB75+E314Iv3nsrBL0jyGay9
	 VSAwFuxBWSk8lEHWKbVKy9lychLK3+I8mFPSTJa6dNuYmE0DvxY1ciq7QjjkeoQLTQ
	 45nGy318Et81gkQ/BCTOvGB7pWgvsNS/v3zUut2oaGEJgGTGT19RjMN3Czb/rsY9jS
	 eug1me+o/VWJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D113822E4C;
	Mon, 14 Oct 2024 17:56:32 +0000 (UTC)
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
 <172892859089.593778.16799895270682717283.git-patchwork-housekeeping@kernel.org>
Date: Mon, 14 Oct 2024 17:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] dt-bindings: spi: Add bcm2835-aux-spi.yaml file. (2024-10-14T17:02:07)
  Superseding: [v1] dt-bindings: spi: Add bcm2835-aux-spi.yaml file. (2024-09-29T07:22:37):
    dt-bindings: spi: Add bcm2835-aux-spi.yaml file.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


