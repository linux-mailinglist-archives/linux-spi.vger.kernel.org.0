Return-Path: <linux-spi+bounces-8900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048DAEDC25
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C60218976EF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9C27F75C;
	Mon, 30 Jun 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPyCJI7y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D027F73A
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284717; cv=none; b=DYypQbB2+/8oiuaIAjVZ0FIBJM4GHqmZbcgvhG928LkdvCb9Z5iMtIt9jt6aYv4A94S5qoSxXFju8vgNkWbO/1Q3sbjJtYm9XYYVtnUzTni/hWTevsr5pUIfJipxhqfLAShzSWHkAh6//4KTETUde+RUFg72fIIltOJUrN2w6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284717; c=relaxed/simple;
	bh=eyFRLCHyobKwCA6+3p1lZ/AJsZLD+PL8yHplMK1AsAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lTH8FnfbtyMTsr8qtcM1cBTdQEMMHSqM1bpNjPgCtCqPZakdsDDalK10VBTA+mq+hNTdi+duBPXmrVgbwurU69+WmHNJho8tZ4eEvkTckgs2llL7qZ0/ProGrMyNStXDpwUbwt7LhkZlbkuz+xoZsAVGX0loji9DSl8E/mNTNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPyCJI7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E3CC4CEE3;
	Mon, 30 Jun 2025 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284716;
	bh=eyFRLCHyobKwCA6+3p1lZ/AJsZLD+PL8yHplMK1AsAk=;
	h=Subject:From:Date:To:From;
	b=lPyCJI7y2nb9ys846Q2O4NyJXGX7n1VU0jqgD00jInF4+39CPhIfS91g/rJTyHluZ
	 SF64FEMr7yoK4nch5v742l8cfkXcnGF1QqzxyEzR6Y4Ur1/XGpljT6czwiAp1Jt8u7
	 OtZ03/dZHnf0A93Hc39s74hbaGqk/8njAdcBWn63lrjovpPb0QK7Xkb5ELe14dibhc
	 4bATN1JrIek/Xo2395mY13uYNBXlZqJF27BhuB7Hp/vmldJseTdsq87Wbc33APMXIV
	 5zqWkWTYIkS8ZooLO41pfIWR5Igz2P3VlwigDElIYWaXO7QHNxMmx+QISoIsE2UCTQ
	 GQrrn15N1Cy1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 371DA383BA00;
	Mon, 30 Jun 2025 11:59:03 +0000 (UTC)
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
 <175128474188.3352835.18442787739378457172.git-patchwork-housekeeping@kernel.org>
Date: Mon, 30 Jun 2025 11:59:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths (2025-06-30T11:00:35)
  Superseding: [v1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths (2025-06-30T09:11:56):
    [1/1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


