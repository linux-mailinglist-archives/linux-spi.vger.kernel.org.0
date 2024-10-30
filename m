Return-Path: <linux-spi+bounces-5569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0A9B6D2F
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0911C21664
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5B1D0B81;
	Wed, 30 Oct 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuAeij9Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D89199EAB
	for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318185; cv=none; b=A5w+rdPPy/7KrlWoTPqmKYE1jUr2MN6TxnQOFbu2VQcYSlsykywOcpFe6WgT6qoZpFY8fOIwPfg1DuID3bSElpE2oYQC9mj9ZsIEOfjiKxtWGpMZaV7X+8h6JhB8BaUZDlh5Z9ZsuZ5zj3S9v2lwBeVCvm2qGWTFsom45Eea0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318185; c=relaxed/simple;
	bh=uJw8r8EtWmc55qVc9Os1C7qMuYpnFrM3cCSRJeYEG9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gBD66u8sK46NPkjPVeXZ4y92S69swFtrBZzh/gM26NWuvGT2tqWpNyz8dlQPFggv3RQRCzLwMKvEBlNSUZxQ4C/hL4+AHZdifZzMmZLamNrJ/oCZIqYMnU0tZQ29TfqpdoUGzz+TPGl3rciKLEz1bCDyT1M+0syJz1EesKt74s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuAeij9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C9FC4CECE;
	Wed, 30 Oct 2024 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730318185;
	bh=uJw8r8EtWmc55qVc9Os1C7qMuYpnFrM3cCSRJeYEG9s=;
	h=Subject:From:Date:To:From;
	b=TuAeij9Y+HMVwiVvcO31cHnS/Mih2+G8GnhDxVhPuXn5pLAnB73tbUCv93Wq6Otc0
	 UFqZA9tcg/i430oLExAYkmdbYxTJBuvAE40nXueYiyHvnQk80FRVAIeLHeoPiJhKux
	 5RyN9OgDFzICkawaETnRwSb8EMXTqT1H1Rcoe0njmvbAb4Dw3etnd7tAekrMvQ2VlD
	 +BcH1S/02xUiARjw11zdU+sRLCkwX1M0nRi6WXtRiGDywNcqz0JlLUs+emR9NDRmfR
	 ovv4Too0XxfTbPfB1TOvrTgGKa1wrI1ZS386TEiMlVOMb7FV/6BC8FJTr6gibwtFBL
	 D78ry5zE5V6Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB791380AC22;
	Wed, 30 Oct 2024 19:56:33 +0000 (UTC)
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
 <173031819252.1445800.5087294522054252301.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Oct 2024 19:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mem: rtl-snand: Correctly handle DMA transfers (2024-10-30T19:49:20)
  Superseding: [v1] spi: spi-mem: rtl-snand: Correctly handle DMA transfers (2024-10-29T21:51:59):
    spi: spi-mem: rtl-snand: Correctly handle DMA transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


