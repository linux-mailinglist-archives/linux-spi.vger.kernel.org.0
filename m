Return-Path: <linux-spi+bounces-11907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7FCBE9CD
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DFE30726F3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E0334C02;
	Mon, 15 Dec 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlJgs+SO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CD334C13
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807189; cv=none; b=RP8eQcGpg97OC0VLANts+YJhFUELea+sdqXOttX1RVsRl/Sik4pecDHIxByVtSPSn7FMIaKLafcRwXQZbV2E1XX71AaCYD8TJ6vF4oUKhXOsrSeZ73FBgE0fR0e3CR0tphtB6YJIw50UwldV4eU0ME9LpvGiFZdwKR8AcvxYu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807189; c=relaxed/simple;
	bh=6n0LWEmN4UqidHTptn+3zginOOz53lIirfLkkom45Wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AGZV0IkEgw6Svm24VM8YpbyhVi2fcPN2Z7KnU2IITA42W++6B+nDijgfqPB4FWhyvQJsOk9li23gP/QcGEBkIZeoP3TEK19zO7hrW2/0/C1/brD16BXwd+I3RExlSDtiDs1anpYtGmbQRxjuoOQ0i8hD9HjCHlWHQTdhx6MARkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlJgs+SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC232C4CEF5;
	Mon, 15 Dec 2025 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807188;
	bh=6n0LWEmN4UqidHTptn+3zginOOz53lIirfLkkom45Wc=;
	h=Subject:From:Date:To:From;
	b=TlJgs+SO5nyJ69LuE1u5ylXJk/krxqjyUXWhGAYtRDFSc87YSg0xpkMUJgHTguuPj
	 OoOZbG80x2zbytavLg7X3bCFj842iJiPYBVJViA3V201Z9Q2s4kFo3BP1N+/NuY8SP
	 hk1XXnSsuA5c4Ux9dysL139FR+fDYKhA1BrVsVfDoRbxydaI3n3uLuPkIFcntbL8KR
	 HMLCYoN0jNb3KnsBUmx7mfgXz02CPeEjk0tFTAs/bd3MZ6klUDWS8dTB8pGrlxKFiG
	 tO9eWcmfWulHH+1i+BLMZaTvny/MsHSJZX7+yE0od09qbDHw2bAYT9sLpH/whOnOsC
	 H1k0XPbsaqSDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42B39380AA77;
	Mon, 15 Dec 2025 13:56:41 +0000 (UTC)
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
 <176580699968.4191605.6978873903465781793.git-patchwork-housekeeping@kernel.org>
Date: Mon, 15 Dec 2025 13:56:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller (2025-12-15T13:23:46)
  Superseding: [v2] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller (2025-12-10T09:04:29):
    [V2,1/3] dt-bindings: spi: Add support for ATCSPI200 SPI controller
    [V2,2/3] spi: atcspi200: Add ATCSPI200 SPI controller driver
    [V2,3/3] MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


