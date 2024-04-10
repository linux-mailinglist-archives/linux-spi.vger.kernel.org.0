Return-Path: <linux-spi+bounces-2283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33EC89EF52
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 11:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB00E283688
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7213159568;
	Wed, 10 Apr 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5J50X9n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B2159566
	for <linux-spi@vger.kernel.org>; Wed, 10 Apr 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742998; cv=none; b=Yx7UhksILV4/k2LlNVJEUonkn7EbPtlvvOUb1A8DkSBuStfNp/njvH7UBc2LYAItgR9rjHDMpScScsIPxpdcoemi2LUhbKxEb4XyWveJFC+8V50CFKzB6cYDswkyoKLNYPxb3kAytAxWRcuYCqwNTja5x6MM82aaiWc5NzqR0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742998; c=relaxed/simple;
	bh=ZHDEFWLg7kIrXx2o0epx/S21kefjkQK3XF0oCcFGtMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XU0WyrYfF+juoT2PG/kgf2+vaaByEFI9A9sqTppEh/pW296i8u8Qd+5uTGV2qA69xQ3t/OJ6f5bDWhuvbnKf6mL93Dyn77ns9ixObzEh1TcsLt/QEOIKG/nucTcMXDmIZpQQeGleVR+x1dsSTkbAZ0MBu6iZ23NU0tOGR8XHKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5J50X9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC2D9C433C7;
	Wed, 10 Apr 2024 09:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742998;
	bh=ZHDEFWLg7kIrXx2o0epx/S21kefjkQK3XF0oCcFGtMA=;
	h=Subject:From:Date:To:From;
	b=n5J50X9n6FTpXRcKYxLQesrL1GarV5PKWToFO+AUO0FtmL3dadL+P8JiS8Ql2ek2T
	 iLImze0UsxnSNjQFC5+GfB1ZcZGnNovBH+JLS5KWTtfSsRHcq/d48t0HfatrYv1tfs
	 gJSLHbNGVBwly01Pj3yDjFjMKIrBk/0nECOwHniO+lDOLg2/7vWdJBxwcXJFBnjcxS
	 AvynJxM5fAin93JnFYBKiCamuGDJALW+6Q82ESIsREHbw/6klcXc5Xi6iUDV5AUwko
	 foPtaTP2bW7Bk6sWx4O03tSjUGeeiSibW9M8ux1h7SR4nd3nYQnNbgGAQG71f9Zy1f
	 lG3ofWVJlXelQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7C15D6030E;
	Wed, 10 Apr 2024 09:56:37 +0000 (UTC)
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
 <171274299787.16559.15322291129676196183.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Apr 2024 09:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-04-10T09:29:06)
  Superseding: [v2] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-04-05T15:02:10):
    [v2,01/11] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
    [v2,02/11] spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
    [v2,03/11] spi: cadence-qspi: allow building for MIPS
    [v2,04/11] spi: cadence-qspi: store device data pointer in private struct
    [v2,05/11] spi: cadence-qspi: add FIFO depth detection quirk
    [v2,06/11] spi: cadence-qspi: minimise register accesses on each op if !DTR
    [v2,07/11] spi: cadence-qspi: add no-IRQ mode to indirect reads
    [v2,08/11] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
    [v2,09/11] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
    [v2,10/11] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
    [v2,11/11] MIPS: mobileye: eyeq5: add octal flash node to eval board DTS


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


