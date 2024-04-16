Return-Path: <linux-spi+bounces-2380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88A8A71BF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB59B1F2262D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F512AAE3;
	Tue, 16 Apr 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0hyUXJI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D07764E
	for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286601; cv=none; b=Zlia7NUygR9ot56WZVKLfCTGeT1gThtRt1pa2djHtgsKZlm8W9PhVMDFrygxYEL9ZI2v7VunrGzQgTXXD5xsQnkNU0e29nQU/ntcenRs6cOq1UWgFMYUgE5QWGcpAwTZYPByQcSqo6PYxIta0c9vZmUarve/3Yr+nCeL2rbC0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286601; c=relaxed/simple;
	bh=ZCzFYq0coyhISVfVxWKzCQ2hB1rkUU12zNX/YozYEkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W2feuNi9a0wn5bUQb3HeNS6rH90625mFGAP/7NgkAjbcFp9KAlrhdKYdpI0x647hRVij8hKN5/u6CQkap5igV6ErV7SPYuJfPKYc/igM7Lxu3LStYWH01dTwFqM3LPuSrCdBma8+QqHqdc4Fqp2ZSNu27Zv7Eu6JzrVYNY36kTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0hyUXJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B16CC113CE;
	Tue, 16 Apr 2024 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286600;
	bh=ZCzFYq0coyhISVfVxWKzCQ2hB1rkUU12zNX/YozYEkU=;
	h=Subject:From:Date:To:From;
	b=n0hyUXJITEnAr3IcwlwY11+10M136VRVyREGHCw8C1n52ZMXQU1wnSj7VGhtkUVtX
	 sc7aCxf0JQx6dt2KHCNCINaajXsyfgESMQ+eOenqwiAu+lw/xh5n2QPAtkTOh1K2TD
	 waPOycX8hoT8sGezu7EuY+4blA5lkEgzb/Ap/AAwuSKGq7lzk0mzEyw9tdk2vk6VDn
	 cwFE+ECfnOhKxgn9iRrteU1hpKtMEMEF2rABbQ7mwZJNiy6PilfD7q3DrmPYZkxxZ4
	 tI+xuZmj2mLuAjKKdGlDy5x/HxQhjJUbS0WmeVmTDN5RYdQLycO4MgboMjR8ofSW+I
	 pcck590yU+rRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 846D0C4166F;
	Tue, 16 Apr 2024 16:56:40 +0000 (UTC)
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
 <171328660053.15715.12577256840887347065.git-patchwork-housekeeping@kernel.org>
Date: Tue, 16 Apr 2024 16:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dw: Auto-detect number of native CS (2024-04-16T15:52:30)
  Superseding: [v2] spi: dw: Auto-detect number of native CS (2024-02-22T17:28:43):
    [v2,1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
    [v2,2/4] spi: dw: Add a number of native CS auto-detection
    [v2,3/4] spi: dw: Convert dw_spi::num_cs to u32
    [v2,4/4] spi: dw: Drop default number of CS setting


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


