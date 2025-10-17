Return-Path: <linux-spi+bounces-10715-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC1BEB3A3
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5812407AF9
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095B3074B7;
	Fri, 17 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjyRa5uG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A9257831
	for <linux-spi@vger.kernel.org>; Fri, 17 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725821; cv=none; b=q55lI+IzEJXphFraIKtbCFzAoK6g+YtoOBrWbr7Z/ZbIVqfh2Yc35QRNlq2V5zjAJllEZMOoICd8RAqQsXUR1X1qvL59NnpQ7TlK4EVuDxEyaBCsKqphx7hUO97E49cKYOAqz3vNPfm8TXkwrB+xhzQj1NSYVAu5Hi8RffbH4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725821; c=relaxed/simple;
	bh=RCI63rrKTMmsM5PawyFqNs40aGURAbpEbaNY+ML2vF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iCk6Y4MrYZdyX5m12M+dUWFDWaI1KuNJbyJGza2g+VNlE9XMOU+qgFeZzo11CtsPq6HdRqHYr4yhQ3maothg/rt9ih4n1Q9Hp7OrwiGplrBato5GmTk7XFJtOz8AZXvSEariaqtVFj/UmDNgl350/1c3GBk3Fzj6gOlomcby5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjyRa5uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170AAC4CEE7;
	Fri, 17 Oct 2025 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725821;
	bh=RCI63rrKTMmsM5PawyFqNs40aGURAbpEbaNY+ML2vF4=;
	h=Subject:From:Date:To:From;
	b=HjyRa5uG61cPCSGiQ5OrFhjSQ5KistzVk46gxrwbVe51oMyLNbrlW8DuZPUM77txJ
	 CKyeOxLjxbNL6lKff8bBXOQiNGWDAKmCnDM7svH/ScUktF71MOaWXtjeK8fGuxZt/t
	 OtnIEEvhxH9RefEtQtveR3zQBp3uDqPmNAhKl/4RpcTx2QS9+uWWcPBK6XvKuDsrTp
	 jKm0mKJy586tN/vVT1LDesRvNjV8a5uw5xkWGfyxRb5ncYeJ0MWRkLyHHcSIQBMT0p
	 xfkcyOq7o/77o/mzXW+J6V1sbgZV5N31fThZ2kY49M5adJvo3VGDUBd9z5E600V9nZ
	 iiVGIp5ImDg+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1B2E39EFA57;
	Fri, 17 Oct 2025 18:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176072580417.2741459.3516285740308160267.git-patchwork-summary@kernel.org>
Date: Fri, 17 Oct 2025 18:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1012964
  Lore link: https://lore.kernel.org/r/aPJpEnfK31pHz8_w@stanley.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



