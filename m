Return-Path: <linux-spi+bounces-3567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84091585E
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE201F2640B
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A801A072D;
	Mon, 24 Jun 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8hEiEgb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622F45010
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262628; cv=none; b=ZNnf9brUa1CL9wHii/3ifWe72UmEws8LWi7R4WQ29DG4153yfcVJHhd+byAk6S40lSWK73HC8+vRldrCiRR1r6Pb7s7s73TRf3jvbM6dTmnk7heFAdwX3ILY9OlUvw6SYwDL4Lek62jifwuanf4C4z5wwaSLLhp5HRfafIegNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262628; c=relaxed/simple;
	bh=98XqRIFvJwcT2UmI1IDhpnuwJqK4xHtsUFZzNcvdaeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BaHtvbSOiZmFZ8tz9lUp04HTn697V8GKNITmWSp8b8cvyrs4kkAgdUD6QxKBca5nKRJDHV3P+0yR5JEah/EWf2ivylJjB1aUoYFMI1Y2PRHCIOHuQFDeBB65xmqKtgTyV7M3lOU04E4RLY5A7KpgyAljzxwoQ6ISjq0o2lOtiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8hEiEgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98CDEC2BBFC;
	Mon, 24 Jun 2024 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719262627;
	bh=98XqRIFvJwcT2UmI1IDhpnuwJqK4xHtsUFZzNcvdaeU=;
	h=Subject:From:Date:To:From;
	b=I8hEiEgbHqrfxsNq/vnabTP3sdGHy3nPiRLw06jVF35Jt1LDjVz/Ue28hwDn0eMeA
	 rH0zMMZwlFYznRpZxn2+XONmuwytTLE2p83S6ICvn5Ia64Jdg8zR1n8tXnm14buysq
	 ymKA7BNMlj9FAm7GR3dxg571wHgvXY8PrghwrpSU6Y/DVkwvnX4OWSqMuNr/k767h8
	 /aRE2gXZRmdN2+KnZaELUqEb3Udme0d3TvdpC3Wcj46tuluMcLs9kBejYaEPlI5TIZ
	 UuvXGFeGiNdS7+E0/o5+4pIAaLvWLVoMdALOxjHzwVn5qyWqBpeXEANi46bnHFeQvR
	 pZBC91BB0yaGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85FE4C4166E;
	Mon, 24 Jun 2024 20:57:07 +0000 (UTC)
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
 <171926262754.2262.7254517244673121930.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Jun 2024 20:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add devm_spi_optimize_message() helper (2024-06-24T20:46:06)
  Superseding: [v1] spi: add devm_spi_optimize_message() helper (2024-06-21T20:51:30):
    [1/3] Documentation: devres: add missing SPI helpers
    [2/3] spi: add devm_spi_optimize_message() helper
    [3/3] iio: adc: ad7944: use devm_spi_optimize_message()
  Superseding: [v2] spi: add devm_spi_optimize_message() helper (2024-06-24T20:10:30):
    [v2,1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
    [v2,2/2] iio: adc: ad7944: use devm_spi_optimize_message()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


