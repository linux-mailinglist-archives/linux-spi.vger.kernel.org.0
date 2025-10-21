Return-Path: <linux-spi+bounces-10759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF0BF7354
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C650619C1A50
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A9340A4E;
	Tue, 21 Oct 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaWSLK/0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90E340284
	for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058625; cv=none; b=Tk4ubn9M7UAWNYfKAyq755o9jPKjeGi+eqn1kQKP0zOgchGiY6mKS7Ffz+qsBzsKsODY8cVQeZdD/MUH/Po7HRuyNKB+oqvm+z0oNKQg7kHgeV1JYZshDo8YD+Q+eN3x3lJbGkDQS/ovmVimn62LPOXinDHCvD6k5JPFTNticFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058625; c=relaxed/simple;
	bh=Mw8Um7P2GsnciWhm1wXNl/ZF3/FdJDpFGwO6sFTAzdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jSTLfeO7Ow2kFm4zQ+7ZcDCkNO6cajq3XQ5She4ngsnx9spXcBnJ2XXhqxbt3/PViIV3Tabwv1XOhNaoyAmmXpDPrTxDsK94+N2GJZqDVXWipUWmuNwPuAD2fboWs5UpOIf4pg7Seh8fsD6JP+bFnynVzs1LMBbS/m2opvsVV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaWSLK/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4CDC116C6;
	Tue, 21 Oct 2025 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058625;
	bh=Mw8Um7P2GsnciWhm1wXNl/ZF3/FdJDpFGwO6sFTAzdk=;
	h=Subject:From:Date:To:From;
	b=BaWSLK/06q8c080ADz0iUhBK9sWGHNwjTOx4K/2ypGm0iG8MHzWuYkpMvAc35PkxO
	 GT8e3IyLmHkAKD2xbsHzSm17zbP+HhIxuy2a+TMHW0llaPMuiCTeSGsOq+7DP2VYJq
	 l9rSG5bOyshPsRcAI6/9fSmEQv6JkWcZpLeXYlFZCWQK7RaOZtE5JxK7LzkQaJkXpq
	 rdbOd6WT1h4hzdaZjkbudIllwHoU0hgFtVrdMMMW4m1EsunjOL0j92JE4JcQwUSsJG
	 PLkUd+8MA9oIBEl5FUWuPM7l6SZkEu4OfAd2wUZJplgQpzFVUSsIF6rSj7pfpY22qU
	 XI2A64HR2t9tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710433A55F8A;
	Tue, 21 Oct 2025 14:56:48 +0000 (UTC)
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
 <176105860713.1113752.11903771682065860771.git-patchwork-housekeeping@kernel.org>
Date: Tue, 21 Oct 2025 14:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mem: Trace exec_op (2025-10-21T14:47:03)
  Superseding: [v1] spi: spi-mem: Trace exec_op (2025-10-20T19:03:33):
    spi: spi-mem: Trace exec_op


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


